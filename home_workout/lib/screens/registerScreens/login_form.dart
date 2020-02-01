import 'package:flutter/material.dart';
import 'package:home_workout/providers/user_provider.dart';
import 'package:home_workout/screens/bottom_nav_screen.dart';
import 'package:home_workout/screens/registerScreens/register_screen.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  Map _data = {"email": '', "password": ''};

  _submitForm() async {
    {
      if (!_formKey.currentState.validate()) {
        print(_data);
        return;
      }
      _formKey.currentState.save();
      try {
        bool f = await Provider.of<UserProvider>(context, listen: false)
            .login(_data);
        if (f) {
          Navigator.of(context).pushReplacementNamed(TabsScreen.routeName);
        } else {
          print('errror');
        }
      } catch (error) {
        print(error.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 8),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                    onSaved: (value) {
                      _data['email'] = value;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    onSaved: (value) {
                      _data['password'] = value;
                    },
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    child: RaisedButton(
                      color: Colors.orange,
                      child: Text(
                        'Login'.toUpperCase(),
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      onPressed: _submitForm,
                    ),
                  ),
                  SizedBox(height: 10),
                  FlatButton(
                    child: Text(
                      'Create an account',
                      style: TextStyle(fontSize: 16, color: Colors.blue),
                    ),
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, RegisterScreen.routeName);
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
