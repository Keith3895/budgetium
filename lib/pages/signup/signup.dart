import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:budgetium/pages/login/password_field.dart';
import 'package:budgetium/validators.dart';
import 'package:budgetium/app_config.dart';

class SignUp extends StatefulWidget {
  @override
  SignupState createState() {
    return SignupState();
  }
}

class SignupState extends State<SignUp> {
  var _formKey = GlobalKey<FormState>();
  String _name = '';
  String _email = '';
  String _mobile = '';
  String _password = '';
  String _confPassword = '';
  bool _agree = false;
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(top: 40),
                child: Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Spacer(),
                  Text(
                    'Sign Up',
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 30),
                  ),
                  Spacer(),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        'Login',
                        style: TextStyle(color: Color(0xFF6200EE)),
                      ))
                ])),
            SizedBox(height: 32),
            _signupForm()
          ],
        ),
      ),
    );
  }

  Widget _signupForm() {
    return Form(
      key: _formKey,
      child: Center(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: _nameField(),
            ),
            SizedBox(height: 22),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: _emailField(),
            ),
            SizedBox(height: 22),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: _mobileField(),
            ),
            SizedBox(height: 22),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: _passwordField(),
            ),
            SizedBox(height: 22),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: _confPasswordField(),
            ),
            Row(
              children: [
                Material(
                  child: Checkbox(
                    value: _agree,
                    onChanged: (value) {
                      setState(() {
                        _agree = value == true;
                      });
                    },
                  ),
                ),
                Text(
                  'I Consent to sharing my personal details to be \nused by the app.',
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
            SizedBox(height: 26),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: _loginButton(),
            ),
          ],
        ),
      ),
    );
  }

  /// three fields can be put into one.
  Widget _nameField() {
    return Container(
      padding: new EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        key: Key('name'),
        decoration: InputDecoration(labelText: "Name", filled: true),
        validator: (value) => FieldValidators.validateName(value.toString()),
        onSaved: (value) {
          setState(() {
            _name = value.toString();
          });
        },
      ),
    );
  }

  Widget _emailField() {
    return Container(
      padding: new EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        key: Key('email'),
        decoration: InputDecoration(labelText: "Email Address", filled: true),
        validator: (value) => FieldValidators.validateEmail(value.toString()),
        onSaved: (value) {
          setState(() {
            _email = value.toString();
          });
        },
      ),
    );
  }

  Widget _mobileField() {
    return Container(
      padding: new EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        key: Key('mobile'),
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        decoration: InputDecoration(labelText: "Mobile Number", filled: true),
        validator: (value) => FieldValidators.validateMobile(value.toString()),
        onSaved: (value) {
          setState(() {
            _mobile = value.toString();
          });
        },
      ),
    );
  }

  Widget _passwordField() {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.all(5.0),
        child: PasswordField(
          fieldKey: Key('password'),
          controller: _passController,
          labelText: "Password",
          validator: (value) => FieldValidators.validateComplexPassword(value.toString()),
          onSaved: (value) {
            setState(() {
              _password = value.toString();
            });
          },
        ));
  }

  Widget _confPasswordField() {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.all(5.0),
        child: PasswordField(
          fieldKey: Key('cPassword'),
          controller: _confirmPass,
          labelText: "Confirm Password",
          validator: (value) =>
              FieldValidators.validateConfirmPassword(value.toString(), _passController),
          onSaved: (value) {
            setState(() {
              _confPassword = value.toString();
            });
          },
        ));
  }

  Widget _loginButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF6200EE))),
        child: Text(
          'Sign Up',
          style: TextStyle(fontSize: 14),
        ),
        onPressed: _agree ? _submit : null,
      ),
    );
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      var response = await signup({
        'email': _email,
        'full_name': _name,
        'first_name': _name.split(' ')[0],
        'last_name': _name.split(' ')[1],
        'password': _password
      }, null);
      if (response['statusCode'] >= 200 && response['statusCode'] <= 210) {
        Navigator.pushNamed(context, '/login');
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(response['body']!['error_description'])));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Invalid Form Submission')));
    }
  }
}

Future signup(var signupObject, http.Client? client) async {
  if (client == null) client = http.Client();
  String _userBaseURL = AppConfig.userBaseURL;
  var url = Uri.parse('$_userBaseURL/oauth/register');
  var response = await client.post(url,
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: utf8.encode(json.encode(signupObject)));
  return {"statusCode": response.statusCode, "body": jsonDecode(response.body)};
}
