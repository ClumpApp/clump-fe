import 'dart:convert';
import 'dart:html';
import 'dart:io';
import 'package:http/browser_client.dart';
import 'package:http/http.dart';

const _baseAPI = '/api/v1';
const _authScheme = 'Bearer ';

class Client {
  static final Client _instance = Client._privateConstructor();

  Client._privateConstructor();

  static Client get instance => _instance;

  final BrowserClient _client = BrowserClient()..withCredentials = true;
  Map<String, String> headers = {
    HttpHeaders.contentTypeHeader: ContentType.json.toString()
  };

  String _token = '';

  void _saveToken(body) {
    _token = body;
    headers[HttpHeaders.authorizationHeader] = _authScheme + _token;
  }

  Future<bool> login(
      {required String username, required String password}) async {
    var response = await _client.post(Uri.parse('/account/login'),
        body: jsonEncode({'Username': username, 'Password': password}),
        headers: headers);

    if (response.statusCode != HttpStatus.ok) {
      return false;
    }

    _saveToken(response.body);

    return true;
  }

  Future<bool> signup(
      {required String email,
      required String username,
      required String password}) async {
    var response = await _client.post(Uri.parse('/account/signup'),
        body: jsonEncode(
            {'Username': username, 'Password': password, 'Email': email}),
        headers: headers);

    if (response.statusCode != HttpStatus.ok) {
      return false;
    }

    _saveToken(response.body);

    return true;
  }

  Future<Map<String, dynamic>> get({required String endpoint}) async {
    var response =
        await _client.get(Uri.parse(_baseAPI + endpoint), headers: headers);

    if (response.statusCode != HttpStatus.ok) {
      throw Exception("Error while fetching data");
    }
    return jsonDecode(response.body);
  }

  Future<List<dynamic>> getAll({required String endpoint}) async {
    var response =
        await _client.get(Uri.parse(_baseAPI + endpoint), headers: headers);

    if (response.statusCode != HttpStatus.ok) {
      throw Exception("Error while fetching data");
    }
    return jsonDecode(response.body);
  }

  Future<bool> post(
      {required Map<String, dynamic> data, required String endpoint}) async {
    var response = await _client.post(Uri.parse(_baseAPI + endpoint),
        body: jsonEncode(data), headers: headers);

    if (response.statusCode != HttpStatus.created) {
      return false;
    }
    return true;
  }

  Future<bool> postAll(
      {required List<Map<String, dynamic>> data,
      required String endpoint}) async {
    var response = await _client.post(Uri.parse(_baseAPI + endpoint),
        body: jsonEncode(data), headers: headers);

    if (response.statusCode != HttpStatus.created) {
      return false;
    }
    return true;
  }

  Future<bool> uploadFile(
      String endpoint, List<int> bytes, String filename) async {
    var request =
        MultipartRequest("POST", Uri.parse(_baseAPI + "/messages/" + endpoint));
    request.headers[HttpHeaders.authorizationHeader] =
        headers[HttpHeaders.authorizationHeader]!;
    var file = MultipartFile.fromBytes(endpoint, bytes, filename: filename);
    request.files.add(file);
    var res = await request.send();
    return res.statusCode == HttpStatus.ok;
  }

  void resetClient() {
    headers = {HttpHeaders.contentTypeHeader: ContentType.json.toString()};
  }

  Uri getWSAddress() {
    return Uri(
        scheme: "wss",
        host: window.location.hostname,
        path: "/ws/messages",
        queryParameters: {"token": _token});
  }
}
