import 'package:flutter/material.dart';
import './profile_service.dart';

class Profile extends StatefulWidget {
  ProfileService? profileService;
  Profile(this.profileService) {
    if (this.profileService == null) {
      this.profileService = new ProfileService();
    }
  }
  @override
  ProfileState createState() {
    return ProfileState();
  }
}

class ProfileState extends State<Profile> {
  late final Future str = widget.profileService!.getMyData();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appbar(),
        body: FutureBuilder(
          future: str,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return _mainContent(snapshot.data);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }

  Widget _mainContent(data) {
    return SingleChildScrollView(
        child: Column(
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(top: 43),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 100,
                  backgroundImage: AssetImage("assets/images/avatar.png"),
                )
                // _spinner()
              ],
            )),
        SizedBox(height: 20),
        _disabledInputs(data['name'], Key('name'), "Name"),
        SizedBox(height: 20),
        _disabledInputs(data['email'], Key('email'), "email Address"),
        SizedBox(height: 20),
        _disabledInputs(data['mobile'], Key('mobile'), "Mobile number"),
      ],
    ));
  }

  Widget _disabledInputs(initValue, key, labelText) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Container(
            padding: new EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
                key: key,
                enabled: false,
                initialValue: initValue,
                decoration: InputDecoration(labelText: labelText))));
  }

  AppBar _appbar() {
    return AppBar(
      backgroundColor: Color(0xFF6200EE),
      title: Text(
        'Profile',
        style: TextStyle(fontWeight: FontWeight.w800, fontSize: 30),
      ),
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: [
        GestureDetector(
          onTap: () {},
          child: TextButton(
              onPressed: null,
              child: Text(
                'Save',
                style: TextStyle(color: Colors.white),
              )),
        )
      ],
    );
  }
}
