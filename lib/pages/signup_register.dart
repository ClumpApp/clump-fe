import '/pages/login_page.dart';
import 'package:flutter/material.dart';
import '../util/client.dart';
import 'signup_main.dart';
import '../constants.dart';

String username = '';
String password = '';
String email = '';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key); //, required String title

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(mediaAssets + "Clump_BG_empty.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        padding: EdgeInsets.only(left: screenSize.width * 0.4),
        child: Center(
          child: Card(
            elevation: 0,
            color: Colors.transparent,
            child: Container(
              padding: EdgeInsets.only(
                  left: screenSize.width / 12, right: screenSize.width / 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      fillColor: infoBoxColor,
                      filled: true,
                      labelText: 'E-mail',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.mail),
                    ),
                    onChanged: (value) {
                      email = value;
                    },
                  ),
                  SizedBox(
                    height: screenSize.height / 30,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    obscureText: false,
                    decoration: const InputDecoration(
                      fillColor: infoBoxColor,
                      filled: true,
                      labelText: 'Username',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person),
                    ),
                    onChanged: (value) {
                      username = value;
                    },
                  ),
                  SizedBox(
                    height: screenSize.height / 30,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    decoration: const InputDecoration(
                      fillColor: infoBoxColor,
                      filled: true,
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock),
                    ),
                    onChanged: (value) {
                      password = value;
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                  ),
                  SizedBox(
                    height: screenSize.height / 30,
                  ),
                  Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: MaterialButton(
                      onPressed: () {
                        Client.instance
                            .signup(
                                email: email,
                                username: username,
                                password: password)
                            .then((value) => {
                                  if (value)
                                    {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => SignUpMain()),
                                      )
                                    }
                                  else
                                    {
                                      // TODO Show failed signup
                                    }
                                });
                      },
                      color: themeColor,
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 16,
                          color: lightOrange,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()),
                        );
                      },
                      elevation: 0,
                      color: Colors.transparent,
                      child: const Text(
                        'Already have an account? Login Now!',
                        style: TextStyle(
                          fontSize: 16,
                          color: themeColor,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
