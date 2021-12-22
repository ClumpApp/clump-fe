import 'package:flutter/material.dart';
import '../constants.dart';
import 'signup_sub.dart';

String username = '';
String password = '';
bool failedLogin = false;

final List<String> interestIcons = [
  "sports",
  "tv",
  "movies",
  "books",
  "music",
  "science",
  "art",
  "comic",
  "anime"
];
final List<bool> interestChecks =
    List.generate(interestIcons.length, (_) => false);

class SignUpMain extends StatefulWidget {
  const SignUpMain({Key? key}) : super(key: key);
  @override
  _SignUpMain createState() => _SignUpMain();
}

class _SignUpMain extends State<SignUpMain> {
  @override
  Widget build(BuildContext context) {
    //var screenSize = MediaQuery.of(context).size;
    return MaterialApp(home: Builder(builder: (BuildContext context) {
      return Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  "assets/images/backgrounds/Clump BG_interests.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              Scaffold(
                body: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3),
                    itemBuilder: (_, i) {
                      return Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/images/icons/" +
                                    interestIcons[i] +
                                    ".png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Checkbox(
                              value: interestChecks[i],
                              onChanged: (newValue) => setState(
                                  () => interestChecks[i] = newValue!), //????
                            ),
                          ),
                        ],
                      );
                    }),
              ),
              Container(
                child: MaterialButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignUpSub()),
                    );
                  },
                  elevation: 0,
                  color: turquoise,
                  child: const Text(
                    'Cool!',
                    style: TextStyle(
                      fontSize: 16,
                      color: lightOrange,
                    ),
                  ),
                ),
              )
            ],
          ));
    }));
  }
}
