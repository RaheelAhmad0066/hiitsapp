import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hiits/ui/models/timer_model.dart';
import 'package:hiits/ui/storage/storage.dart';
import 'package:hiits/ui/widgets/circuit_workout/custom_created_workout.dart';
import 'package:audio_session/audio_session.dart';

// Audio Player
import 'package:just_audio/just_audio.dart';

import '../create_custom_workout/circuit_workout/circuit_workout.dart';

class customWorkouts extends StatefulWidget {
  // final Function _loadTimers;

  // const customWorkouts(th);

  final List<String>? savedWorkouts;
  final String? workoutNameController;
  final VoidCallback? deleteCustomWorkout;

  const customWorkouts(
      {Key? key,
      this.workoutNameController,
      this.savedWorkouts,
      this.deleteCustomWorkout});

  @override
  _customWorkouts createState() => _customWorkouts();
}

class _customWorkouts extends State<customWorkouts>
    with TickerProviderStateMixin {
  bool showCreateNewTimer = false;
  bool showAddedTimer = true;
  late List<TimerModel> timers = [];
  late PageController _pageController;

  final TodoStorage _storage = TodoStorage();

  final audioPlayer = AudioPlayer(handleAudioSessionActivation: false);

  ConcatenatingAudioSource? audioSource;

  late AudioPlayer beepSoundPlayer;
  double originalVolume = 1.0; // Store the original volume level here

  late AudioSession session;

  Future<void> initializePlayers() async {
    beepSoundPlayer = AudioPlayer();

    session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration(
      avAudioSessionCategory: AVAudioSessionCategory.playback,
      avAudioSessionCategoryOptions: AVAudioSessionCategoryOptions.none,
      avAudioSessionMode: AVAudioSessionMode.defaultMode,
      avAudioSessionRouteSharingPolicy:
          AVAudioSessionRouteSharingPolicy.defaultPolicy,
      avAudioSessionSetActiveOptions: AVAudioSessionSetActiveOptions.none,
      androidAudioAttributes: const AndroidAudioAttributes(
        contentType: AndroidAudioContentType.music,
        flags: AndroidAudioFlags.none,
        usage: AndroidAudioUsage.media,
      ),
      androidAudioFocusGainType: AndroidAudioFocusGainType.gainTransientMayDuck,
      androidWillPauseWhenDucked: false,
    ));

    await beepSoundPlayer.setAsset('asset:///assets/audio/work.mp4');
    await beepSoundPlayer.load();
  }

  Future<void> playAudio() async {
    try {
      // Request audio focusx
      await session.setActive(true);

      // Ducking: Lower the volume during beep sound
      await beepSoundPlayer.setVolume(2.0); // Adjust the volume as needed

      // Play the beep sound
      await beepSoundPlayer.seek(Duration.zero);
      await beepSoundPlayer.play();

      // Wait for the beep sound to complete (adjust duration as needed)
      await Future.delayed(beepSoundPlayer.duration!);
    } finally {
      // Restore volume and release audio focus
      await beepSoundPlayer.setVolume(2.0); // Reset the volume
      await session.setActive(false);
    }
    await audioPlayer.seek(Duration.zero, index: 0);
    await audioPlayer.play();
  }

  // void _handleStart() async {
  //   _handlePlay();
  // }

  @override
  Widget build(BuildContext context) {
    double _screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Stack(children: <Widget>[
      Container(
          margin: EdgeInsets.only(top: _screenHeight * 0.07),
          color: Color(0xFF252835),
          // height: _screenHeight,
          child:

              //  SingleChildScrollView(
              //     child:

              Column(children: <Widget>[
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 14.w),
                    child: Text(
                      "Custom workouts",
                      style: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.w800,
                        color: Color(0xffffffff),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigator.pushNamedAndRemoveUntil(
                      //   context,
                      //   '/create_new_workout',
                      //   (route) => false,
                      // );
                      Get.to(circuitWorkout());
                    },
                    child: Container(
                      // padding: EdgeInsets.only(top: 10.w),
                      child: Row(children: [
                        Text(
                          "New",
                          style: TextStyle(
                            color: Color(0xffF7D15E),
                            fontWeight: FontWeight.w700,
                            fontSize: 19,
                          ),
                        ),
                        Image.asset(
                          'assets/icons/new.png',
                          width: 30,
                          height: 100,
                        ),
                      ]),
                    ),
                  )
                ]),
            CustomCreatedWorkout(
                workoutNameController: widget.workoutNameController,
                savedWorkouts: widget.savedWorkouts,
                deleteCustomWorkout: widget.deleteCustomWorkout),
          ]))
    ]));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    initializePlayers();
    _pageController = PageController(initialPage: 0);

    _loadTimers();
  }

  Future<void> _saveExerciseTimer() async {
    await _storage.saveExerciseTimer(timers);
  }

  void _deleteTimer(int indexToRemove) {
    timers.removeAt(indexToRemove);
    setState(() {
      // showAddedTimer = timers.isEmpty ? true : false;
      timers = timers;
    });

    _saveExerciseTimer();
  }

  Future<void> _loadTimers() async {
    var loadTmers = await _storage.getTimers();

    setState(() {
      timers = loadTmers.reversed.toList();
    });
  }
}
