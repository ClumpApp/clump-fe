import 'package:flutter/material.dart';
import 'login_page.dart';
import 'signup_register.dart';
import '../constants.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // Remove the debug banner
      debugShowCheckedModeBanner: false,
      color: themeColor,
      home: LandingPage(),
    );
  }
}

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(mediaAssets + "Clump_BG_title.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        padding: EdgeInsets.only(
            left: screenSize.width * 0.7, top: screenSize.height * 0.65),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              width: screenSize.width / 6,
              height: screenSize.height / 13,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: MaterialButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
                color: blackpurple,
                child: const Text(
                  'Sign In',
                  style: TextStyle(
                    fontSize: 17,
                    color: lightOrange,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: screenSize.height / 80,
            ),
            Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              width: screenSize.width / 6,
              height: screenSize.height / 13,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: MaterialButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignUpPage()),
                  );
                },
                color: blackpurple,
                child: const Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 17,
                    color: lightOrange,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
