import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:home_workout/models/meal.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../db/db.dart';
import 'package:http/http.dart' as http;

class MealProvider with ChangeNotifier {
  List<Meal> _meals = [
    // Meal(
    //   id: DateTime.now().toString(),
    //   name: 'LAUNCH',
    //   cal: 450,
    // ),
    // Meal(id: DateTime.now().toString(), name: 'BREAKFAST', cal: 650),
    // Meal(id: DateTime.now().toString(), name: 'SNACK', cal: 450),
    // Meal(
    //   id: DateTime.now().toString(),
    //   name: 'AFTER WORKOUT',
    //   cal: 200,
    // ),
  ];

  final table = 'meals'; // newtable.
  final myTable = 'mymeals';

  List<Meal> _myMeals = [
    // Meal(id: DateTime.now().toString(), name: 'my 2', cal: 450),
    // Meal(id: DateTime.now().toString(), name: 'My 1', cal: 650),
    // Meal(id: DateTime.now().toString(), name: 'my 4', cal: 450),
    // Meal(id: DateTime.now().toString(), name: 'my 5', cal: 200),
  ];

  List<Meal> get meals {
    return [..._meals];
  }

  List<Meal> get myMeals {
    return [..._myMeals];
  }

  int get getPrograss {
    int prograss = 0;
    _meals.forEach((m) => m.isChecked ? prograss += m.cal : 0);
    return prograss;
  }

  Future<void> fetchAndSet() async {
    List meals = await DB.getAll(table);
    if (meals == null) {
      return;
    }
    _meals = meals.map(
      (m) {
        print(m['cal'].runtimeType);
        print(m['cal']);

        return Meal(
            id: m['id'],
            name: m['name'],
            //cal: int.parse(m['cal']),
            cal: 0,
            isChecked: m['isChecked'] == 1 ? true : false);
      },
    ).toList();
    notifyListeners();
  }

  // Future<void> fetchAndSetMyMeals() async {
  //   List meals = await DB.getAll(myTable);
  //   if (meals == null) {
  //     return;
  //   }
  //   _myMeals = meals.map(
  //     (m) {
  //       return Meal(
  //         id: m['id'],
  //         name: m['name'],
  //         cal: m['cal'],
  //       );
  //     },
  //   ).toList();
  //   notifyListeners();
  // }

  Future<void> fetchAndSetMyMeals() async {
    String url = 'http://10.0.2.2/api/meals';

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
      _myMeals = content
          .map((meal) => Meal(
                id: meal['id'].toString(),
                name: meal['name'],
                cal: int.parse(meal['cal'].toString()),
              ))
          .toList();
      // print(_myMeals.map((m) => print(m.name)));
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  Meal findById(String id) {
    return _myMeals.firstWhere((m) => m.id == id);
  }

  Future<void> remove(String id) async {
    String url = 'http://10.0.2.2/api/meal/$id';

    try {
      final http.Response res = await http.delete(url);
      if (res == null) {
        print(json.decode(res.body));
        throw Exception();
      }
      print(json.decode(res.body));
      _myMeals.removeWhere((m) => m.id == id);
      notifyListeners();
      DB.remove(myTable, id);
    } catch (e) {
      print(e.toString());
    }
  }

  removeMeals(String id) {
    _meals.removeWhere((m) => m.id == id);
    DB.remove(table, id);
    notifyListeners();
  }

  checkMeal(String id) {
    Meal meal = _meals.firstWhere((m) => m.id == id);
    meal.isChecked = !meal.isChecked;
    notifyListeners();
    DB.update(table, id, meal.name, meal.cal.toString(),
        meal.isChecked == true ? 1 : 0);
  }

  addMeals(String name, String cal) {
    Meal meal = Meal(
      id: DateTime.now().toString(),
      name: name,
      cal: int.parse(cal),
    );
    _meals.add(meal);
    notifyListeners();

    DB.insert(table, {
      "id": meal.id,
      "name": meal.name,
      "cal": meal.cal,
      "isChecked": meal.isChecked == true ? 1 : 0
    });
  }

  Future<void> addMyMeals(String name, String cal) async {
    String url = 'http://10.0.2.2/api/meal';
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
      Meal meal = Meal(
        id: content['id'],
        name: content['name'],
        cal: int.parse(content['cal'].toString()),
      );

      _myMeals.add(meal);
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

  updateMealInfoMeals({@required String id, String name, String cal}) {
    Meal meal = _meals.firstWhere((m) => m.id == id);
    if (name == null && cal == null) {
      return;
    }
    if (name != null) {
      meal.name = name;
    }
    if (cal != null) {
      meal.cal = int.parse(cal);
    }

    DB.update(table, id, name, cal, meal.isChecked == true ? 1 : 0);
    notifyListeners();
  }

  Future<void> updateMealInfoMyMeals({
    @required String id,
    String name,
    String cal,
  }) async {
    String url = 'http://10.0.2.2/api/meal';
    try {
      Meal meal = _myMeals.firstWhere((m) => m.id == id);
      if (name == null && cal == null) {
        return;
      }
      if (name != null) {
        meal.name = name;
      }
      if (cal != null) {
        meal.cal = int.parse(cal);
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
