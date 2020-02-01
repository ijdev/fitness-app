import 'package:flutter/foundation.dart';
import 'package:home_workout/db/db.dart';

class Sleep {
  String id;
  int hours;

  Sleep(this.id, this.hours);
}

class SleepProvider with ChangeNotifier {
  int _hours = 0;
  bool flag = false;
  final table = 'sleepFuck';

  double get hours {
    return _hours.toDouble();
  }

  setHours(s) async {
    _hours = s;
    notifyListeners();
    // DB.insert(table, {
    //   //"id": DateTime.now().toString(),
    //   "hours": _hours,
    // });
    await DB.insertUpdateSleep(table, _hours).catchError((e) => print(e));
  }

  Future<void> fetchAndSet() async {
    List sleep = await DB.getAll(table);
    if (sleep == null) {
      return;
    }
    _hours = sleep[0]['hours']; //sleep[0];
    notifyListeners();
  }
}
