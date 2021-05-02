import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'password_field.dart';
import 'validators.dart';

class Login extends StatefulWidget {
  @override
  LoginState createState() {
    return LoginState();
  }
}

class LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
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
      FormSection(_formKey)
    ])));
  }

  Widget FormSection(_formKey) {
    return Form(
        key: _formKey,
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  padding: new EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                        labelText: "Email Address", filled: true),
                    validator: (value) =>
                        FieldValidators.validateEmail(value.toString()),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: new Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: new EdgeInsets.all(5.0),
                      child: PasswordField(
                        labelText: "Password",
                        validator: (value) =>
                            FieldValidators.validatePassword(value.toString()),
                      ))),
              SizedBox(height: 80),
              LoginIcons(),
              SizedBox(height: 26),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color(0xFF6200EE))),
                    child: Text(
                      'Log In',
                      style: TextStyle(fontSize: 14),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        print('valid');
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Invalid Email or Password')));
                      }
                    },
                  ),
                ),
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

  Widget LoginIcons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
            icon: Image.asset('assets/icons/gmail.png'),
            onPressed: () {
              print("Pressed");
            }),
        SizedBox(width: 25),
        IconButton(
            // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
            icon: Image.asset('assets/icons/facebook.png'),
            onPressed: () {
              print("Pressed");
            }),
        SizedBox(width: 25),
        IconButton(
            // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
            icon: Image.asset('assets/icons/linkedin.png'),
            onPressed: () {
              print("Pressed");
            })
      ],
    );
  }
}
