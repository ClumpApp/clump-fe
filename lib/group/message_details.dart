import 'package:flutter/material.dart';
import '../util/client.dart';
import '/constants.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    Key? key,
    required this.message,
    required this.press,
  }) : super(key: key);

  final Message message;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    Widget wid;
    if (message.message_type == 2) {
      // Photo
      var screenSize = MediaQuery.of(context).size;
      wid = Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(userAssets + message.message_string),
            fit: BoxFit.fitHeight,
            alignment: Alignment.centerLeft,
          ),
        ),
        width: screenSize.width / 2,
        height: screenSize.height / 3,
      );
    } else {
      // Text
      wid = Opacity(
        opacity: 1,
        child: Text(
          message.message_string,
          style: const TextStyle(color: Colors.white),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      );
    }
    return InkWell(
      onTap: press,
      hoverColor: Colors.white,
      focusColor: Colors.white,
      splashColor: Colors.white,
      highlightColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10 * 0.75),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      message.user_name,
                      style: const TextStyle(
                          color: darkOrange,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        wid,
                        Text(
                          message.send_time.toString(),
                          style: const TextStyle(color: Colors.grey),
                          textAlign: TextAlign.end,
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
    );
  }
}

class Message {
  final String uuid;
  final String user_name;
  final int message_type;
  final String message_string;
  final DateTime send_time;

  //final image image_message;
  //final video video_message;

  Message({
    required this.uuid,
    required this.user_name,
    required this.message_type,
    required this.message_string,
    required this.send_time,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
        uuid: json['uuid'],
        user_name: json['username'],
        message_type: json['type'],
        message_string: json['messagestr'],
        send_time: DateTime.parse(json['date']));
  }

  Map<String, dynamic> toJson() => {
        'uuid': uuid,
        'username': user_name,
        'type': message_type,
        'messagestr': message_string,
        'date': send_time,
      };
}

List<Message> messageList = [];

Future<bool> getMessages() async {
  var messages = await Client.instance.getAll(endpoint: "/messages");

  for (var messageJSON in messages) {
    messageList.add(Message.fromJson(messageJSON));
  }
  return true;
}
