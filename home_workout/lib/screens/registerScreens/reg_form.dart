import 'package:flutter/material.dart';
import 'package:home_workout/providers/user_provider.dart';
import 'package:home_workout/screens/bottom_nav_screen.dart';
import 'package:home_workout/screens/registerScreens/login_screen.dart';
import 'package:provider/provider.dart';

class RegForm extends StatefulWidget {
  @override
  _RegFormState createState() => _RegFormState();
}

class _RegFormState extends State<RegForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  Map _data = {"name": '', "email": '', "password": ''};

  TextEditingController _passwordController = TextEditingController();

  _submitForm() async {
    {
      if (!_formKey.currentState.validate()) {
        print(_data);
        return;
      }
      _formKey.currentState.save();
      try {
        bool f = await Provider.of<UserProvider>(context, listen: false)
            .register(_data);
        if (f) {
          Navigator.of(context).pushReplacementNamed(TabsScreen.routeName);
        }
        throw Exception();
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
                    decoration: InputDecoration(
                        labelText: 'Name', labelStyle: TextStyle()),
                    keyboardType: TextInputType.text,
                    onSaved: (value) {
                      _data['name'] = value.trim();
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                    onSaved: (value) {
                      _data['email'] = value.trim();
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    controller: _passwordController,
                    onSaved: (value) {
                      _data['password'] = value.trim();
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Confirm password'),
                    obscureText: true,
                    validator: (value) {
                      if (value != _passwordController.text) {
                        return 'passwords don\'t match';
                      }
                    },
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    child: RaisedButton(
                      color: Colors.orange,
                      child: Text(
                        'Register'.toUpperCase(),
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      onPressed: _submitForm,
                    ),
                  ),
                  SizedBox(height: 10),
                  FlatButton(
                    child: Text(
                      'Already have an account? login here',
                      style: TextStyle(fontSize: 16, color: Colors.blue),
                    ),
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, LoginScreen.routeName);
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
