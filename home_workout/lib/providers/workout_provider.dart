import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:home_workout/db/db.dart';
import 'package:home_workout/models/workout.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class WorkoutProvider with ChangeNotifier {
  List<Workout> _workout = [
    // Workout(
    //   id: DateTime.now().toString(),
    //   name: 'LAUNCH',
    //   cal: 450,
    // ),
    // Workout(id: DateTime.now().toString(), name: 'BREAKFAST', cal: 650),
    // Workout(id: DateTime.now().toString(), name: 'SNACK', cal: 450),
    // Workout(
    //   id: DateTime.now().toString(),
    //   name: 'AFTER WORKOUT',
    //   cal: 200,
    // ),
  ];

  final table = 'workout';
  final myTable = 'myworkout';

  List<Workout> _myWorkout = [
    // Workout(id: DateTime.now().toString(), name: 'my 2', cal: 450),
    // Workout(id: DateTime.now().toString(), name: 'My 1', cal: 650),
    // Workout(id: DateTime.now().toString(), name: 'my 4', cal: 450),
    // Workout(id: DateTime.now().toString(), name: 'my 5', cal: 200),
  ];

  List<Workout> get workouts {
    return [..._workout];
  }

  List<Workout> get myWorkout {
    return [..._myWorkout];
  }

  int get getPrograss {
    int prograss = 0;
    _workout.forEach((m) => m.isChecked ? prograss += m.cal : null);
    return prograss;
  }

  Future<void> fetchAndSet() async {
    List workout = await DB.getAll(table);
    if (workout == null) {
      return;
    }
    _workout = workout.map(
      (w) {
        return Workout(
            id: w['id'],
            name: w['name'],
            cal: w['cal'],
            isChecked: w['isChecked'] == 1 ? true : false);
      },
    ).toList();
    notifyListeners();
  }

  // Future<void> fetchAndSetMyWorkout() async {
  //   List workout = await DB.getAll(myTable);
  //   if (workout == null) {
  //     return;
  //   }
  //   _myWorkout = workout.map(
  //     (w) {
  //       return Workout(id: w['id'], name: w['name'], cal: w['cal']);
  //     },
  //   ).toList();
  //   notifyListeners();
  // }
  Future<void> fetchAndSetMyWorkout() async {
    String url = 'http://10.0.2.2/api/workouts';

    try {
      // // var _token = await _getToken();
      // if (_token == false) {
      //   return;
      // }
      var localStorage = await SharedPreferences.getInstance();
      String _token = localStorage.getString('token');
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $_token"
      };

      final http.Response res = await http.get(url, headers: headers);
      if (res == null) {
        throw Exception();
      }
      print(json.decode(res.body));
      List content = json.decode(res.body)['data'];
      _myWorkout = content
          .map((workout) => Workout(
                id: workout['id'].toString(),
                name: workout['name'],
                cal: int.parse(workout['cal'].toString()),
              ))
          .toList();
      // print(_myMeals.map((m) => print(m.name)));
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  Workout findById(String id) {
    return _myWorkout.firstWhere((m) => m.id == id);
  }

  remove(String id) async {
    String url = 'http://10.0.2.2/api/workout/$id';

    try {
      final http.Response res = await http.delete(url);
      if (res == null) {
        print(json.decode(res.body));
        throw Exception();
      }
      print(json.decode(res.body));
      _myWorkout.removeWhere((w) => w.id == id);
      notifyListeners();
      DB.remove(myTable, id);
    } catch (e) {
      print(e.toString());
    }
  }

  removeWorkout(String id) {
    _workout.removeWhere((m) => m.id == id);
    notifyListeners();
    DB.remove(table, id);
  }

  checkWorkout(String id) {
    Workout workout = _workout.firstWhere((w) => w.id == id);
    workout.isChecked = !workout.isChecked;
    notifyListeners();
    DB.update(table, id, workout.name, workout.cal.toString(),
        workout.isChecked == true ? 1 : 0);
  }

  addWorkout(String name, String cal) {
    Workout workout = Workout(
      id: DateTime.now().toString(),
      name: name,
      cal: int.parse(cal),
    );

    _workout.add(workout);
    notifyListeners();
    DB.insert(table, {
      "id": workout.id,
      "name": workout.name,
      "cal": workout.cal,
      "isChecked": workout.isChecked == true ? 1 : 0
    });
  }

  addMyWorkout(String name, String cal) async {
    //   Workout workout = Workout(
    //     id: DateTime.now().toString(),
    //     name: name,
    //     cal: int.parse(cal),
    //   );

    //   _myWorkout.add(workout);
    //   notifyListeners();
    //   DB.insert(myTable, {
    //     "id": workout.id,
    //     "name": workout.name,
    //     "cal": workout.cal,
    //   });
    // }
    String url = 'http://10.0.2.2/api/workout';
    try {
      var localStorage = await SharedPreferences.getInstance();
      String _token = localStorage.getString('token');
      final res = await http.post(url,
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer $_token"
          },
          encoding: Encoding.getByName("utf-8"),
          body: json.encode({"name": name, "cal": cal}));

      final content = json.decode(res.body)['data'];
      print(content);

      if (res == null) {
        throw Exception();
      }
      Workout meal = Workout(
        id: content['id'],
        name: content['name'],
        cal: int.parse(content['cal'].toString()),
      );

      _myWorkout.add(meal);
      notifyListeners();
      // DB.insert(myTable, {
      //   "id": meal.id,
      //   "name": meal.name,
      //   "cal": meal.cal,
      // });
    } catch (e) {
      print(e.toString());
    }
  }

  updateWorkoutInfoWorkout({@required String id, String name, String cal}) {
    Workout workout = _workout.firstWhere((m) => m.id == id);
    if (name == null && cal == null) {
      return;
    }
    if (name != null) {
      workout.name = name;
    }
    if (cal != null) {
      workout.cal = int.parse(cal);
    }
    notifyListeners();
    DB.update(table, id, name, cal, workout.isChecked == true ? 1 : 0);
  }

  updateWorkoutInfoMyWorkout(
      {@required String id, String name, String cal}) async {
    //   Workout meal = _myWorkout.firstWhere((m) => m.id == id);
    //   if (name == null && cal == null) {
    //     return;
    //   }
    //   if (name != null) {
    //     meal.name = name;
    //   }
    //   if (cal != null) {
    //     meal.cal = int.parse(cal);
    //   }
    //   notifyListeners();
    //   DB.updateMy(myTable, id, name, cal);
    // }
    String url = 'http://10.0.2.2/api/workout';
    try {
      Workout workout = _myWorkout.firstWhere((m) => m.id == id);
      if (name == null && cal == null) {
        return;
      }
      if (name != null) {
        workout.name = name;
      }
      if (cal != null) {
        workout.cal = int.parse(cal);
      }

      final res = await http.put(url,
          // encoding: Encoding.getByName(''),
          //headers: {HttpHeaders.contentTypeHeader: "application/json"},
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json"
          },
          encoding: Encoding.getByName("utf-8"),
          body: json.encode({
            "id": id,
            "name": name,
            "cal": cal,
          }));

      final content = json.decode(res.body)['data'];

      notifyListeners();
      //DB.updateMy(myTable, id, name, cal);
    } catch (e) {
      print(e.toString());
    }
  }
}
