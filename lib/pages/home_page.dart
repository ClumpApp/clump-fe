// ignore_for_file: avoid_unnecessary_containers

import 'dart:convert';
import 'package:flutter/material.dart';
import '../group/message_details.dart';
import 'package:http/http.dart';
import '../constants.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.25,
                decoration: BoxDecoration(color: Colors.greenAccent),
                child: Column(),
              ),
            ),
            Expanded(
              flex: 7,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.25,
                decoration: BoxDecoration(color: Colors.yellow),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: sampleMessages.length,
                        itemBuilder: (context, index) => MessageBubble(
                          message: sampleMessages[index],
                          press: () {},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.25,
                decoration: BoxDecoration(color: Colors.blue),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        radius: ((MediaQuery.of(context).size.width) * 0.05),
                      ),
                      Text('Abdullah Coşgun'),
                      Card(),
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
