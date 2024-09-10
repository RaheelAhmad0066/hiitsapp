import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../../models/timer_model.dart';
// import 'package:wakelock/wakelock.dart';
import '../../storage/storage.dart';
import '../../widgets/playbar/playbar_widget.dart';
// import '../widgets/time_section.dart';
import '../../widgets/timer_widgets/time_section.dart';
import 'package:just_audio/just_audio.dart';

import 'package:audio_session/audio_session.dart';
import 'package:flutter/services.dart';

// import ""
class TabataTimerScreen extends StatefulWidget {
  final Function nextPage;

  const TabataTimerScreen(this.nextPage);
  _TabataTimerScreen createState() => _TabataTimerScreen();
}

class _TabataTimerScreen extends State<TabataTimerScreen>
    with TickerProviderStateMixin {
  bool showCreateNewTimer = false;
  bool timerNotNull = false;

  final TodoStorage _storage = TodoStorage();

  TimerModel timer = TimerModel(
    rest_minutes: 0,
    rest_seconds: 0,
    cool_down_minutes: 0,
    cool_down_seconds: 0,
    work_minutes: 0,
    work_seconds: 0,
    total_rounds: 0,
    total_sets: 0,
    totaltime: 0,
    total_hours: 0,
    name: "",
  );

  final audioPlayer = AudioPlayer(handleAudioSessionActivation: false);

  ConcatenatingAudioSource? audioSource;

  late AudioPlayer beepSoundPlayer;
  double originalVolume = 1.0; // Store the original volume level here

  @override
  void initState() {
    super.initState();
    initializePlayers();
    loadTimer();
  }

  @override
  void dispose() {
    // beepSoundPlayer.dispose();
    super.dispose();
  }

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

    await beepSoundPlayer.setAsset('assets/audio/work.mp4');
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
  }

  void _handleStart() async {
    if (timerNotNull) {
      playAudio();
      Navigator.pushReplacementNamed(context, '/count_down', arguments: timer);
    } else {
      print('Hi there');
      widget.nextPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Container(
            height: screenHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                showCreateNewTimer == true
                    ? Column(
                        children: [
                          Image.asset(
                            "assets/icons/end_icon.png",
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [heading()],
                      ),
                Column(
                  children: [
                    Row(

                        //ROW 2
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TimeSectionWidget(
                            MaincontainerWidth: 100.83.w,
                            MaincontainerHeight: screenHeight * 0.10,
                            WorkRestContainerHeight: screenHeight * 0.05,
                            WorkRestContainerWidth: 100.w,
                            title: 'Work',
                            time: '${timer.work_minutes}:${timer.work_seconds}',
                          ),
                          TimeSectionWidget(
                            MaincontainerWidth: 96.53.w,
                            WorkRestContainerWidth: 96.w,
                            MaincontainerHeight: screenHeight * 0.10,
                            WorkRestContainerHeight: screenHeight * 0.05,
                            title: 'Rest',
                            time: '${timer.rest_minutes}:${timer.rest_seconds}',
                          ),
                          TimeSectionWidget(
                              MaincontainerWidth: 131.68.w,
                              MaincontainerHeight: screenHeight * 0.10,
                              WorkRestContainerHeight: screenHeight * 0.05,
                              WorkRestContainerWidth: 131.w,
                              title: 'Cool Down',
                              time:
                                  '${timer.cool_down_minutes}:${timer.cool_down_seconds}')
                        ]),
                    Row(
                        // ROW 3
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TimeSectionWidget(
                              MaincontainerWidth: 173.91.w,
                              MaincontainerHeight: screenHeight * 0.10,
                              WorkRestContainerHeight: screenHeight * 0.05,
                              WorkRestContainerWidth: 173.91.w,
                              title: 'Sets',
                              time: '${timer.total_sets}'),
                          TimeSectionWidget(
                              MaincontainerWidth: 173.91.w,
                              MaincontainerHeight: screenHeight * 0.10,
                              WorkRestContainerHeight: screenHeight * 0.05,
                              WorkRestContainerWidth: 173.91.w,
                              title: 'Rounds',
                              time: '${timer.total_rounds}'),
                        ]),
                    Container(
                        margin: EdgeInsets.only(bottom: 10),
                        // margin: EdgeInsets.all(0),
                        decoration: BoxDecoration(
                            color: Color(0xFF2C313F),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0xFF252835),
                                Color(0xFF43475A),
                                Color(0xFF43475A),
                              ],
                            ),
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(12.w),
                              bottomLeft: Radius.circular(12.w),
                            )),
                        child: Container(
                          // width: 360.0.w,
                          // height: 45.43.h,
                          // height: ,
                          margin: EdgeInsets.all(0.5),
                          decoration: BoxDecoration(
                              color: Color(0xFF252835),
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(12.w),
                                bottomLeft: Radius.circular(12.w),
                              )),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 14.w, bottom: 10.w),
                                    child: Text(
                                      "Total Time",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )),
                                Padding(
                                    padding: EdgeInsets.only(
                                        right: 14.w, bottom: 10.w),
                                    child: Text(
                                      '${timer.totaltime ~/ 60}:${timer.totaltime % 60}',
                                      style: TextStyle(
                                        fontSize: 19,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    )),
                              ]),
                        )),
                  ],
                ),
                // PlayBar(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          // top: 10,
                          top: 20),
                      // padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: ElevatedButton(
                          // onPressed: _handleStart,
                          onPressed: () => _handleStart(),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF252835),
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(205))),
                          child: Ink(
                            decoration: BoxDecoration(
                                gradient: const LinearGradient(colors: [
                                  Color(0xFFF6D162),
                                  Color(0xFFFF6F6F)
                                ]),
                                borderRadius: BorderRadius.circular(10)),
                            child: Container(
                              width: (MediaQuery.of(context).size.width - 20),
                              height: screenHeight * 0.13,
                              alignment: Alignment.center,
                              child: Text(
                                'START',
                                style: TextStyle(
                                    fontSize: 32,
                                    fontStyle: FontStyle.italic,
                                    color: Color(0xFF242935)),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            )));
  }

  Widget heading() {
    return GradientText(
      'Tabata Timer',
      style: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w600,
      ),
      colors: const [
        Color(0xFFF6D162),
        Color(0xFFFF6F6F),
      ],
    );
  }

  Future<void> loadTimer() async {
    var _timer = await _storage.getSavedTimer();
    setState(() {
      timerNotNull = _timer == null ? false : true;
      timer = _timer!;
    });
  }
}
