import 'package:flutter/foundation.dart';

class Workout {
  String id;
  String name;
  int cal;
  bool isChecked;

  Workout(
      {@required this.id,
      @required this.name,
      @required this.cal,
      this.isChecked = false});
}
