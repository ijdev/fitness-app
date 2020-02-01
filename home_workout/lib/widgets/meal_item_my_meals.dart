// import 'package:flutter/material.dart';
// import 'package:home_workout/providers/meal_provider.dart';
// import 'package:provider/provider.dart';

// class MealItemMyMeal extends StatefulWidget {
//   final String id;
//   final String name;
//   final int cal;
//   bool isChecked;

//   MealItemMyMeal(this.id, this.name, this.cal, this.isChecked);

//   @override
//   _MealItemMyMealState createState() => _MealItemMyMealState();

//   static showPop(BuildContext context, String id, String name, int cal,
//       {bool flag = false}) {
//     var mealData = Provider.of<MealProvider>(context, listen: false);
//     final nameController = TextEditingController();
//     final calController = TextEditingController();

//     if (flag) {
//       name = '';
//       cal = 0;
//     }

//     updateMeal(flag) {
//       if (flag) {
//         mealData.addMyMeals(nameController.text, calController.text);
//         Navigator.pop(context);
//       } else {
//         mealData.updateMealInfoMyMeals(
//             id: id, name: nameController.text, cal: calController.text);
//         Navigator.pop(context);
//       }
//     }

//     Widget generateLabel(flag) {
//       if (flag) {
//         return Text(
//           'Add Meal'.toUpperCase(),
//           style: TextStyle(
//               color: Colors.orange, fontSize: 20, fontWeight: FontWeight.bold),
//         );
//       } else {
//         return Text(
//           'Update Meal'.toUpperCase(),
//           style: TextStyle(
//               color: Colors.orange, fontSize: 20, fontWeight: FontWeight.bold),
//         );
//       }
//     }

//     showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             contentPadding: EdgeInsets.all(0.0),
//             content: Container(
//               width: 200,
//               height: 350,
//               padding: EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               alignment: Alignment.center,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: <Widget>[
//                   generateLabel(flag),
//                   TextField(
//                     controller: nameController..text = name,
//                     cursorColor: Colors.orange,
//                     decoration: InputDecoration(
//                         labelText: 'Meal name',
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                           gapPadding: 5,
//                         )),
//                     keyboardType: TextInputType.text,
//                     style: TextStyle(color: Colors.orange),
//                   ),
//                   TextField(
//                     controller: calController..text = '$cal',
//                     cursorColor: Colors.orange,
//                     decoration: InputDecoration(
//                         labelText: 'Meal cal',
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                           gapPadding: 5,
//                         )),
//                     keyboardType: TextInputType.number,
//                     style: TextStyle(color: Colors.orange),
//                   ),
//                   Container(
//                     width: double.infinity,
//                     child: RaisedButton(
//                       child: Text('Save'),
//                       onPressed: () => updateMeal(flag),
//                       textColor: Colors.white,
//                       color: Colors.orange,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         });
//   }
// }

// class _MealItemMyMealState extends State<MealItemMyMeal> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//           color: Colors.white,
//           border: Border.all(width: 0.5, color: Colors.grey),
//           borderRadius: BorderRadius.circular(5)),
//       margin: EdgeInsets.all(5),
//       child: ListTile(
//         onTap: () {
//           MealItemMyMeal.showPop(context, widget.id, widget.name, widget.cal);
//         },
//         leading: Chip(
//           label: Text(
//             '${widget.cal} cal',
//             style: TextStyle(color: Colors.white),
//           ),
//           backgroundColor: Colors.orange,
//           padding: EdgeInsets.all(10),
//         ),
//         title: Text(widget.name),
//         subtitle: Text('Tap here to change'),
//         trailing: IconButton(
//           icon: Icon(
//             Icons.delete,
//             color: Theme.of(context).errorColor,
//           ),
//           onPressed: () {
//             Provider.of<MealProvider>(context, listen: false).remove(widget.id);
//           },
//         ),
//       ),
//     );
//   }
// }

////////////////////////////////////////////////////////
///
///
///

import 'package:flutter/material.dart';
import 'package:home_workout/providers/meal_provider.dart';
import 'package:provider/provider.dart';

class MealItemMyMeal extends StatelessWidget {
  final String id;
  final String name;
  final int cal;
  bool isChecked;

  MealItemMyMeal(this.id, this.name, this.cal, this.isChecked);

  static showPop(BuildContext context, String id, String name, int cal,
      {bool flag = false}) {
    var mealData = Provider.of<MealProvider>(context, listen: false);
    final nameController = TextEditingController();
    final calController = TextEditingController();

    if (flag) {
      name = '';
      cal = 0;
    }

    updateMeal(flag) {
      if (flag) {
        mealData
            .addMyMeals(nameController.text, calController.text)
            .then((_) => mealData.fetchAndSetMyMeals());
        Navigator.pop(context);
      } else {
        mealData.updateMealInfoMyMeals(
            id: id, name: nameController.text, cal: calController.text);
        Navigator.pop(context);
      }
    }

    Widget generateLabel(flag) {
      if (flag) {
        return Text(
          'Add Meal'.toUpperCase(),
          style: TextStyle(
              color: Colors.orange, fontSize: 20, fontWeight: FontWeight.bold),
        );
      } else {
        return Text(
          'Update Meal'.toUpperCase(),
          style: TextStyle(
              color: Colors.orange, fontSize: 20, fontWeight: FontWeight.bold),
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
                    cursorColor: Colors.orange,
                    decoration: InputDecoration(
                        labelText: 'Meal name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          gapPadding: 5,
                        )),
                    keyboardType: TextInputType.text,
                    style: TextStyle(color: Colors.orange),
                  ),
                  TextField(
                    controller: calController..text = '$cal',
                    cursorColor: Colors.orange,
                    decoration: InputDecoration(
                        labelText: 'Meal cal',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          gapPadding: 5,
                        )),
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: Colors.orange),
                  ),
                  Container(
                    width: double.infinity,
                    child: RaisedButton(
                      child: Text('Save'),
                      onPressed: () => updateMeal(flag),
                      textColor: Colors.white,
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

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
          MealItemMyMeal.showPop(context, id, name, cal);
        },
        leading: Chip(
          label: Text(
            '${cal} cal',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.orange,
          padding: EdgeInsets.all(10),
        ),
        title: Text(name),
        subtitle: Text('Tap here to change'),
        trailing: IconButton(
          icon: Icon(
            Icons.delete,
            color: Theme.of(context).errorColor,
          ),
          onPressed: () {
            Provider.of<MealProvider>(context, listen: false).remove(id);
          },
        ),
      ),
    );
  }
}
