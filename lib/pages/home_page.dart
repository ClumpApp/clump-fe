// ignore_for_file: avoid_unnecessary_containers

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../group/message_details.dart';
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
  var msgController = TextEditingController();
  var _scrollController = ScrollController();
  Future<Map<String, dynamic>> myUserName =
      Client.instance.get(endpoint: '/users/me');

  @override
  void initState() {
    getMessages().then((value) => setState(() {
          messageList;
        }));
    var channel = WebSocketChannel.connect(
      Uri.parse(Client.instance.getWSAddress()),
    );
    channel.stream.listen((event) {
      var newMessage = jsonDecode(event);
      messageList.add(Message.fromJson(newMessage));
      _scrollController.jumpTo((_scrollController.position.maxScrollExtent));
      setState(() {
        messageList;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 7,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.25,
                decoration: const BoxDecoration(color: themeColor),
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
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const Divider(
                                      color: Colors.grey,
                                    ))),
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
                          color: darkGrey,
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
                                decoration: const InputDecoration(
                                    contentPadding:
                                        const EdgeInsets.only(bottom: 15),
                                    hintText: "Message",
                                    hintStyle: TextStyle(color: Colors.grey),
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
                                      send_time: DateTime.now());*/
                                  var newMessageMap = {"message": newMessage};

                                  Client.instance.post(
                                      data: newMessageMap,
                                      endpoint: '/messages');
                                  msgController.clear();
                                  /*setState(() {
                                    messageList.add(mesToList);
                                  });*/
                                }
                              },
                              child: const Icon(
                                Icons.send,
                                color: darkGrey,
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
                decoration: const BoxDecoration(color: turquoise),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      FutureBuilder<Map>(
                        future: myUserName,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Card(
                                child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ListTile(
                                  title: Text(snapshot.data!['UserName']),
                                ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      TextButton(
                                        child: const Text('Log out'),
                                        onPressed: () {/* ... */},
                                      ),
                                    ]),
                              ],
                            ));
                          }
                          return const Text('Loading...');
                        },
                      ),
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

  PopupMenuItem<SelectableItem> buildItem(SelectableItem item) =>
      PopupMenuItem<SelectableItem>(
        value: item,
        child: Row(
          children: [
            Icon(item.icon, color: Colors.grey),
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
