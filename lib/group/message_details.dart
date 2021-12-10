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
      hoverColor: Colors.black,
      focusColor: Colors.black,
      splashColor: Colors.black,
      highlightColor: Colors.black,
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
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 8),
                    Opacity(
                      opacity: 1,
                      child: Text(
                        message.text_message,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Opacity(
              opacity: 1,
              child: Text(message.last_seen),
            ),
          ],
        ),
      ),
    );
  }
}

class Message {
  final String user_name, text_message, last_seen;
  //final Uri linkMessage;
  //final recording audio_message;
  //final image image_message;
  //final video video_message;
  final bool isActive;

  Message({
    this.user_name = '',
    this.text_message = '',
    this.last_seen = '',
    this.isActive = false,
  });
}

List sampleMessages = [
  Message(
    user_name: "Abdullah Coşgun",
    text_message: "Hi guys, how are you doing lately?",
    last_seen: "show_last_active",
    isActive: false,
  ),
  Message(
    user_name: "Emre Duzakin",
    text_message:
        "Hello Abdullah! I am doing fantastic. What a beautiful morning to wake up!",
    last_seen: "show_last_active",
    isActive: false,
  ),
  Message(
    user_name: "Serra Doganata",
    text_message: "Me too! I haven't felt this good in a long time!",
    last_seen: "show_last_active",
    isActive: false,
  ),
  Message(
    user_name: "Abdullah Coşgun",
    text_message: "I am glad you guys are ok, but I am feeling a bit down :(",
    last_seen: "show_last_active",
    isActive: false,
  ),
  Message(
    user_name: "Test User",
    text_message: "Wish you all the best :(",
    last_seen: "show_last_active",
    isActive: false,
  ),
  Message(
    user_name: "Test User",
    text_message: "Wish you all the best :(",
    last_seen: "show_last_active",
    isActive: false,
  ),
  Message(
    user_name: "Test User",
    text_message: "Wish you all the best :(",
    last_seen: "show_last_active",
    isActive: false,
  ),
  Message(
    user_name: "Test User",
    text_message: "Wish you all the best :(",
    last_seen: "show_last_active",
    isActive: false,
  ),
  Message(
    user_name: "Test User",
    text_message: "Wish you all the best :(",
    last_seen: "show_last_active",
    isActive: false,
  ),
  Message(
    user_name: "Test User",
    text_message: "Wish you all the best :(",
    last_seen: "show_last_active",
    isActive: false,
  ),
  Message(
    user_name: "Test User",
    text_message: "Wish you all the best :(",
    last_seen: "show_last_active",
    isActive: false,
  ),
  Message(
    user_name: "Test User",
    text_message: "Wish you all the best :(",
    last_seen: "show_last_active",
    isActive: false,
  ),
  Message(
    user_name: "Test User",
    text_message: "Wish you all the best :(",
    last_seen: "show_last_active",
    isActive: false,
  ),
  Message(
    user_name: "Test User",
    text_message: "Wish you all the best :(",
    last_seen: "show_last_active",
    isActive: false,
  ),
  Message(
    user_name: "Test User",
    text_message: "Wish you all the best :(",
    last_seen: "show_last_active",
    isActive: false,
  ),
  Message(
    user_name: "Test User",
    text_message: "Wish you all the best :(",
    last_seen: "show_last_active",
    isActive: false,
  ),
  Message(
    user_name: "Test User",
    text_message: "Wish you all the best :(",
    last_seen: "show_last_active",
    isActive: false,
  ),
  Message(
    user_name: "Test User",
    text_message: "Wish you all the best :(",
    last_seen: "show_last_active",
    isActive: false,
  ),
  Message(
    user_name: "Test User",
    text_message: "Wish you all the best :(",
    last_seen: "show_last_active",
    isActive: false,
  ),
  Message(
    user_name: "Test User",
    text_message: "Wish you all the best :(",
    last_seen: "show_last_active",
    isActive: false,
  ),
];
