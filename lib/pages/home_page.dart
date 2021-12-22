// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import '../group/message_details.dart';
import '../util/client.dart';
import '../constants.dart';

enum FileOptions { photo, video, voiceRecording, document }

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
                    Container(
                      width: MediaQuery.of(context).size.width * 0.25,
                      decoration:
                          const BoxDecoration(color: Colors.greenAccent),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        padding: const EdgeInsets.only(
                            left: 10, bottom: 10, top: 10),
                        height: 60,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: <Widget>[
                            PopupMenuButton<FileOptions>(
                              onSelected: (FileOptions result) {},
                              icon: const Icon(Icons.add),
                              itemBuilder: (BuildContext context) =>
                                  <PopupMenuEntry<FileOptions>>[
                                const PopupMenuItem<FileOptions>(
                                  value: FileOptions.photo,
                                  child: Icon(Icons.insert_photo),
                                ),
                                const PopupMenuItem<FileOptions>(
                                  value: FileOptions.video,
                                  child: Icon(Icons.videocam),
                                ),
                                const PopupMenuItem<FileOptions>(
                                  value: FileOptions.voiceRecording,
                                  child: Icon(Icons.keyboard_voice),
                                ),
                                const PopupMenuItem<FileOptions>(
                                  value: FileOptions.document,
                                  child: Icon(Icons.insert_drive_file),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            const Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                    hintText: "Message",
                                    hintStyle: TextStyle(color: Colors.black54),
                                    border: InputBorder.none),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            FloatingActionButton(
                              onPressed: () {},
                              child: const Icon(
                                Icons.send,
                                color: Colors.white,
                                size: 18,
                              ),
                              backgroundColor: themeColor,
                              elevation: 0,
                            ),
                          ],
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
                decoration: const BoxDecoration(color: Colors.blue),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        radius: ((MediaQuery.of(context).size.width) * 0.05),
                      ),
                      const Text('Abdullah Coşgun'),
                      MaterialButton(
                        onPressed: () => Client.instance
                            .get(endpoint: '/users')
                            .then((value) => print(value)),
                      ),
                      const Card(),
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
