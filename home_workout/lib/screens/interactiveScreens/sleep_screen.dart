import 'package:flutter/material.dart';

import '../../providers/goal_provider.dart';
import '../../providers/sleep_provider.dart';
import 'package:provider/provider.dart';

class SleepScreen extends StatefulWidget {
  static const routeName = '/sleep-screen';

  @override
  _SleepScreenState createState() => _SleepScreenState();
}

class _SleepScreenState extends State<SleepScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<SleepProvider>(context, listen: false).fetchAndSet();
  }

  @override
  Widget build(BuildContext context) {
    var sleepData = Provider.of<SleepProvider>(context);
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
        backgroundColor: Colors.purple,
      ),
      body: Container(
        height: mq.height * 1,
        //padding: EdgeInsets.only(top: 20),
        color: Colors.purple,
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
                            '${sleepData.hours.toStringAsFixed(0)} out of ${goalData.goals.sleepTarget.toStringAsFixed(0)}',
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.purple,
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
                    Container(
                      //height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.all(20),
                      child: Slider(
                        activeColor: Colors.purple,
                        value: sleepData.hours,
                        onChanged: (n) {
                          sleepData.setHours(n.toInt());
                        },
                        divisions: goalData.goals.sleepTarget == 0
                            ? 24
                            : goalData.goals.sleepTarget,
                        //divisions: 15,
                        label: '${sleepData.hours}',
                        min: 0.0,
                        max: goalData.goals.sleepTarget == 0
                            ? 24.0
                            : goalData.goals.sleepTarget.toDouble(),
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
