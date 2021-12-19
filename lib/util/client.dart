import 'dart:io';
import 'package:http/browser_client.dart';

const _baseURL = 'https://clump-be.azurewebsites.net';
const _baseAPI = '/api/v1';
const _authScheme = 'Bearer ';

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
    var response = await _client.post(Uri.parse(_baseURL + '/login'),
        body: {'UserName': username, 'Password': password}, headers: headers);

    if (response.statusCode != 200) {
      return false;
    }

    _saveToken(response.body);
    return true;
  }

  Future<String> get({required String endpoint}) async {
    var response = await _client.get(Uri.parse(_baseURL + _baseAPI + endpoint),
        headers: headers);

    if (response.statusCode != 200) {
      throw Exception("Error while fetching data");
    }
    return response.body;
  }
}