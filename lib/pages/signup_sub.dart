import '/pages/login_page.dart';
import 'package:flutter/material.dart';
import '../util/client.dart';
import '../constants.dart';

bool hasReturned = false;

class SignUpSub extends StatefulWidget {
  const SignUpSub({Key? key}) : super(key: key);
  @override
  State<SignUpSub> createState() => _SignUpSubState();
}

class _SignUpSubState extends State<SignUpSub> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    Client.instance.get(endpoint: "/users/assign").then((value) => {
          if (value["result"])
            {
              Client.instance.resetClient(),
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              )
            }
          else
            {
              setState(() {
                hasReturned = true;
              })
            }
        });
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("media/Clump_BG_empty.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Visibility(
        visible: hasReturned,
        child: const Text(
          'We are assignin you to a group, please wait',
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        replacement: const Text(
          'Unable to assign you to a group, please wait for a while and try again',
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
