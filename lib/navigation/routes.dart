import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hiits/ui/screens/main_screen/create_new_timer.dart';
import 'package:hiits/ui/screens/tabata_timer/workout_complete_screen.dart';
import './bottom_tab.dart';
import '../ui/screens/tabata_timer/countdown_screen.dart'; // Make sure this import is correct
import '../ui/screens/splash/splash_screen.dart';
import '../ui/screens/tabata_timer/track_timer_screen.dart';
import 'package:hiits/ui/screens/workout/create_custom_workout/circuit_workout/circuit_workout.dart';
import "package:hiits/ui/screens/workout/create_custom_workout/create_new_workout.dart";

class Routes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return ScreenUtilInit(
          designSize: Size(400, constraints.maxHeight < 570 ? 1200 : 900),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                brightness: Brightness.dark,
                scaffoldBackgroundColor: Color(0xFF252835),
                textTheme: const TextTheme(
                  displayLarge:
                      TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
                  titleLarge:
                      TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
                  bodyMedium: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
                ),
              ),
              initialRoute: '/',
              routes: {
                '/': (context) => SplashScreen(),
                '/BottomTab': (context) => BottomTab(),
                '/create_new_workout': (context) => CreateNewWorkout(),
                '/create_new_timer': (context) => createNewTimer(() {}),
                '/track_timer': (context) => TrackTimerScreen(),
                '/count_down': (context) =>
                    CountDownScreen(), // Ensure this route is correctly set up
                '/workout_complete': (context) => WorkoutCompleteScreen(),
                '/circuit_workout': (context) => circuitWorkout(),
              },
            );
          },
        );
      },
    );
  }
}
