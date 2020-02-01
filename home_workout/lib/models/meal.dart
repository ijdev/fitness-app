import 'package:flutter/foundation.dart';

class Meal {
  final String id;
  String name;
  int cal;
  bool isChecked;

  Meal(
      {@required this.id,
      @required this.name,
      @required this.cal,
      this.isChecked = false});
}
