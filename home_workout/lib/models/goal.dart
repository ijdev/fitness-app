import 'package:flutter/cupertino.dart';

class Goal {
  String id;
  int mealTarget;
  int workTarget;
  int sleepTarget;
  int waterTarget;

  Goal({
    this.id = 'id',
    @required this.mealTarget,
    @required this.workTarget,
    this.waterTarget = 0,
    this.sleepTarget = 0,
  });
}
