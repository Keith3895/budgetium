import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'password_field.dart';
import 'validators.dart';
import 'auth_controller.dart';

class Login extends StatefulWidget {
  @override
  LoginState createState() {
    return LoginState();
  }
}

class LoginState extends State<Login> {
  var _formKey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
      Container(
        child: Padding(
            padding: EdgeInsets.only(top: 20),
            child: Row(
              children: [
                Stack(
                  alignment: Alignment.topLeft,
                  children: <Widget>[
                    // YourScrollViewWidget(),
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                )
              ],
            )),
      ),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        Text(
          'Log In',
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 30),
        )
      ]),
      SizedBox(height: MediaQuery.of(context).size.height * .1),
      _formSection()
    ])));
  }

  Widget _formSection() {
    return Form(
        key: _formKey,
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: _emailField(),
              ),
              SizedBox(height: 10),
              Container(padding: EdgeInsets.symmetric(horizontal: 20.0), child: _passwordField()),
              SizedBox(height: 80),
              _loginIcons(),
              SizedBox(height: 26),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: _loginButton(),
              ),
              SizedBox(height: 26),
              RichText(
                text: TextSpan(
                  text: '',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Forgot your password?',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            print('The button is clicked!');
                          },
                        style: TextStyle(
                          color: Color(0xFF6200EE),
                        )),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  Widget _loginIcons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
            icon: Image.asset('assets/icons/gmail.png'),
            onPressed: () => _externalLogin('gcp')),
        SizedBox(width: 25),
        IconButton(
            // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
            icon: Image.asset('assets/icons/facebook.png'),
            onPressed: () => _externalLogin('facebook')),
        SizedBox(width: 25),
        IconButton(
            // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
            icon: Image.asset('assets/icons/linkedin.png'),
            onPressed: () => _externalLogin('linkedin'))
      ],
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
            _username = value.toString();
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
          labelText: "Password",
          validator: (value) => FieldValidators.validatePassword(value.toString()),
          onSaved: (value) {
            setState(() {
              _password = value.toString();
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
          'Log In',
          style: TextStyle(fontSize: 14),
        ),
        onPressed: _submit,
      ),
    );
  }

  void _externalLogin(provider) async {
    var loginResp = await AuthController.authenticate(provider);
    if (loginResp['statusCode'] >= 200 && loginResp['statusCode'] <= 210) {
      Navigator.pushNamed(context, '/home');
    }
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      var out = await AuthController.login(_username, _password);
      if (out['statusCode'] >= 200 && out['statusCode'] <= 210) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Success')));
        Navigator.pushNamed(context, '/home');
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(out['body']!['error_description'])));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Invalid Email or Password')));
    }
  }
}
