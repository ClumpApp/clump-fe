import 'dart:convert';
import 'dart:io';
import 'package:clump_initial/pages/signup_register.dart';
import 'package:http/browser_client.dart';
import 'package:uuid/uuid.dart';
import '../group/message_details.dart';

const _baseURL = 'https://clump-be.azurewebsites.net';
const _baseAPI = '/api/v1';
const _authScheme = 'Bearer ';

List dummyMessages = [
  Message(
      user_name: "Abdullah Coşgun",
      message_type: 2,
      message_string: "Hi guys, how are you doing lately?",
      send_time: "Ahmet O'Clock"),
  Message(
      user_name: "Ahmet Coşgun",
      message_type: 2,
      message_string: "I am not good?",
      send_time: "Ahmet O'Clock"),
  Message(
      user_name: "Emre Coşgun",
      message_type: 2,
      message_string: "Dude guess who I married",
      send_time: "Ahmet O'Clock"),
];

class Client {
  static final Client _instance = Client._privateConstructor();

  Client._privateConstructor();

  static Client get instance => _instance;

  final BrowserClient _client = BrowserClient()..withCredentials = true;
  Map<String, String> headers = {};

  void _saveToken(body) {
    headers[HttpHeaders.authorizationHeader] = _authScheme + body;
  }

  Future<bool> login(
      {required String username, required String password}) async {
    /*var response = await _client.post(Uri.parse(_baseURL + '/login'),
        body: {'UserName': username, 'Password': password}, headers: headers);

    if (response.statusCode != 200) {
      return false;
    }

    _saveToken(response.body); */
    return Future.delayed(const Duration(seconds: 2), () => true);
  }

  Future<bool> signup(
      {required String username, required String password}) async {
    var response = await _client.post(Uri.parse(_baseURL + '/signup/register'),
        body: {'UserName': username, 'Password': password, 'Email': email},
        headers: headers);

    if (response.statusCode != 200) {
      return false;
    }

    _saveToken(response.body);
    return true;
  }

  Future<Map<String, dynamic>> get({required String endpoint}) async {
    var response = await _client.get(Uri.parse(_baseURL + _baseAPI + endpoint),
        headers: headers);

    if (response.statusCode != 200) {
      throw Exception("Error while fetching data");
    }
    return jsonDecode(response.body);
  }

  Future<List<Map<String, dynamic>>> getAll({required String endpoint}) async {
    /* var response = await _client.get(Uri.parse(_baseURL + _baseAPI + endpoint),
        headers: headers);

    if (response.statusCode != 200) {
      throw Exception("Error while fetching data");
    } */
    //return jsonDecode(response.body);
    String a = json.encode(dummyMessages);
    print(a);
    print("ahmet");
    dynamic b = jsonDecode(a);
    return Future.delayed(const Duration(seconds: 2),
        () => b);
  }
}
