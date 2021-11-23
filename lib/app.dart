import 'package:flutter/material.dart';
import 'pages/logout.dart';
import 'pages/login/login.dart';
import 'pages/signup/signup.dart';
import 'pages/profile/profile.dart';
import 'pages/home/home.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      onGenerateRoute: (settings) {
        late Widget page;
        switch (settings.name) {
          case '/':
            {
              page = Logout();
            }
            break;
          case '/login':
            {
              page = Login();
            }
            break;
          case '/signup':
            {
              page = SignUp();
            }
            break;
          case '/home/':
            {
              final subRoute = settings.name!.substring(
                '/home/'.length,
              );
              page = Home(
                homeRoute: subRoute,
              );
            }
            break;
          case '/profile':
            {
              page = Profile(null);
            }
            break;
        }
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return page;
          },
          settings: settings,
        );
      },
    );
  }
}
