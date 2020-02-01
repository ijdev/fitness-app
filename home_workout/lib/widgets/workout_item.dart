import 'package:flutter/material.dart';
import 'package:home_workout/models/workout.dart';
import 'package:home_workout/providers/workout_provider.dart';
import 'package:provider/provider.dart';

class WorkoutItem extends StatefulWidget {
  final String id;
  final String name;
  final int cal;
  bool isChecked;

  WorkoutItem(this.id, this.name, this.cal, this.isChecked);

  @override
  _WorkoutItemState createState() => _WorkoutItemState();

  static showPop(BuildContext context, String id, String name, int cal,
      {bool flag = false}) {
    var workData = Provider.of<WorkoutProvider>(context, listen: false);
    final nameController = TextEditingController();
    final calController = TextEditingController();

    if (flag) {
      name = '';
      cal = 0;
    }

    updateWorkout(flag) {
      if (flag) {
        workData.addWorkout(nameController.text, calController.text);
        Navigator.pop(context);
      } else {
        workData.updateWorkoutInfoWorkout(
            id: id, name: nameController.text, cal: calController.text);
        Navigator.pop(context);
      }
    }

    Widget generateLabel(flag) {
      if (flag) {
        return Text(
          'Add Workout'.toUpperCase(),
          style: TextStyle(
              color: Colors.red, fontSize: 20, fontWeight: FontWeight.bold),
        );
      } else {
        return Text(
          'Update Workout'.toUpperCase(),
          style: TextStyle(
              color: Colors.red, fontSize: 20, fontWeight: FontWeight.bold),
        );
      }
    }

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.all(0.0),
            content: Container(
              width: 200,
              height: 350,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  generateLabel(flag),
                  DropdownButtonHideUnderline(
                    child: DropdownButton(
                      isExpanded: true,
                      hint: Text('or choose from your workouts!',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.blue)),
                      items: workData.myWorkout
                          .map((m) => DropdownMenuItem(
                                child: Text(m.name),
                                value: m.id,
                              ))
                          .toList(),
                      onChanged: (value) {
                        Workout m = workData.findById(value);
                        nameController.text = m.name;
                        calController.text = m.cal.toString();
                        print(m.name);
                      },
                    ),
                  ),
                  TextField(
                    controller: nameController..text = name,
                    cursorColor: Colors.red,
                    decoration: InputDecoration(
                        labelText: 'Workout name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          gapPadding: 5,
                        )),
                    keyboardType: TextInputType.text,
                    style: TextStyle(color: Colors.red),
                  ),
                  SizedBox(height: 4), // TODO SizedBox
                  TextField(
                    controller: calController..text = '$cal',
                    cursorColor: Colors.red,
                    decoration: InputDecoration(
                        labelText: 'Workout cal',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          gapPadding: 5,
                        )),
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: Colors.red),
                  ),
                  Container(
                    width: double.infinity,
                    child: RaisedButton(
                      child: Text('Save'),
                      onPressed: () => updateWorkout(flag),
                      textColor: Colors.white,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  } // showPop
} // class

class _WorkoutItemState extends State<WorkoutItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 0.5, color: Colors.grey),
          borderRadius: BorderRadius.circular(5)),
      margin: EdgeInsets.all(5),
      child: ListTile(
        onTap: () {
          WorkoutItem.showPop(context, widget.id, widget.name, widget.cal);
        },
        trailing: Chip(
          label: Text(
            '${widget.cal} cal',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
          padding: EdgeInsets.all(10),
        ),
        title: Text(widget.name),
        subtitle: Text('Tap here to change'),
        leading: Checkbox(
          checkColor: Colors.red,
          activeColor: Colors.white,
          onChanged: (bool value) {
            setState(() {
              widget.isChecked = !widget.isChecked;
            });
            Provider.of<WorkoutProvider>(context, listen: false)
                .checkWorkout(widget.id);
          },
          value: widget.isChecked,
        ),
      ),
    );
  }
}
