import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hiits/appassets/apptextstyle.dart';
import 'package:hiits/navigation/bottom_tab.dart';
import 'package:hiits/ui/screens/workout/custom_workouts/custom_workouts.dart';
import 'package:hiits/ui/widgets/buttons/border_button.dart';
import 'package:hiits/ui/widgets/circuit_workout/Exercises_every_round.dart';
import 'package:hiits/ui/widgets/circuit_workout/exercise_library.dart';
import 'package:hiits/ui/widgets/circuit_workout/draggable_sheet.dart';
import 'package:hiits/ui/screens/workout/create_custom_workout/create_new_workout.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiits/appassets/apsizedbox.dart';
import 'package:hiits/ui/screens/workout/create_custom_workout/controllerworkout/controllerworkout.dart';
import 'package:hiits/ui/screens/workout/custom_workouts/custom_workouts.dart';
import 'package:hiits/ui/widgets/timer_widgets/set_time_section.dart';
import '../../screens/workout/create_custom_workout/controllerworkout/controllerworkout.dart';

class editCircuitWorkout extends StatefulWidget {
  final int index;
  final String durationtext;
  editCircuitWorkout(
      {super.key, t, required this.index, required this.durationtext});
  @override
  State<editCircuitWorkout> createState() => _editCircuitWorkout();
}

class _editCircuitWorkout extends State<editCircuitWorkout> {
  bool showCreateNewTimer = false;
  bool showCreatedTimer = false;

  bool showWorkoutPresets = false;
  int totalRounds = 8;
  int totalSets = 0;
  late String name;
  int cool_down = 0;
  int total_sets = 8;
  int work_seconds = 20;
  int work_minutes = 0;
  int rest_minutes = 0;
  int rest_seconds = 10;
  int cool_down_minutes = 0;
  int cool_down_seconds = 10;
  int totaltime = 0;
  int total_hours = 0;

  List timers = [];
  List exerciseTimers = [];
  final TextEditingController _nameController = TextEditingController();
  bool _isButtonEnabled = false;
  bool _isTextAdded = false;

  List<dynamic> exercises = [];

  double initialHeight = 120.0;

  @override
  void initState() {
    super.initState();
    loadExercises(); // Automatically load exercises when widget is initialized
    _loadSavedWorkouts();
    calculateTotalDuration();
  }

  void resetHeight() {
    setState(() {
      initialHeight = 120.0; // Reset to the initial height
    });
  }

  final controller = Get.put(WorkoutController());
  Future<void> loadExercises() async {
    String jsonString = await rootBundle.loadString('lib/data/data.json');
    Map<String, dynamic> data = jsonDecode(jsonString);
    List<dynamic> exerciseList = data['Exercise List'];

    setState(() {
      exercises = exerciseList;
    });

    // Print the loaded exercises
    print('Loaded exercises:');
    exercises.forEach((exercise) {
      print(exercise['General Muscle Group']);
    });
  }

  List<String> selectedExercises = [];

  TextEditingController _workoutNameController = TextEditingController();

  List<String> savedWorkouts = [];
  String durationText = '00:00';
  void calculateTotalDuration() {
    // Converting all values to total seconds
    int workTotalSeconds = (work_minutes * 60) + work_seconds;
    int restTotalSeconds = (rest_minutes * 60) + rest_seconds;
    int coolDownTotalSeconds = (cool_down_minutes * 60) + cool_down_seconds;

    // Total workout time including all rounds and cooldown
    int totalDurationSeconds =
        (workTotalSeconds + restTotalSeconds) * total_sets +
            coolDownTotalSeconds;

    // Convert total seconds back to minutes and seconds
    int totalMinutes = totalDurationSeconds ~/ 60;
    int totalSeconds = totalDurationSeconds % 60;

    // Format the total duration into MM:SS
    String formattedDuration =
        "${totalMinutes.toString().padLeft(2, '0')}:${totalSeconds.toString().padLeft(2, '0')}";

    // Update the state to display total duration
    setState(() {
      totaltime = totalDurationSeconds;
      durationText = formattedDuration; // Update the duration text to MM:SS
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    // double initialHeight = 100.0;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF252835),
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => customWorkouts(),
                  ),
                );
              },
              icon: Image.asset(
                'assets/icons/goBack.png',
                height: 24, // Adjust height as needed
              )),
          title: Center(child: Text("Circuit", style: AppTextStyles.medium)),
          actions: <Widget>[
            // IconButton(
            //     onPressed: () {
            //       print("Hello from music icon");
            //     },
            //     icon: Image.asset(
            //       'assets/icons/music_icon.png',
            //       height: 44, // Adjust height as needed
            //       width: 80,
            //     ))
          ],
        ),
        body: Stack(
          children: <Widget>[
            Container(
                height: screenHeight * 0.70,
                color: Color(0xFF252835),
                // color: Color(0xFFffffff),
                child: SingleChildScrollView(
                  child: Column(children: [
                    Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Color(0xFF2C313F),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(12.w),
                                topLeft: Radius.circular(12.w),
                                bottomLeft: Radius.circular(12.w),
                                bottomRight: Radius.circular(12.w),
                              ),
                            ),
                            width: MediaQuery.of(context).size.width * .90,
                            height: MediaQuery.of(context).size.height *
                                0.14, // Add this line
                            // height: 95.0.h,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                          padding: EdgeInsets.all(0.0),
                                          child: Container(
                                              alignment: Alignment.center,
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: 15.w, top: 10.w),
                                                child: Text("$total_sets",
                                                    style:
                                                        AppTextStyles.heading1),
                                              ))),
                                      Padding(
                                          padding: EdgeInsets.only(top: 8),
                                          child: Container(
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  color: Color(0xFF2C313F),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    bottomRight:
                                                        Radius.circular(12.w),
                                                    bottomLeft:
                                                        Radius.circular(12.w),
                                                  )),
                                              child: Padding(
                                                padding:
                                                    EdgeInsets.only(left: 15),
                                                child: Text(
                                                  "TOTAL SETS",
                                                  style: TextStyle(
                                                      fontFamily: 'InterBold',
                                                      fontSize: 13,
                                                      color: Color(0Xff878894)),
                                                ),
                                              ))),
                                    ]),
                                Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                          padding: EdgeInsets.all(0.0),
                                          child: Container(
                                              alignment: Alignment.center,
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: 15.w, top: 10.w),
                                                child: Text(
                                                  durationText,
                                                  style: AppTextStyles.heading1,
                                                ),
                                              ))),
                                      Padding(
                                          padding: EdgeInsets.all(0.0),
                                          child: Container(
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  color: Color(0xFF2C313F),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    bottomRight:
                                                        Radius.circular(12.w),
                                                    bottomLeft:
                                                        Radius.circular(12.w),
                                                  )),
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    top: 8, left: 15),
                                                child: Text(
                                                  "DURATION",
                                                  style: TextStyle(
                                                      fontFamily: 'InterBold',
                                                      fontSize: 13,
                                                      color: Color(0Xff878894)),
                                                ),
                                              ))),
                                    ]),
                                Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                          padding: EdgeInsets.all(0.0),
                                          child: Container(
                                              // alignment: Alignment.end,
                                              child: Padding(
                                            padding: EdgeInsets.only(
                                                left: 15.w, top: 10.w),
                                            child: Text('$totalRounds',
                                                style: AppTextStyles.heading1),
                                          ))),
                                      Padding(
                                          padding: EdgeInsets.only(top: 8.w),
                                          child: Container(
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  color: Color(0xFF2C313F),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    bottomRight:
                                                        Radius.circular(12.w),
                                                    bottomLeft:
                                                        Radius.circular(12.w),
                                                  )),
                                              child: Padding(
                                                padding:
                                                    EdgeInsets.only(left: 15.w),
                                                child: Text(
                                                  "ROUNDS",
                                                  style: TextStyle(
                                                      fontFamily: 'InterBold',
                                                      fontSize: 13,
                                                      color: Color(0Xff878894)),
                                                ),
                                              ))),
                                    ]),
                              ],
                            ))),
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      width: MediaQuery.of(context).size.width * .90,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: selectedExercises.map((exercise) {
                          return Container(
                            margin: EdgeInsets.symmetric(
                                vertical:
                                    5), // Adjust vertical spacing between exercise containers
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Color(0xFF2C313F),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            width: MediaQuery.of(context).size.width * 0.90,
                            height: 60.0,
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(exercise,
                                        textAlign: TextAlign.center,
                                        style: AppTextStyles.medium.copyWith(
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  bottom: 0,
                                  right: 0,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedExercises.remove(exercise);
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: IconButton(
                                        icon: Image.asset(
                                          "assets/icons/Delete.png",
                                          width: 30,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            total_setsDecrementCounter();

                                            selectedExercises.remove(exercise);
                                            updateSelectedExercises(
                                                selectedExercises);
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    borderButton(
                      buttonText: "+ Add Exercise",
                      onPressed: () {
                        // Open DraggableSheet with exerciseLibrary
                        showModalBottomSheet(
                          context: context,

                          isScrollControlled:
                              true, // Set to true to allow the bottom sheet to expand
                          builder: (context) {
                            return Container(
                              height: MediaQuery.of(context).size.height * 0.9 -
                                  10, // 80% of screen height
                              // color: Colors
                              //     .transparent, // Set a transparent background color
                              color: Colors.transparent
                                  .withOpacity(0.6), // 50% opacity

                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(
                                      30.0), // Adjust the radius as needed
                                  topRight: Radius.circular(
                                      30.0), // Adjust the radius as needed
                                ),
                                child: Container(
                                    color: Color(
                                        0xFF2C313F), // Set your desired background color here

                                    child: ExerciseLibrary(
                                      exercises: exercises,
                                      selectedExercises: selectedExercises,
                                      updateSelectedExercises:
                                          (List<String> updatedExercises) {
                                        setState(() {
                                          selectedExercises = updatedExercises;
                                        });
                                      },
                                      totalSetsIncrementCounter:
                                          total_setsincrementCounter,
                                    )),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ]),
                )),
            DraggableSheet(
                isVisible: true, // Show bottom sheet by default
                initialHeight: initialHeight, // Set initial height here

                child: Stack(
                  children: [
                    Positioned(
                      top: 0.0,
                      left: 0.0,
                      right: 0.0,
                      child: Center(
                        child: Container(
                          // color: Color(0xFF2C313F),

                          margin: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.4 -
                                      8), // Adjust the value as needed
                          width: 20.0,
                          height: 4.0,
                          decoration: BoxDecoration(
                            color: Color(0xffffffff).withOpacity(0.3),
                            // color: Color(0xFF2C313F),

                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                    EditexercisesEveryRound(
                      initialTotalRounds: totalRounds,
                      durationtext: widget.durationtext,
                      total_roundsDecrementCounter:
                          total_roundsDecrementCounter,
                      total_roundsincrementCounter:
                          total_roundsincrementCounter,
                      onClose: resetHeight,
                      name: _workoutNameController.text,
                      index: widget.index,
                    ),
                  ],
                )),
          ],
        ));
  }

  bool _containsLetter(String input) {
    // Regular expression to check if input contains any alphabetic characters
    RegExp regex = RegExp(r'[a-zA-Z]');
    return regex.hasMatch(input);
  }

  void updateSelectedExercises(List<String> updatedExercises) {
    setState(() {
      selectedExercises = updatedExercises;
    });
  }

  Future<void> _loadSavedWorkouts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      savedWorkouts = prefs.getStringList('workouts') ?? [];
    });
  }

  void _saveCustomWorkout() async {
    // Save text logic here
    String enteredText = _workoutNameController.text;
    if (enteredText.isNotEmpty) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> workouts = prefs.getStringList('workouts') ?? [];
      workouts.add(enteredText);
      await prefs.setStringList('workouts', workouts);
      _workoutNameController.clear();
      // Navigate to show workouts page

      // Set showWorkouts to true

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => BottomTab(
                    initialIndex: 1,
                  )));
    }
  }

  @override
  void dispose() {
    _workoutNameController.dispose();
    super.dispose();
  }

  void total_roundsDecrementCounter() {
    setState(() {
      totalRounds--;
    });
    if (totalRounds < 0) {
      setState(() {
        totalRounds++;
      });
    }
  }

  void total_roundsincrementCounter() {
    setState(() {
      totalRounds++;
    });
  }

  void total_setsDecrementCounter() {
    setState(() {
      totalSets--;
    });
  }

  void total_setsincrementCounter() {
    setState(() {
      totalSets++;
    });
  }

  void cool_downDecrementCounter() {
    setState(() {
      if (cool_down_minutes <= 0 && cool_down_seconds <= 0) {
        cool_down_minutes;
        cool_down_seconds;
      } else if (cool_down_seconds == 0) {
        cool_down_minutes--;
        cool_down_seconds = 59;
      } else {
        cool_down_seconds--;
      }
    });
  }

  void cool_downincrementCounter() {
    setState(() {
      if (cool_down_minutes == 9 && cool_down_seconds == 59) {
        cool_down_minutes = 0;
        cool_down_seconds = 0;
      } else if (cool_down_seconds == 59) {
        cool_down_minutes++;
        cool_down_seconds = 0;
      } else {
        cool_down_seconds++;
      }
    });
  }

  void workDecrementCounter() {
    setState(() {
      if (work_minutes <= 0 && work_seconds <= 0) {
        work_minutes;
        work_seconds;
        print("minuuus");
      } else if (work_seconds == 0) {
        work_minutes--;
        work_seconds = 59;
      } else {
        work_seconds--;
      }
    });
  }

  void workincrementCounter() {
    setState(() {
      if (work_minutes == 9 && work_seconds == 59) {
        work_minutes = 0;
        work_seconds = 0;
      } else if (work_seconds == 59) {
        work_minutes++;
        work_seconds = 0;
      } else {
        work_seconds++;
      }
    });
  }
}

class EditexercisesEveryRound extends StatefulWidget {
  final int initialTotalRounds;
  final VoidCallback total_roundsincrementCounter;
  final VoidCallback total_roundsDecrementCounter;
  final VoidCallback onClose;
  final String name;
  final String durationtext;
  final int index;
  EditexercisesEveryRound({
    required this.initialTotalRounds,
    required this.total_roundsDecrementCounter,
    required this.total_roundsincrementCounter,
    required this.onClose,
    required this.index,
    required this.durationtext,
    required this.name,
  });

  @override
  State<EditexercisesEveryRound> createState() => _EditexercisesEveryRound();
}

class _EditexercisesEveryRound extends State<EditexercisesEveryRound> {
  bool showCreateNewTimer = false;
  bool showCreatedTimer = false;
  final namecontroller = TextEditingController();
  late String name;
  int cool_down = 0;
  int total_sets = 8;
  int work_seconds = 20;
  int work_minutes = 0;
  int rest_minutes = 0;
  int rest_seconds = 10;
  int cool_down_minutes = 0;
  int cool_down_seconds = 20;
  int totaltime = 0;
  int total_hours = 0;

  List timers = [];
  List exerciseTimers = [];
  final controller = Get.put(WorkoutController());
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    final _totalRounds = widget.initialTotalRounds;
    return Column(
        mainAxisSize: MainAxisSize
            .min, // Ensure the column only takes the necessary space

        children: [
          Container(
            height: MediaQuery.of(context).size.height *
                0.13, // Set height to 20% of screen height
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Timer Settings',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  "Tap to Open Timer",
                  style: TextStyle(
                    color: Color(0xFF878894),
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.0, right: 20),
            child: TextField(
              controller: namecontroller,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Timer name',
                // hintStyle: TextStyle(color: Colors.redAccent)
                filled: true, //<-- SEE HERE
                fillColor: Color(0xff2C313F),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Color(0xffF7D15E)),
                ),

                enabled: true,
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff3D4456)),
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
              ),
            ),
            // ),
          ),
          AppSizedBoxes.largeSizedBox,
          SingleChildScrollView(
            child: Column(children: [
              Row(
                  // ROW 3
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    setCustomTimer(
                      title: 'Work',
                      time: work_seconds > 9
                          ? "0$work_minutes:$work_seconds"
                          : "0$work_minutes:0$work_seconds",
                      incrementCounter: () => workincrementCounter(),
                      decrementCounter: () => workDecrementCounter(),
                    )
                  ]),
              Row(
                  // ROW 3
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    setCustomTimer(
                      title: 'Rest',
                      time: rest_seconds > 9
                          ? "0$rest_minutes:$rest_seconds"
                          : "0$rest_minutes:0$rest_seconds",
                      incrementCounter: () => _restincrementCounter(),
                      decrementCounter: () => _restDecrementCounter(),
                    ),
                  ]),
              Row(
                  // ROW 3
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    setCustomTimer(
                      title: 'Rounds',
                      time:
                          widget.initialTotalRounds < 0 ? '0' : '$_totalRounds',
                      incrementCounter: () =>
                          widget.total_roundsincrementCounter(),
                      decrementCounter: () =>
                          widget.total_roundsDecrementCounter(),
                    ),
                  ]),
              Row(
                  // ROW 3
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    setCustomTimer(
                      title: 'Cool Down',
                      time: cool_down_seconds > 9
                          ? "0$cool_down_minutes:$cool_down_seconds"
                          : "0$cool_down_minutes:0$cool_down_seconds",
                      incrementCounter: () => cool_downincrementCounter(),
                      decrementCounter: () => cool_downDecrementCounter(),
                    ),
                  ]),
            ]),
          ),
          Container(
            width: double.infinity,
            child: Align(
              widthFactor: double.infinity,
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.all(20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffF7D15E)),
                  onPressed: () {
                    final newWorkout = Workout(
                        name: namecontroller.text,
                        sets: total_sets,
                        exersisename: [''],
                        duration: widget.durationtext,
                        round: widget.initialTotalRounds,
                        restMinutes: rest_minutes,
                        restSeconds: rest_seconds,
                        workMinutes: work_minutes,
                        workSeconds: work_seconds,
                        coolDownMinutes: cool_down_minutes,
                        coolDownSeconds: cool_down_seconds,
                        totalRounds: widget.initialTotalRounds,
                        totalSets: total_sets,
                        totalHours: total_hours,
                        totalTime: totaltime);

                    if (namecontroller.text.isEmpty) {
                      Get.snackbar('Message', 'name field is empty',
                          colorText: Colors.white);
                    } else {
                      controller.updateWorkout(widget.index, newWorkout);
                      Get.to(customWorkouts());
                    }
                  },
                  child: const Text(
                    'Save',
                    style: TextStyle(
                      color: Color(0xff242935),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ]);
  }

  void cool_downDecrementCounter() {
    setState(() {
      if (cool_down_minutes <= 0 && cool_down_seconds <= 0) {
        cool_down_minutes;
        cool_down_seconds;
      } else if (cool_down_seconds == 0) {
        cool_down_minutes--;
        cool_down_seconds = 59;
      } else {
        cool_down_seconds--;
      }
    });
  }

  void cool_downincrementCounter() {
    setState(() {
      if (cool_down_minutes == 9 && cool_down_seconds == 59) {
        cool_down_minutes = 0;
        cool_down_seconds = 0;
      } else if (cool_down_seconds == 59) {
        cool_down_minutes++;
        cool_down_seconds = 0;
      } else {
        cool_down_seconds++;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void total_setsDecrementCounter() {
    setState(() {
      total_sets--;
    });
    if (total_sets < 0) {
      setState(() {
        total_sets++;
      });
    }
  }

  void total_setsincrementCounter() {
    setState(() {
      total_sets++;
    });
  }

  void workDecrementCounter() {
    setState(() {
      if (work_minutes <= 0 && work_seconds <= 0) {
        work_minutes;
        work_seconds;
        print("minuuus");
      } else if (work_seconds == 0) {
        work_minutes--;
        work_seconds = 59;
      } else {
        work_seconds--;
      }
    });
  }

  void workincrementCounter() {
    setState(() {
      if (work_minutes == 9 && work_seconds == 59) {
        work_minutes = 0;
        work_seconds = 0;
      } else if (work_seconds == 59) {
        work_minutes++;
        work_seconds = 0;
      } else {
        work_seconds++;
      }
    });
  }

  void _restDecrementCounter() {
    setState(() {
      if (rest_minutes <= 0 && rest_seconds <= 0) {
        rest_minutes;
        rest_seconds;
      } else if (rest_seconds == 0) {
        rest_minutes--;
        rest_seconds = 59;
      } else {
        rest_seconds--;
      }
    });
  }

  void _restincrementCounter() {
    setState(() {
      if (rest_minutes == 9 && rest_seconds == 59) {
        rest_minutes = 0;
        rest_seconds = 0;
      } else if (rest_seconds == 59) {
        rest_minutes++;
        rest_seconds = 0;
      } else {
        rest_seconds++;
      }
    });
  }
}
