import 'package:flutter/material.dart';
import 'package:home_workout/screens/registerScreens/login_form.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/login';

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'IFetiness',
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.orange,
      ),
      body: Container(
        height: mq.height * 1,
        //padding: EdgeInsets.only(top: 20),
        color: Colors.orange,
        alignment: Alignment.bottomCenter,
        child: Column(
          children: <Widget>[
            // Text('Register'),
            SizedBox(
              height: 50,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                height: mq.height * 0.8,
                width: double.infinity,
                padding: EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Login'.toUpperCase(),
                            style: TextStyle(
                              fontSize: 28,
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            child: Text(
                              '',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(child: LoginForm()),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
