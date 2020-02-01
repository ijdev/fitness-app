import 'package:flutter/material.dart';
import 'package:home_workout/models/meal.dart';
import 'package:home_workout/providers/meal_provider.dart';
import 'package:provider/provider.dart';
import '../../widgets/meal_item_my_meals.dart';

class MyMeals extends StatefulWidget {
  static const routeName = '/my-meal';

  @override
  _MyMealsState createState() => _MyMealsState();
}

class _MyMealsState extends State<MyMeals> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<MealProvider>(context, listen: false)
        .fetchAndSetMyMeals()
        .catchError((onError) => print('from widget'));
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    var mealData = Provider.of<MealProvider>(context);

    var mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'MY MEALS',
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.orange,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              MealItemMyMeal.showPop(context, null, null, null, flag: true);
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
                          itemCount: mealData.myMeals.length,
                          itemBuilder: (_, i) {
                            Meal meal = mealData.myMeals[i];
                            return MealItemMyMeal(
                              meal.id,
                              meal.name,
                              meal.cal,
                              meal.isChecked,
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
