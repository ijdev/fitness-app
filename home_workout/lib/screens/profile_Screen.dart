import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = '/profile';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          actions: <Widget>[
            Container(
              margin: EdgeInsets.all(10),
              child: GestureDetector(
                child: Chip(
                  backgroundColor: Colors.blue,
                  label: Text(
                    'Edit Profile',
                    style: TextStyle(color: Colors.white),
                  ),

                  //label: Text('Edit profile'),
                ),
              ),
            ),
          ],
        ),
        body: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              //Image.network(''),
              Column(
                children: <Widget>[
                  CircleAvatar(
                    child: Text(
                      'UN',
                      style: TextStyle(fontSize: 30),
                    ),
                    radius: 45,
                  ),
                  SizedBox(height: 10), // TODO sizedbox.
                  Text(
                    'User Name',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('emal@email.com'),
                ],
              ),

              Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: Chip(
                        label: Text(
                          '500',
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.orange,
                      ),
                      title: Text(
                        'Meal Prograss',
                        textAlign: TextAlign.center,
                      ),
                      trailing: Chip(
                        label: Text(
                          '2000',
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.orange,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: Chip(
                        label: Text(
                          '500',
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.red,
                      ),
                      title: Text(
                        'Workout Prograss',
                        textAlign: TextAlign.center,
                      ),
                      trailing: Chip(
                        label: Text(
                          '2000',
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.red,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: Chip(
                        label: Text(
                          '2',
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.blue,
                      ),
                      title: Text(
                        'Water Prograss',
                        textAlign: TextAlign.center,
                      ),
                      trailing: Chip(
                        label: Text(
                          '10',
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.blue,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: Chip(
                        label: Text(
                          '7',
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.purple,
                      ),
                      title: Text(
                        'Sleep Prograss',
                        textAlign: TextAlign.center,
                      ),
                      trailing: Chip(
                        label: Text(
                          '8',
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.purple,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
