import 'package:flutter/material.dart';
import 'pages/logout.dart';
import 'pages/login/login.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => Logout(),
        '/login': (context) => Login(),
        '/home': (context) {
          return Text('home');
        }
      },
    );
  }
}
