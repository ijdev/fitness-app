import 'package:flutter/material.dart';
import 'package:home_workout/providers/goal_provider.dart';
import 'package:home_workout/providers/meal_provider.dart';
import 'package:home_workout/providers/sleep_provider.dart';
import 'package:home_workout/providers/water_provider.dart';
import 'package:home_workout/providers/workout_provider.dart';
import 'package:provider/provider.dart';

class Items extends StatelessWidget {
  final String title;
  final Color color;

  const Items(this.title, this.color);

  @override
  Widget build(BuildContext context) {
    final mealPrograss = Provider.of<MealProvider>(context).getPrograss;
    final sleepPrograss = Provider.of<SleepProvider>(context).hours;
    final workPrograss = Provider.of<WorkoutProvider>(context).getPrograss;
    final waterPrograss = Provider.of<WaterProvider>(context).water;
    final goals = Provider.of<GoalProvider>(context).goals;

    return Container(
      padding: EdgeInsets.all(15),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color,
      ),
      margin: EdgeInsets.only(
        top: 1,
        //bottom: 10,
      ),
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Spacer(),
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white),
          ),
          Spacer(),
          title == 'Water'
              ? buildTextInfo(waterPrograss, goals.waterTarget)
              : title == 'Sleep'
                  ? buildTextInfo(sleepPrograss, goals.sleepTarget)
                  : title == 'Meals'
                      ? buildTextInfo(mealPrograss, goals.mealTarget)
                      : buildTextInfo(workPrograss, goals.workTarget),
        ],
      ),
    );
  }

  buildTextInfo(num baseValue, num endValue) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'PROGRASS $baseValue',
          softWrap: true,
          style: TextStyle(
              fontWeight: FontWeight.normal, fontSize: 14, color: Colors.white),
        ),
        Text(
          'GOAL $endValue',
          softWrap: true,
          style: TextStyle(
              fontWeight: FontWeight.normal, fontSize: 14, color: Colors.white),
        ),
      ],
    );
  }
}
