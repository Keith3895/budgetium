import 'package:flutter/material.dart';
import 'pages/logout.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {'/': (context) => Logout()},
    );
  }
}
