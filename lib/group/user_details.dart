import 'package:flutter/material.dart';
import '../util/client.dart';

class User {
  final String user_name;
  final String e_mail;
  final String profile_pic;



  User({
    required this.user_name,
    required this.e_mail,
    required this.profile_pic,
  });
}

String getUserName(Map<String, dynamic> json) {
    return json['UserName'].toString();
    
  }

List<String> userList = [];

Future<bool> getUserNames() async {
  var users = await Client.instance.getAll(endpoint: "/users");

  for (var userJSON in users) {
    userList.add(getUserName(userJSON));
  }
  return true;
}