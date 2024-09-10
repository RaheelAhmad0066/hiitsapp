import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiits/appassets/apsizedbox.dart';
import 'package:hiits/ui/screens/workout/create_custom_workout/controllerworkout/controllerworkout.dart';
import 'package:hiits/ui/screens/workout/custom_workouts/custom_workouts.dart';
import 'package:hiits/ui/widgets/timer_widgets/set_time_section.dart';

class exercisesEveryRound extends StatefulWidget {
  final int initialTotalRounds;
  final List<String> exercisename;
  final VoidCallback total_roundsincrementCounter;
  final VoidCallback total_roundsDecrementCounter;
  final VoidCallback onClose;
  final String name;
  exercisesEveryRound({
    required this.initialTotalRounds,
    required this.exercisename,
    required this.total_roundsDecrementCounter,
    required this.total_roundsincrementCounter,
    required this.onClose,
    required this.name,
  });

  @override
  State<exercisesEveryRound> createState() => _exercisesEveryRound();
}

class _exercisesEveryRound extends State<exercisesEveryRound> {
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
  @override
  void initState() {
    // TODO: implement initState
    calculateTotalDuration();
    super.initState();
  }

  final controller = Get.put(WorkoutController());
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
                hintStyle: TextStyle(color: Colors.grey),
                filled: true, //<-- SEE HERE
                fillColor: Color(0xff2C313F),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Color(0xffF7D15E)),
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                enabled: true,
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff3D4456)),
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
              ),
            ),
            // ),
          ),
          AppSizedBoxes.normalSizedBox,
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
                        exersisename: widget.exercisename,
                        duration: durationText,
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
                      controller.addWorkout(newWorkout);
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
