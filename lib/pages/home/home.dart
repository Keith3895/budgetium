import 'package:flutter/material.dart';
import 'package:budgetium/pages/profile/profile.dart';
import 'package:budgetium/pages/expense/expense.dart';

class Home extends StatefulWidget {
  Home({Key? key, required this.homeRoute, String? headerTitle}) : super(key: key);

  final String homeRoute;
  String headerTitle = "";
  @override
  HomePage createState() {
    return HomePage();
  }
}

class HomePage extends State<Home> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  String _headerTitle = "Home";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF6200EE),
        title: Text(_headerTitle),
      ),
      drawer: _drawer(),
      body: Navigator(
        key: _navigatorKey,
        initialRoute: widget.homeRoute,
        onGenerateRoute: _onGenerateRoute,
      ),
    );
  }

  Widget _drawer() {
    return Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Text('Drawer Header'),
        ),
        ListTile(
          title: Text('Profile'),
          onTap: () {
            // Update the state of the app.
            // ...
            Navigator.pushNamed(context, '/profile');
            // _navigatorKey.currentState!.pushNamed('/profile');
          },
        ),
        ListTile(
          title: Text('Expenses'),
          onTap: () {
            // Update the state of the app.
            _headerTitle = 'Expenses';
            _navigatorKey.currentState!.pushNamed('/home/expense');
          },
        ),
      ],
    ));
  }
}

Route _onGenerateRoute(RouteSettings settings) {
  late Widget page;
  switch (settings.name) {
    case '':
      page = Text('YO');
      break;
    case '/home/profile':
      page = Profile(null);
      break;
    case '/home/expense':
      page = Expense();
      break;
    default:
      page = Text('hit default');
  }
  return MaterialPageRoute<dynamic>(
    builder: (context) {
      return page;
    },
    settings: settings,
  );
}
