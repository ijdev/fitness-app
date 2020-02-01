import 'package:flutter/foundation.dart';
import 'package:home_workout/db/db.dart';
import 'package:home_workout/enums/goals_enums.dart';
import 'package:home_workout/models/goal.dart';

class GoalProvider with ChangeNotifier {
  Goal _goal = Goal(mealTarget: 0, workTarget: 0);
  final table = 'goals';
  Goal get goals {
    return _goal;
  }

  void reset() {
    this._goal.mealTarget = 0;
    this._goal.workTarget = 0;
    this._goal.waterTarget = 0;
    this._goal.sleepTarget = 0;
    notifyListeners();
  }

  Future<void> fetchAndSet() async {
    List goals = await DB.getAll(table);
    if (goals == null || goals.isEmpty) {
      return;
    }
    print(goals);
    _goal = goals
        .map((g) => Goal(
            mealTarget: g['mealGoal'],
            workTarget: g['workoutGoal'],
            sleepTarget: g['sleepGoal'],
            waterTarget: g['waterGoal']))
        .toList()[0];
    notifyListeners();
  }

  void update(GoalsEnum goals, value) {
    value = int.parse(value);
    switch (goals) {
      case GoalsEnum.Meal:
        _goal.mealTarget = value;
        break;
      case GoalsEnum.Workouts:
        _goal.workTarget = value;
        break;
      case GoalsEnum.Water:
        _goal.waterTarget = value;
        break;
      case GoalsEnum.Sleep:
        _goal.sleepTarget = value;
        break;
      default:
        print('error');
    }
    notifyListeners();
    DB.setAndUpdateGoals(table, _goal.mealTarget, _goal.workTarget,
        _goal.sleepTarget, _goal.waterTarget);
  }
}
