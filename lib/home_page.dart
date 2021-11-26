import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: MaterialButton(
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.red,
          child: const Text(
                      'Log out',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
        ),
      ),
    );
  }
}

class LoginError extends StatelessWidget {
  const LoginError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: MaterialButton(
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.red,
          child: const Text(
                      'Please Try Again',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
        ),
      ),
    );
  }
}