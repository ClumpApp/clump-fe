// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
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
  Future<Map<String, dynamic>> myUserName =
      Client.instance.get(endpoint: '/users/me');

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
                decoration: const BoxDecoration(color: themeColor),
                child: Column(),
              ),
            ),
            Expanded(
              flex: 7,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.25,
                decoration: const BoxDecoration(color: themeColor),
                child: Column(
                  children: [
                    Expanded(
                      child: FutureBuilder<bool>(
                        future:
                            //_calculation,
                            getMessages(),
                        builder: (context, snapshot) {
                          List<Widget> children;
                          if (snapshot.hasData) {
                            return ListView.separated(
                                itemCount: messageList.length,
                                itemBuilder: (BuildContext context, int i) {
                                  var m = messageList[i];
                                  return MessageBubble(
                                      message: m, press: () => {});
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        const Divider(
                                          color: Colors.grey,
                                        ));
                          } else if (snapshot.hasError) {
                            children = <Widget>[
                              const Icon(
                                Icons.error_outline,
                                color: Colors.red,
                                size: 60,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 16),
                                child: Text('Error: ${snapshot.error}'),
                              )
                            ];
                          } else {
                            children = const <Widget>[
                              SizedBox(
                                width: 60,
                                height: 60,
                                child: CircularProgressIndicator(),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 16),
                                child: Text('Awaiting result...'),
                              )
                            ];
                          }
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: children,
                            ),
                          );
                        },
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
                        height: 55,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
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
                                decoration: const InputDecoration(
                                    hintText: "Message",
                                    hintStyle: TextStyle(color: Colors.black54),
                                    border: InputBorder.none),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            FloatingActionButton(
                              onPressed: () {
                                if (newMessage != "") {
                                  Message mesToList = Message(
                                      uuid: "my message uuid",
                                      user_name: "demo user",
                                      message_type: 1,
                                      message_string: newMessage,
                                      send_time: DateTime.now());
                                  /*
                                Client.instance.post(
                                    data: newMessageMap, endpoint: '/messages');
                                    */
                                  setState(() {
                                    messageList.add(mesToList);
                                  });
                                }
                              },
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
                      FutureBuilder<Map>(
                        future: myUserName,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(snapshot.data!['UserName']);
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
