import 'package:flutter/material.dart';
import 'package:home_workout/screens/interactiveScreens/sleep_screen.dart';
import 'package:home_workout/screens/interactiveScreens/water_screen.dart';
import 'package:home_workout/screens/interactiveScreens/workout_screen.dart';
import 'package:home_workout/screens/interactiveScreens/meal_screen.dart';
import 'package:home_workout/widgets/items.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Hello Ibrahem ',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black54),
          ),
          backgroundColor: Colors.white,
          actions: <Widget>[
            FlatButton.icon(
                icon: Icon(
                  Icons.alarm_add,
                  color: Theme.of(context).primaryColor,
                ),
                label: Text('Reminders'),
                textColor: Theme.of(context).primaryColor,
                onPressed: () {} // TODO REMINDERS LOGIC,
                )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: GridView(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10),
            children: <Widget>[
              GestureDetector(
                child: Items('Meals', Colors.orange),
                onTap: () {
                  Navigator.pushNamed(context, MealScreen.routeName);
                },
              ),
              GestureDetector(
                child: Items('Workouts', Colors.red),
                onTap: () {
                  Navigator.pushNamed(context, WorkoutScreen.routeName);
                },
              ),
              GestureDetector(
                child: Items('Water', Colors.blue),
                onTap: () {
                  Navigator.pushNamed(context, WaterScreen.routeName);
                },
              ),
              GestureDetector(
                child: Items('Sleep', Colors.deepPurpleAccent),
                onTap: () {
                  Navigator.pushNamed(context, SleepScreen.routeName);
                },
              ),
            ],
          ),
        ));
  }
}
