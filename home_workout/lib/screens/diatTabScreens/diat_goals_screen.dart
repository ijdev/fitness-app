// import 'package:flutter/material.dart';

// class DiatGoals extends StatelessWidget {
//   static const routeName = '/diatGoals';
//   @override
//   Widget build(BuildContext context) {
//     var mq = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.green,
//       ),
//       body: Container(
//         height: mq.height * 1,
//         //padding: EdgeInsets.only(top: 20),
//         color: Colors.green,
//         alignment: Alignment.bottomCenter,
//         child: Column(
//           children: <Widget>[
//             Container(
//               margin: EdgeInsets.only(bottom: 20),
//               child: Text(
//                 'YOUR GOALS',
//                 style: TextStyle(
//                     fontSize: 22,
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold),
//               ),
//             ),
//             Expanded(
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(30),
//                     topRight: Radius.circular(30),
//                   ),
//                 ),
//                 height: mq.height * 0.8,
//                 width: int.infinity,
//                 padding: EdgeInsets.all(20),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: <Widget>[
//                     Spacer(),
//                     GoalItem('MEALS', '1900 CAL'),
//                     Spacer(),
//                     GoalItem('WORKOUTS', '400 CAL'),
//                     Spacer(),
//                     GoalItem('WATER', '8 GLASSES'),
//                     Spacer(),
//                     GoalItem('SLEEP', '8 HOURES'),
//                     Spacer(),
//                     Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       width: int.infinity,
//                       padding: EdgeInsets.all(20),
//                       child: RaisedButton(
//                         child: Text('SAVE CHANGES'),
//                         onPressed: () {},
//                         textColor: Colors.white,
//                         color: Colors.pink,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class GoalItem extends StatelessWidget {
//   final String goal;
//   final String title;

//   const GoalItem(this.title, this.goal);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//           color: Colors.white,
//           border: Border.all(width: 0.5, color: Colors.grey),
//           borderRadius: BorderRadius.circular(5)),
//       // margin: EdgeInsets.all(5),
//       child: ListTile(
//         leading: FlatButton(
//           child: Text(
//             'Change',
//             style: TextStyle(color: Colors.green),
//           ),
//           onPressed: () {},
//         ),
//         trailing: Chip(
//           label: Text(
//             goal,
//             style: TextStyle(color: Colors.white, fontSize: 15),
//           ),
//           backgroundColor: Colors.green,
//           padding: EdgeInsets.all(10),
//         ),
//         title: Text(
//           title,
//           textAlign: TextAlign.center,
//         ),
//       ),
//     );
//   }
// }

// end

import 'package:flutter/material.dart';
import 'package:home_workout/providers/goal_provider.dart';
import 'package:provider/provider.dart';
import '../../enums/goals_enums.dart';

class DiatGoals extends StatefulWidget {
  static const routeName = '/diatGoals';

  @override
  _DiatGoalsState createState() => _DiatGoalsState();
}

class _DiatGoalsState extends State<DiatGoals> {
  @override
  void initState() {
    super.initState();
    Provider.of<GoalProvider>(context, listen: false).fetchAndSet();
  }

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;
    var goal = Provider.of<GoalProvider>(context);
    // TODO REPLACE WITH CONSUMER, AVOID REBUILDING.

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.green,
      ),
      body: Container(
        height: mq.height * 1,
        //padding: EdgeInsets.only(top: 20),
        color: Colors.green,
        alignment: Alignment.bottomCenter,
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Text(
                'YOUR GOALS',
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
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
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Spacer(),
                    GoalItem(GoalsEnum.Meal, goal.goals.mealTarget.toString()),
                    Spacer(),
                    GoalItem(
                        GoalsEnum.Workouts, goal.goals.workTarget.toString()),
                    Spacer(),
                    GoalItem(
                        GoalsEnum.Water, goal.goals.waterTarget.toString()),
                    Spacer(),
                    GoalItem(
                        GoalsEnum.Sleep, goal.goals.sleepTarget.toString()),
                    Spacer(),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      child: RaisedButton(
                        child: const Text('RESET ALL'),
                        onPressed: () {
                          goal.reset();
                        },
                        textColor: Colors.white,
                        color: Colors.pink,
                      ),
                    ),
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

class GoalItem extends StatelessWidget {
  final String goal;
  final GoalsEnum title;

  var txtController = TextEditingController();

  GoalItem(this.title, this.goal);

  String goalTitle(GoalsEnum title) {
    switch (title) {
      case GoalsEnum.Meal:
        return 'Meal';
        break;
      case GoalsEnum.Workouts:
        return 'Workouts';
        break;
      case GoalsEnum.Water:
        return 'Water';
        break;
      case GoalsEnum.Sleep:
        return 'Sleep';
        break;
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    var goalData = Provider.of<GoalProvider>(context);
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 0.5, color: Colors.grey),
          borderRadius: BorderRadius.circular(5)),
      // margin: EdgeInsets.all(5),
      child: ListTile(
        leading: FlatButton(
            child: Text(
              'Change',
              style: TextStyle(color: Colors.green),
            ),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      contentPadding: EdgeInsets.all(0.0),
                      content: Container(
                        width: 200,
                        height: 250,
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(
                              'Push yourself'.toUpperCase(),
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            TextField(
                              controller: txtController,
                              cursorColor: Colors.green,
                              decoration: InputDecoration(
                                  labelText: 'Current goal is $goal',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    gapPadding: 5,
                                  )),
                              keyboardType: TextInputType.number,
                              style: TextStyle(color: Colors.green),
                            ),
                            Container(
                              width: double.infinity,
                              child: RaisedButton(
                                child: Text('Save'),
                                onPressed: () {
                                  // save new goal.
                                  goalData.update(title, txtController.text);
                                  print(txtController.text);
                                  Navigator.pop(context);
                                },
                                textColor: Colors.white,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            }),
        trailing: Chip(
          label: Text(
            goal,
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
          backgroundColor: Colors.green,
          padding: EdgeInsets.all(10),
        ),
        title: Text(
          this.goalTitle(title),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
