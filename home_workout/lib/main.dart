import 'package:flutter/material.dart';
import 'package:home_workout/providers/goal_provider.dart';
import 'package:home_workout/providers/meal_provider.dart';
import 'package:home_workout/providers/sleep_provider.dart';
import 'package:home_workout/providers/user_provider.dart';
import 'package:home_workout/providers/water_provider.dart';
import 'package:home_workout/providers/workout_provider.dart';
import 'package:home_workout/screens/bottom_nav_screen.dart';
import 'package:home_workout/screens/diatTabScreens/diat_goals_screen.dart';
import 'package:home_workout/screens/diatTabScreens/my_meals.dart';
import 'package:home_workout/screens/diatTabScreens/my_workout.dart';
import 'package:home_workout/screens/interactiveScreens/sleep_screen.dart';
import 'package:home_workout/screens/interactiveScreens/water_screen.dart';
import 'package:home_workout/screens/interactiveScreens/workout_screen.dart';
import 'package:home_workout/screens/interactiveScreens/meal_screen.dart';
import 'package:home_workout/screens/profile_Screen.dart';
import 'package:home_workout/screens/registerScreens/login_screen.dart';
import 'package:provider/provider.dart';

import 'screens/registerScreens/register_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => GoalProvider()),
        ChangeNotifierProvider(create: (_) => MealProvider()),
        ChangeNotifierProvider(create: (_) => WorkoutProvider()),
        ChangeNotifierProvider(create: (_) => WaterProvider()),
        ChangeNotifierProvider(create: (_) => SleepProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: RegisterScreen(), //TabsScreen(),
        routes: {
          TabsScreen.routeName: (_) => TabsScreen(),
          // SignupPage.routeName: (_) => SignupPage(),
          RegisterScreen.routeName: (_) => RegisterScreen(),
          LoginScreen.routeName: (_) => LoginScreen(),
          MealScreen.routeName: (_) => MealScreen(),
          WorkoutScreen.routeName: (_) => WorkoutScreen(),
          SleepScreen.routeName: (_) => SleepScreen(),
          WaterScreen.routeName: (_) => WaterScreen(),
          DiatGoals.routeName: (_) => DiatGoals(),
          MyWorkout.routeName: (_) => MyWorkout(),
          MyMeals.routeName: (_) => MyMeals(),
        },
      ),
    );
  }
}
