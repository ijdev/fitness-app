import 'package:flutter/cupertino.dart';
import 'package:home_workout/db/db.dart';

class WaterProvider with ChangeNotifier {
  int _water = 0;
  final table = 'water';

  get water {
    return _water;
  }

  Future<void> fetchAndSet() async {
    List water = await DB.getAll(table);
    if (water.isEmpty) {
      return;
    } else {
      print(water);
      _water = water[0]['water']; //
      notifyListeners();
    }
  }

  addWater() {
    if (_water >= 50) {
      return;
    }
    _water += 1;
    notifyListeners();
    DB.insertUpdateWater(table, _water);
  }

  deleteWater() {
    if (_water == 0) {
      return;
    }
    _water -= 1;
    notifyListeners();
  }
}
