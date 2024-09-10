import 'package:flutter/material.dart';
import '../../widgets/workout_widgets/workouts.dart';
import "../../widgets/others/horizontal_layout.dart";

// Custom Workout's screen
import '../../widgets/circuit_workout/custom_created_workout.dart';

import '../../screens/workout/create_custom_workout/circuit_workout/circuit_workout.dart';

class WorkoutPresets extends StatefulWidget {
  final List<String>? savedWorkouts;
  final String? workoutNameController;
  final deleteCustomWorkout;
  const WorkoutPresets(
      {Key? key,
      this.workoutNameController,
      this.savedWorkouts,
      this.deleteCustomWorkout});

  @override
  _WorkoutPresets createState() => _WorkoutPresets();
}

class _WorkoutPresets extends State<WorkoutPresets>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final double _screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF252835),
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                print("Hello from menu");
              },
              icon: Image.asset(
                'assets/icons/sidebar_icon.png',
                height: 24, // Adjust height as needed
              )),
          title: Center(
              child: Image.asset(
            "assets/icons/hiits_workout_logo.png",
          )),
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  print("Hello from music icon");
                },
                icon: Image.asset(
                  'assets/icons/music_icon.png',
                  height: 44, // Adjust height as needed
                  width: 80,
                ))
          ],
        ),
        body: Stack(children: <Widget>[
          Container(
              color: Color(0xFF252835),
              height: _screenHeight,
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  HorizontalLayout(
                    name: "Workout presets",
                    rightItem: "View all",
                    image: 'assets/icons/view_all.png',
                    onPressed: () => print("View Pressed"),
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Workouts(
                      title: 'Chest Workout',
                      sets: 34,
                      rounds: 12,
                      hours: 40,
                      minutes: 12,
                      image: "assets/icons/chest_workout.png",
                    )
                  ]),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Workouts(
                      title: 'Arm workout',
                      sets: 34,
                      rounds: 12,
                      hours: 40,
                      minutes: 12,
                      image: "assets/icons/arm_workout.png",
                    )
                  ]),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Workouts(
                      title: 'Ab workout',
                      sets: 34,
                      rounds: 12,
                      hours: 40,
                      minutes: 12,
                      image: "assets/icons/ab_workout.png",
                    )
                  ]),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Workouts(
                      title: 'Leg workout',
                      sets: 34,
                      rounds: 12,
                      hours: 40,
                      minutes: 12,
                      image: "assets/icons/leg_workout.png",
                    )
                  ]),
                  HorizontalLayout(
                      name: "Custom workouts",
                      rightItem: "New",
                      image: 'assets/icons/new.png',
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => circuitWorkout(),
                            ));
                      }),

                  // SingleChildScrollView(child: Column(children: []),),

                  CustomCreatedWorkout(
                      workoutNameController: widget.workoutNameController,
                      savedWorkouts: widget.savedWorkouts,
                      deleteCustomWorkout: widget.deleteCustomWorkout),
                ],
              )))
        ]));
  }
}
