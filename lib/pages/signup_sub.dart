import 'package:clump_initial/pages/login_page.dart';
import 'package:flutter/material.dart';
import '../util/client.dart';
import 'signup_main.dart';
import '../constants.dart';

String username = '';
String password = '';
String email = '';
bool failedSignUp = false;

class SignUpSub extends StatelessWidget {
  const SignUpSub({Key? key}) : super(key: key); //, required String title

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/backgrounds/Clump BG_empty.png"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
