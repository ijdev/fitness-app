import 'package:flutter/material.dart';
import 'package:home_workout/models/workout.dart';
import 'package:home_workout/providers/workout_provider.dart';
import 'package:home_workout/widgets/work_item_my_workout.dart';
import 'package:provider/provider.dart';

class MyWorkout extends StatefulWidget {
  static const routeName = '/my-workout';

  @override
  _MyWorkoutState createState() => _MyWorkoutState();
}

class _MyWorkoutState extends State<MyWorkout> {
  @override
  void initState() {
    super.initState();
    Provider.of<WorkoutProvider>(context, listen: false).fetchAndSetMyWorkout();
  }

  @override
  Widget build(BuildContext context) {
    var workData = Provider.of<WorkoutProvider>(context);

    var mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'MY WORKOUTS',
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.red,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              WorkItemMyWorkout.showPop(context, null, null, null, flag: true);
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
                          ///
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: workData.myWorkout.length,
                          itemBuilder: (_, i) {
                            Workout workout = workData.myWorkout[i];
                            return WorkItemMyWorkout(
                              workout.id,
                              workout.name,
                              workout.cal,
                              workout.isChecked,
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
