import 'package:flutter/material.dart';
import 'package:home_workout/providers/meal_provider.dart';
import 'package:home_workout/providers/workout_provider.dart';
import 'package:provider/provider.dart';

class WorkItemMyWorkout extends StatefulWidget {
  final String id;
  final String name;
  final int cal;
  bool isChecked; // can't be final.

  WorkItemMyWorkout(this.id, this.name, this.cal, this.isChecked);

  @override
  _WorkItemMyWorkoutState createState() => _WorkItemMyWorkoutState();

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
        workData.addMyWorkout(nameController.text, calController.text);
        Navigator.pop(context);
      } else {
        workData.updateWorkoutInfoMyWorkout(
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
  }
}

class _WorkItemMyWorkoutState extends State<WorkItemMyWorkout> {
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
          WorkItemMyWorkout.showPop(
              context, widget.id, widget.name, widget.cal);
        },
        leading: Chip(
          label: Text(
            '${widget.cal} cal',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
          padding: EdgeInsets.all(10),
        ),
        title: Text(widget.name),
        subtitle: Text('Tap here to change'),
        trailing: IconButton(
          icon: Icon(
            Icons.delete,
            color: Colors.indigoAccent,
          ),
          onPressed: () {
            Provider.of<WorkoutProvider>(context, listen: false)
                .remove(widget.id);
          },
        ),
      ),
    );
  }
}
