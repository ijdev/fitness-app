import 'package:flutter/material.dart';
import 'package:home_workout/screens/diatTabScreens/diat_goals_screen.dart';
import 'package:home_workout/screens/diatTabScreens/my_meals.dart';
import 'package:home_workout/screens/diatTabScreens/my_workout.dart';

class DiatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 2 / 1,
          crossAxisSpacing: 20,
          mainAxisSpacing: 0),
      children: <Widget>[
        GestureDetector(
          child: TempItemBuilder('Dait & Goals', Colors.green),
          onTap: () {
            Navigator.of(context).pushNamed(DiatGoals.routeName);
          },
        ),
        GestureDetector(
          child: TempItemBuilder('My Meals', Colors.orange),
          onTap: () {
            Navigator.pushNamed(context, MyMeals.routeName);
          },
        ),
        GestureDetector(
          child: TempItemBuilder('My Workouts', Colors.red),
          onTap: () {
            Navigator.pushNamed(context, MyWorkout.routeName);
          },
        ),
      ],
    );
  }
}

class TempItemBuilder extends StatelessWidget {
  final String title;
  final Color color;

  const TempItemBuilder(this.title, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color,
      ),
      margin: EdgeInsets.only(top: 20, right: 10, bottom: 10, left: 10),
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Spacer(),
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.w500, fontSize: 25, color: Colors.white),
          ),
          Spacer(),
          // title == 'Water'
          //     ? buildTextInfo('glasses out of ', 0, 8)
          //     : title == 'Sleep'
          //         ? buildTextInfo('hours  out of ', 0, 8)
          //         : buildTextInfo('cal out of ', 0, 1290),
        ],
      ),
    );
  }

  Text buildTextInfo(String text, num baseValue, num endValue) {
    return Text(
      '$baseValue $text $endValue',
      softWrap: false,
      style: TextStyle(
          fontWeight: FontWeight.w300, fontSize: 16, color: Colors.white),
    );
  }
}
