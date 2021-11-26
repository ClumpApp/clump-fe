import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'home_page.dart';

String username = '';
String password = '';
String responseBody = 'Unauthorized';
String loginURL = 'http://clump-be.azurewebsites.net/login/';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // Remove the debug banner
      debugShowCheckedModeBanner: false,
      title: 'Clump',
      color: Colors.red,
      home: LoginPage(title: 'Clump Demo Login'),
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key, required String title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Center(child: Text('Clump Login Demo')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  '',
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 60.0,
                      color: Colors.red),
                ),
                const SizedBox(
                  height: 25,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                  ),
                  onChanged:(value) {
                    username = value;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                  ),
                  onChanged:(value) {
                    password = value;
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: MaterialButton(
                    onPressed: () {
                      passLoginData(username, password);
                      if(responseBody == 'Unauthorized'){
                        Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginError()),
            );
                      } else {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
                      }
          },
                    color: Colors.red,
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}




void getData() async {
Uri website = Uri.parse('http://clump-be.azurewebsites.net/');
Response response = await get(website);
print(jsonDecode(response.body));
}

void passLoginData(String user, String pass) async {

  final response = await post(Uri.parse(loginURL), body:{
    'UserName' : user,
    'Password' : pass
});

  responseBody = response.body;
  
}
