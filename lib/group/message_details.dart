import 'package:flutter/material.dart';

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
    return InkWell(
      onTap: press,
      hoverColor: Colors.white,
      focusColor: Colors.white,
      splashColor: Colors.white,
      highlightColor: Colors.white,
      child: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 20 * 0.75),
        child: Row(
          children: [
            Stack(
              children: const [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.person, color: Colors.black),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      message.user_name,
                      style: const TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 8),
                    Opacity(
                      opacity: 1,
                      child: Text(
                        message.message_string,
                        style: const TextStyle(color: Colors.white),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
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
        send_time: json['date']);
  }

  Map toJson() => {
        'uuid': uuid,
        'username': user_name,
        'type': message_type,
        'messagestr': message_string,
        'date': send_time,
      };
}
