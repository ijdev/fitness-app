import 'package:flutter/material.dart';
import '../../providers/goal_provider.dart';
import '../../providers/water_provider.dart';
import 'package:provider/provider.dart';

class WaterScreen extends StatefulWidget {
  static const routeName = '/water-screen';

  @override
  _WaterScreenState createState() => _WaterScreenState();
}

class _WaterScreenState extends State<WaterScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<WaterProvider>(context, listen: false).fetchAndSet();
  }

  @override
  Widget build(BuildContext context) {
    var waterData = Provider.of<WaterProvider>(context);
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
        backgroundColor: Colors.blue,
      ),
      body: Container(
        height: mq.height * 1,
        //padding: EdgeInsets.only(top: 20),
        color: Colors.blue,
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Column(
                        children: <Widget>[
                          Text(
                            '${waterData.water.toStringAsFixed(0)} out of ${goalData.goals.waterTarget.toStringAsFixed(0)}',
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.blue,
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          RawMaterialButton(
                            onPressed: () {
                              waterData.deleteWater();
                            },
                            child: new Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.white,
                              size: 35.0,
                            ),
                            shape: new CircleBorder(),
                            elevation: 2.0,
                            fillColor: Colors.blue,
                            padding: const EdgeInsets.all(15.0),
                          ),
                          Container(
                              decoration: BoxDecoration(
                                  //color: Colors.blue,
                                  borderRadius: BorderRadius.circular(50)),
                              alignment: Alignment.center,
                              child: Text(
                                waterData.water.toString(),
                                style:
                                    TextStyle(color: Colors.blue, fontSize: 34),
                              )),
                          RawMaterialButton(
                            onPressed: () {
                              waterData.addWater();
                            },
                            child: new Icon(
                              Icons.keyboard_arrow_up,
                              color: Colors.white,
                              size: 35.0,
                            ),
                            shape: new CircleBorder(),
                            elevation: 2.0,
                            fillColor: Colors.blue,
                            padding: const EdgeInsets.all(15.0),
                          ),
                        ],
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
