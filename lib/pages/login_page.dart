import 'package:flutter/material.dart';
import '../util/client.dart';
import 'home_page.dart';
import 'signup_register.dart';
import '../constants.dart';

String username = '';
String password = '';
bool failedLogin = false;

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key); //, required String title

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return //Scaffold(
        /*appBar: AppBar(
        backgroundColor: themeColor,
        title: const Center(
          child: Text('Clump Login Demo'),
        ),
      ),*/
        //body:
        Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/backgrounds/Clump BG_empty.png.png"),
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
                            .login(username: username, password: password)
                            .then((success) => {
                                  if (success)
                                    {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const HomePage()),
                                      )
                                    }
                                  else
                                    {
                                      // TODO Show failed login
                                      failedLogin = true
                                      //reshow the same page but have a notif that its wrong?
                                    }
                                });
                      },
                      color: themeColor,
                      child: const Text(
                        'Login',
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
                              builder: (context) => const SignUpPage()),
                        );
                      },
                      elevation: 0,
                      color: Colors.transparent,
                      child: const Text(
                        'Not signed up yet? Register Now!',
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
