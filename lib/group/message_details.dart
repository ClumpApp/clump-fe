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
        send_time: DateTime.parse(json['date']));
  }

  Map toJson() => {
        'uuid': uuid,
        'username': user_name,
        'type': message_type,
        'messagestr': message_string,
        'date': send_time,
      };
}

//Everything below this line is added for testing, will be removed before commiting to main

final testJson = '[{"uuid": "some_uuid", "username": "some_username", "type": 1, "messagestr": "my_message_str", "date": "2012-03-19T07:22Z"},{"uuid": "some_uuid", "username": "some_username", "type": 1, "messagestr": "my_message_str", "date": "2012-03-19T07:22Z"},{"uuid": "some_uuid", "username": "some_username", "type": 1, "messagestr": "my_message_str", "date": "2012-03-19T07:22Z"},{"uuid": "some_uuid", "username": "some_username", "type": 1, "messagestr": "my_message_str", "date": "2012-03-19T07:22Z"},{"uuid": "some_uuid", "username": "some_username", "type": 1, "messagestr": "my_message_str", "date": "2012-03-19T07:22Z"},{"uuid": "some_uuid", "username": "some_username", "type": 1, "messagestr": "my_message_str", "date": "2012-03-19T07:22Z"},{"uuid": "some_uuid", "username": "some_username", "type": 1, "messagestr": "my_message_str", "date": "2012-03-19T07:22Z"},{"uuid": "some_uuid", "username": "some_username", "type": 1, "messagestr": "my_message_str", "date": "2012-03-19T07:22Z"},{"uuid": "some_uuid", "username": "some_username", "type": 1, "messagestr": "my_message_str", "date": "2012-03-19T07:22Z"},{"uuid": "some_uuid", "username": "some_username", "type": 1, "messagestr": "my_message_str", "date": "2012-03-19T07:22Z"},{"uuid": "some_uuid", "username": "some_username", "type": 1, "messagestr": "my_message_str", "date": "2012-03-19T07:22Z"}, {"uuid": "some_uuid", "username": "some_username", "type": 1, "messagestr": "my_message_str", "date": "2012-03-19T07:22Z"},{"uuid": "some_uuid", "username": "some_username", "type": 1, "messagestr": "my_message_str", "date": "2012-03-19T07:22Z"},{"uuid": "some_uuid", "username": "some_username", "type": 1, "messagestr": "my_message_str", "date": "2012-03-19T07:22Z"},{"uuid": "some_uuid", "username": "some_username", "type": 1, "messagestr": "my_message_str", "date": "2012-03-19T07:22Z"}]';

List<Message> dummyMessageList = [
  Message(
      uuid: "my message uuid",
      user_name: "1 username",
      message_type: 1,
      message_string: "1 message string",
      send_time: DateTime.now()
  ),
  Message(
      uuid: "my message uuid",
      user_name: "2 username",
      message_type: 1,
      message_string: "2 message string",
      send_time: DateTime.now()
  ),
  Message(
      uuid: "my message uuid",
      user_name: "3 username",
      message_type: 1,
      message_string: "3 message string",
      send_time: DateTime.now()
  ),
  Message(
      uuid: "my message uuid",
      user_name: "4 username",
      message_type: 1,
      message_string: "4 message string",
      send_time: DateTime.now()
  ),
  Message(
      uuid: "my message uuid",
      user_name: "5 username",
      message_type: 1,
      message_string: "5 message string",
      send_time: DateTime.now()
  ),
];