import 'dart:convert';
import 'dart:io';
import 'package:http/browser_client.dart';

const _baseURL = 'https://clump-be.azurewebsites.net';
const _baseWS = 'wss://clump-be.azurewebsites.net';
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
    //return true;
    var response = await _client.post(Uri.parse(_baseURL + '/account/login'),
        body: jsonEncode({'Username': username, 'Password': password}),
        headers: headers);

    if (response.statusCode != 200) {
      return false;
    }

    _saveToken(response.body);

    return true;
  }

  Future<bool> signup(
      {required String email,
      required String username,
      required String password}) async {
    var response = await _client.post(Uri.parse(_baseURL + '/account/signup'),
        body: jsonEncode(
            {'Username': username, 'Password': password, 'Email': email}),
        headers: headers);

    if (response.statusCode != 200) {
      return false;
    }

    _saveToken(response.body);

    return true;
  }

  Future<Map<String, dynamic>> get({required String endpoint}) async {
    if (endpoint == '/users/me') return jsonDecode(user);
    var response = await _client.get(Uri.parse(_baseURL + _baseAPI + endpoint),
        headers: headers);

    if (response.statusCode != 200) {
      throw Exception("Error while fetching data");
    }
    return jsonDecode(response.body);
  }

  Future<List<dynamic>> getAll({required String endpoint}) async {
    //if (endpoint == '/users') return jsonDecode(users);
    //if (endpoint == '/messages') return jsonDecode(messages);
    var response = await _client.get(Uri.parse(_baseURL + _baseAPI + endpoint),
        headers: headers);

    if (response.statusCode != 200) {
      throw Exception("Error while fetching data");
    }
    return jsonDecode(response.body);
  }

  Future<bool> post(
      {required Map<String, dynamic> data, required String endpoint}) async {
    var response = await _client.post(Uri.parse(_baseURL + _baseAPI + endpoint),
        body: jsonEncode(data), headers: headers);

    if (response.statusCode != 201) {
      return false;
    }
    return true;
  }

  Future<bool> postAll(
      {required List<Map<String, dynamic>> data,
      required String endpoint}) async {
    var response = await _client.post(Uri.parse(_baseURL + _baseAPI + endpoint),
        body: jsonEncode(data), headers: headers);

    if (response.statusCode != 201) {
      return false;
    }
    return true;
  }

  void resetClient() {
    headers = {HttpHeaders.contentTypeHeader: ContentType.json.toString()};
  }

  String getWSAddress() {
    return _baseWS + _baseAPI + "/ws/messages" + "?token=" + _token;
  }
}

final messages = '''
[
  {
    "uuid": "b1549ebf-d422-4248-b51b-9c08a37affe7",
    "username": "ozi",
    "type": 1,
    "messagestr": "Hi Apo",
    "date": "2021-12-24T05:01:59.675633+03:00"
  },
  {
    "uuid": "a39b5c10-47ae-465e-a0f8-68f29261b9b0",
    "username": "ozi",
    "type": 1,
    "messagestr": "Hello from rest!",
    "date": "2021-12-24T09:01:30.719824+03:00"
  },
  {
    "uuid": "7ffe8b72-7d1a-434d-897f-f80f925a660c",
    "username": "ozi",
    "type": 1,
    "messagestr": "Demo",
    "date": "2021-12-24T16:34:37.189991+03:00"
  },
  {
    "uuid": "e5d0f1cc-927f-44a8-bb86-80c8ed917f7f",
    "username": "ozi",
    "type": 1,
    "messagestr": "Trying delegate",
    "date": "2021-12-29T04:24:13.416357+03:00"
  },
  {
    "uuid": "69989f4c-730c-4993-97f7-21ea9431c1a8",
    "username": "ozi",
    "type": 1,
    "messagestr": "Trying delegate 2",
    "date": "2021-12-29T04:28:32.148917+03:00"
  },
  {
    "uuid": "58d1c950-7bd0-4dca-bdd6-63464ace67d2",
    "username": "ozi",
    "type": 1,
    "messagestr": "Trying delegate 3",
    "date": "2021-12-29T04:32:23.22162+03:00"
  },
  {
    "uuid": "944bd605-9355-4897-b3bb-daf2258a5227",
    "username": "ozi",
    "type": 1,
    "messagestr": "I am using web",
    "date": "2022-01-06T04:03:02.744772+03:00"
  }
]
''';

final users = '''
[
  {
    "UserName": "ozi",
    "UserMail": "o@clump",
    "ProfilePicture": ""
  },
  {
    "UserName": "demo2",
    "UserMail": "demo2@example.com",
    "ProfilePicture": ""
  }
]
''';

final user = '''
{
  "UserName": "ozi",
  "UserMail": "o@clump",
  "ProfilePicture": ""
}
''';
