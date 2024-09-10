import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hiits/ui/widgets/modals/bottom_modal.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../models/custom_workout_modal.dart';
import '../../models/timer_model.dart';
import '../../screens/tabata_timer/countdown_screen.dart';
import '../../screens/tabata_timer/track_timer_screen.dart';
import '../../screens/workout/create_custom_workout/controllerworkout/controllerworkout.dart';
import 'edit_custom_circuit.dart';

class CustomCreatedWorkout extends StatefulWidget {
  final workoutNameController;
  final List<String>? savedWorkouts;
  final deleteCustomWorkout;

  const CustomCreatedWorkout(
      {super.key,
      this.workoutNameController,
      this.savedWorkouts,
      this.deleteCustomWorkout});

  @override
  _CustomCreatedWorkout createState() => _CustomCreatedWorkout();
}

class _CustomCreatedWorkout extends State<CustomCreatedWorkout>
    with TickerProviderStateMixin {
  List<String> _workouts = [];

  @override
  void initState() {
    super.initState();
    _loadWorkouts();
  }

  Future<void> _loadWorkouts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> savedWorkouts = prefs.getStringList('workouts') ?? [];
    setState(() {
      _workouts = savedWorkouts;
    });
  }

  Future<void> _deleteWorkout(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _workouts.removeAt(index);
    });
    await prefs.setStringList('workouts', _workouts);
    print("Updated workouts: $_workouts"); // Print the updated data
  }

  final controller = Get.put(WorkoutController());

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 1.5,
      child: Obx(
        () => controller.workoutList.isNotEmpty
            ? ListView.builder(
                itemCount: controller.workoutList.length,
                itemBuilder: (context, index) {
                  final workout = controller.workoutList[index];
                  return ListTile(
                      title: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF2C313F),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 20, bottom: 20),
                    child: SingleChildScrollView(
                        child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  child: Center(
                                    child: Container(
                                      height: 20,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Color(0xFFC953F2),
                                            Color(0xFF8D55FF),
                                          ],
                                        ),
                                        border: Border.all(
                                            color: Colors.transparent,
                                            width: 1),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    // Open DraggableSheet with exerciseLibrary
                                    showModalBottomSheet(
                                      context: context,
                                      isScrollControlled:
                                          true, // Set to true to allow the bottom sheet to expand
                                      builder: (context) {
                                        return Container(
                                          height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.9 -
                                              10, // 80% of screen height
                                          // color: Colors
                                          //     .transparent, // Set a transparent background color
                                          color: Colors.transparent
                                              .withOpacity(0.7), // 50% opacity

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
                                              // child: exerciseLibrary(),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Text(workout.name,
                                        style: TextStyle(
                                            color: Color(0xffffffff),
                                            fontWeight: FontWeight.w800,
                                            fontSize: 23.sp)),
                                  ),
                                )
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet<void>(
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return bottomModal(
                                        Text:
                                            controller.workoutList[index].name,
                                        buttonOneText: "Edit",
                                        buttonTwoText: "Delete",
                                        buttonOneColor: Color(0xff363D4D),
                                        buttonTwoColor: Color(0xffE14040),
                                        buttonTextColor: Color(0xffffffff),
                                        onPressedButtonOne: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      editCircuitWorkout(
                                                        index: index,
                                                        durationtext:
                                                            workout.duration,
                                                      )));
                                        },
                                        onPressedButtonTwo: () {
                                          Navigator.pop(context);
                                          controller.deleteWorkout(index);
                                        });
                                  },
                                );
                              },
                              child: Image.asset(
                                "assets/icons/Menu.png",
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 14.w,
                          ),
                          child: Row(
                            children: [
                              Container(
                                  // height: 30,
                                  child: ElevatedButton(
                                onPressed: () {
                                  final AudioPlayerService audioPlayerService =
                                      AudioPlayerService();
                                  audioPlayerService.playSound();
                                  final timer = TimerModel(
                                      rest_minutes: workout.restMinutes,
                                      rest_seconds: workout.restSeconds,
                                      cool_down_minutes:
                                          workout.coolDownMinutes,
                                      cool_down_seconds:
                                          workout.coolDownSeconds,
                                      total_rounds: workout.totalRounds,
                                      total_hours: workout.totalHours,
                                      total_sets: workout.totalSets,
                                      totaltime: workout.totalTime,
                                      work_minutes: workout.workMinutes,
                                      work_seconds: workout.workSeconds,
                                      name: workout.name);

                                  Get.offAll(CountDownScreen(),
                                      arguments: timer);
                                },
                                child: Text(
                                  'Start',
                                  style: TextStyle(
                                      color: Color(0xff242935),
                                      fontWeight: FontWeight.w800,
                                      fontSize: 14.sp),
                                ),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: (Color(0xffF7D15E)),
                                    shape: StadiumBorder()),
                              )),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 30),
                                    child: Text(
                                      "Sets ${workout.sets}",
                                      style: TextStyle(
                                          color: Color(0xff878894),
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14.sp),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 30),
                                    child: Text(
                                      "round ${workout.round}",
                                      style: TextStyle(
                                          color: Color(0xff878894),
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14.sp),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 30),
                                    child: Text(
                                      '${workout.duration}',
                                      style: TextStyle(
                                          color: Color(0xff878894),
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14.sp),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    )),
                  ));
                },
              )
            : Center(
                child: Text(
                  "No workouts saved yet",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
              ),
      ),
    );
  }
}

class AudioPlayerService {
  // Function to play sound once from assets
  Future<void> playSound() async {
    final AudioPlayer audioPlayer = AudioPlayer();

    try {
      // Load and play the audio file from assets once
      await audioPlayer.play(AssetSource('audio/work.mp4'));
      // Automatically dispose of the player after playback completes
      audioPlayer.onPlayerComplete.listen((event) {
        audioPlayer.dispose();
      });
    } catch (e) {
      print('Error playing sound: $e');
    }
  }
}
