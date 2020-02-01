import 'package:flutter/material.dart';
import 'package:home_workout/models/meal.dart';
import 'package:home_workout/providers/goal_provider.dart';
import 'package:home_workout/providers/meal_provider.dart';
import 'package:provider/provider.dart';

import '../../widgets/meal_item.dart';

class MealScreen extends StatefulWidget {
  static const routeName = '/meal-screen';

  @override
  _MealScreenState createState() => _MealScreenState();
}

class _MealScreenState extends State<MealScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<MealProvider>(context, listen: false).fetchAndSet();
  }

  @override
  Widget build(BuildContext context) {
    var mealData = Provider.of<MealProvider>(context);
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
        backgroundColor: Colors.orange,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              MealItem.showPop(context, null, null, null, flag: true);
            },
          )
        ],
      ),
      body: Container(
        height: mq.height * 1,
        //padding: EdgeInsets.only(top: 20),
        color: Colors.orange,
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
                            '${mealData.getPrograss.toStringAsFixed(0)} out of ${goalData.goals.mealTarget.toStringAsFixed(0)}',
                            //'s',
                            style: TextStyle(
                              fontSize: 24,
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
                    Expanded(
                      child: ListView.builder(
                        itemCount: mealData.meals.length,
                        itemBuilder: (_, i) {
                          Meal meal = mealData.meals[i];
                          return mealData.meals.length <= 0
                              ? Center(child: Text('no '))
                              : Dismissible(
                                  key: Key(meal.id),
                                  onDismissed: (direction) {
                                    mealData.removeMeals(meal.id);
                                  },
                                  direction: DismissDirection.horizontal,
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
                                                  Navigator.of(context)
                                                      .pop(true);
                                                  mealData.removeMeals(meal.id);
                                                },
                                                child: const Text("DELETE")),
                                            FlatButton(
                                              onPressed: () =>
                                                  Navigator.of(context)
                                                      .pop(false),
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
                                  child: MealItem(meal.id, meal.name, meal.cal,
                                      meal.isChecked),
                                );
                        },
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
