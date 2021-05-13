import 'package:flutter/material.dart';
import 'pages/logout.dart';
import 'pages/login/login.dart';
import 'pages/signup/signup.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => Logout(),
        '/login': (context) => Login(),
        '/signup': (context) => SignUp(),
        '/home': (context) {
          return Text('home');
        }
      },
    );
  }
}
