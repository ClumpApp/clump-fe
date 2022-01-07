// ignore_for_file: avoid_unnecessary_containers

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../group/message_details.dart';
import '../group/user_details.dart';
import '../util/client.dart';
import '../constants.dart';
import '../page_contents/selectable_items.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String newMessage = "";
  String username = "Loading";
  var msgController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void initState() {
    getMessages().then((value) => setState(() {
          messageList;
        }));
    getUserNames().then((value) => setState(() {
          userList;
        }));
    Client.instance.get(endpoint: '/users/me').then((value) => setState(() {
          username = value['UserName'];
        }));
    var channel = WebSocketChannel.connect(
      Uri.parse(Client.instance.getWSAddress()),
    );
    channel.stream.listen((event) {
      var newMessage = jsonDecode(event);
      messageList.add(Message.fromJson(newMessage));
      setState(() {
        messageList;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      _scrollController.jumpTo((_scrollController.position.maxScrollExtent));
    });
    return Scaffold(
      body: Container(
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.25,
                decoration: const BoxDecoration(color: darkGrey),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                      child: CircleAvatar(
                        backgroundColor: Colors.grey.shade500,
                        radius: 3 * (MediaQuery.of(context).size.width) / 60,
                        child: Icon(
                          Icons.group,
                          size: (3 * (MediaQuery.of(context).size.width) / 60),
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: userList.length,
                        itemBuilder: (BuildContext context, int i) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Card(
                              color: Colors.grey.shade500,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  ListTile(
                                    title: Text(userList[i]),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Card(
                        color: Colors.grey.shade500,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              title: Text(username),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                TextButton(
                                  child: const Text('Log out'),
                                  onPressed: () {/* TODO */},
                                ),
                              ],
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
              flex: 13,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.25,
                decoration: const BoxDecoration(color: darkPurple),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        controller: _scrollController,
                        itemCount: messageList.length,
                        itemBuilder: (BuildContext context, int i) {
                          return MessageBubble(
                              message: messageList[i], press: () => {});
                        },
                        separatorBuilder: (context, index) {
                          return const Divider(
                            thickness: 2,
                          );
                        },
                        /*
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(
                          color: Colors.grey,
                        ),*/
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.25,
                      decoration: const BoxDecoration(color: darkOrange),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        margin: const EdgeInsets.all(20),
                        padding: const EdgeInsets.only(
                            left: 10, bottom: 10, top: 10),
                        height: 55,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: <Widget>[
                            PopupMenuButton<SelectableItem>(
                              icon: const Icon(Icons.add),
                              onSelected: (item) => selectedType(context, item),
                              itemBuilder: (context) => [
                                ...popUpItems.popupContents
                                    .map(buildItem)
                                    .toList(),
                              ],
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: TextField(
                                onChanged: (str) {
                                  newMessage = str;
                                },
                                controller: msgController,
                                decoration: InputDecoration(
                                    fillColor: Colors.grey.shade300,
                                    contentPadding:
                                        const EdgeInsets.only(bottom: 15),
                                    hintText: "Message",
                                    hintStyle:
                                        TextStyle(color: Colors.grey.shade600),
                                    border: InputBorder.none),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            FloatingActionButton(
                              onPressed: () {
                                if (newMessage != "") {
                                  /*Message mesToList = Message(
                                      uuid: "my message uuid",
                                      user_name: "demo user",
                                      message_type: 1,
                                      message_string: newMessage,
                                      send_time: DateTime.now());
                                  setState(() {
                                    messageList.add(mesToList);
                                  });*/
                                  var newMessageMap = {"message": newMessage};

                                  Client.instance.post(
                                      data: newMessageMap,
                                      endpoint: '/messages');

                                  msgController.clear();
                                }
                              },
                              child: Icon(
                                Icons.send,
                                color: Colors.grey.shade300,
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
          ],
        ),
      ),
    );
  }

  PopupMenuItem<SelectableItem> buildItem(SelectableItem item) =>
      PopupMenuItem<SelectableItem>(
        value: item,
        child: Row(
          children: [
            Icon(item.icon, color: Colors.black),
            Text(item.text),
          ],
        ),
      );

  selectedType(BuildContext context, SelectableItem item) {
    switch (item) {
      case popUpItems.photo:
        print("photo action");
        break;
      case popUpItems.video:
        print("video action");
        break;
      case popUpItems.recording:
        print("recording action");
        break;
      case popUpItems.document:
        print("file action");
        break;
    }
  }
}
