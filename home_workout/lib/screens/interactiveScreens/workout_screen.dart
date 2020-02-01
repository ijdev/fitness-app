import 'package:flutter/material.dart';
import 'package:home_workout/models/meal.dart';
import 'package:home_workout/models/workout.dart';
import 'package:home_workout/providers/goal_provider.dart';
import 'package:home_workout/providers/meal_provider.dart';
import 'package:home_workout/providers/workout_provider.dart';
import 'package:home_workout/widgets/workout_item.dart';
import 'package:provider/provider.dart';

import '../../widgets/meal_item.dart';

class WorkoutScreen extends StatefulWidget {
  static const routeName = '/workout-screen';

  @override
  _WorkoutScreenState createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<WorkoutProvider>(context, listen: false).fetchAndSet();
  }

  @override
  Widget build(BuildContext context) {
    var workData = Provider.of<WorkoutProvider>(context);
    var goalData = Provider.of<GoalProvider>(context, listen: false);

    var mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Today',
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.red,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              WorkoutItem.showPop(context, null, null, null, flag: true);
            },
          )
        ],
      ),
      body: Container(
        height: mq.height * 1,
        //padding: EdgeInsets.only(top: 20),
        color: Colors.red,
        alignment: Alignment.bottomCenter,
        child: Column(
          children: <Widget>[
            Text('BUILD A TIMELINE'),
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
                            '${workData.getPrograss.toStringAsFixed(0)} out of ${goalData.goals.workTarget.toStringAsFixed(0)}',
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.red,
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
                    Expanded(
                      child: ListView.builder(
                          itemCount: workData.workouts.length,
                          itemBuilder: (_, i) {
                            Workout workout = workData.workouts[i];
                            return Dismissible(
                              key: Key(workout.id),
                              onDismissed: (direction) {
                                workData.removeWorkout(workout.id);
                              },
                              confirmDismiss:
                                  (DismissDirection direction) async {
                                final bool res = await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text("Confirm"),
                                      content: const Text(
                                          "Are you sure you wish to delete this item?"),
                                      actions: <Widget>[
                                        FlatButton(
                                            onPressed: () {
                                              Navigator.of(context).pop(true);
                                              workData
                                                  .removeWorkout(workout.id);
                                            },
                                            child: const Text("DELETE")),
                                        FlatButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(false),
                                          child: const Text("CANCEL"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              background: Container(
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                alignment: Alignment.centerRight,
                                margin: EdgeInsets.all(5),
                                padding: EdgeInsets.all(20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    ),
                                    Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                              child: WorkoutItem(workout.id, workout.name,
                                  workout.cal, workout.isChecked),
                            );
                          }),
                    )
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
