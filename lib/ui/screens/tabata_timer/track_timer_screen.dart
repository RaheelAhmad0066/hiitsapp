import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hiits/appassets/apsizedbox.dart';
import 'package:hiits/navigation/bottom_tab.dart';
import 'package:hiits/ui/models/timer_model.dart';
import 'package:hiits/ui/screens/tabata_timer/workout_complete_screen.dart';
import 'package:hiits/ui/widgets/others/gradient_text.dart';
import 'package:hiits/ui/widgets/others/progress_widget.dart';
import 'package:hiits/ui/widgets/playbar/playbar_widget.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_session/audio_session.dart';

import '../../widgets/modals/bottom_modal.dart';
import '../../widgets/playbar/controller/playbar_controller.dart';

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 80);
    path.quadraticBezierTo(size.width / 2, 0, size.width, 80);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class TrackTimerScreen extends StatefulWidget {
  final List<String> texts;

  TrackTimerScreen({this.texts = const ['3', '2', '1']});

  @override
  _TrackTimerScreen createState() => _TrackTimerScreen();
}

class _TrackTimerScreen extends State<TrackTimerScreen>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  late List<String> duration;
  late Timer _timer;
  late Timer _percent_timer;
  late String cooldown_duration;
  late int countdown_time = 0;
  dynamic currentRound = 1;
  bool isPlaying = false;
  int _currentIndex = 0;
  int currentActivity = -1;
  int currentSet = 1;
  int? timeRemaining = 0;
  int percent = 0;
  int? timer = 0;

  int? totalRounds = 0;
  int? totalSets = 0;
  String? totalTimer = "0";
  String activityText = "";

  TimerModel? timerObj;
  List<String> nextActivity = ["WORK", "REST", "COOL DOWN"];
  String coolDownActivity = "COOL DOWN";

  @override
  Widget build(BuildContext context) {
    timerObj = ModalRoute.of(context)?.settings.arguments as TimerModel?;
    return Scaffold(
        body: Container(
            child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                // onHorizontalDragEnd: (DragEndDetails details) {
                //   if (details.velocity.pixelsPerSecond.dx > 0.0) {
                //     Navigator.pushNamedAndRemoveUntil(
                //         context, '/BottomTab', (route) => false);
                //   }
                // },
                child: FractionallySizedBox(
                  widthFactor: 1,
                  heightFactor: 1,
                  child: Container(
                    margin: EdgeInsets.only(top: 40.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // PlayBar(),
                          AppSizedBoxes.normalSizedBox,
                          ProgressWidget(
                            text: currentActivity > -1
                                ? nextActivity[currentActivity]
                                : '',

                            // text: currentActivity > -1
                            //     ? currentSet == totalSets &&
                            //             currentActivity == 1
                            //         ? "COOL DOWN"
                            //         : nextActivity[currentActivity]
                            //     : '',

                            duration:
                                duration.length > 0 && currentActivity > -1
                                    ? int.parse(duration[currentActivity])
                                    : 0,
                            count_down:
                                countdown_time != 0 ? countdown_time : 0,
                            percent: percent,
                          ),
                          FractionallySizedBox(
                              widthFactor: 0.60,
                              child: Container(
                                // width: 200,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        showModalBottomSheet<void>(
                                          backgroundColor: Colors.transparent,
                                          context: context,
                                          builder: (BuildContext context) {
                                            return bottomModal(
                                                Text: "End workout?",
                                                buttonOneText: "Yes",
                                                buttonTwoText: "No, Continue",
                                                buttonOneColor:
                                                    Color(0xff363D4D),
                                                buttonTwoColor:
                                                    Color(0xffF7D15E),
                                                buttonTextColor:
                                                    Color(0xff242935),
                                                onPressedButtonOne: () {
                                                  Get.offAll(BottomTab());
                                                },
                                                onPressedButtonTwo: () {
                                                  Navigator.pop(context);
                                                });
                                          },
                                        );
                                      },
                                      child: Image.asset(
                                        "assets/icons/end_icon.png",
                                      ),
                                    ),
                                    Column(children: [
                                      GestureDetector(
                                        child: Container(
                                          width: 65,
                                          height: 65,
                                          child: Image.asset(!isPlaying
                                              ? "assets/icons/pause_icon.png"
                                              : "assets/icons/resume_icon.png"),
                                        ),
                                        onTap: () {
                                          if (_percent_timer.isActive) {
                                            _percent_timer.cancel();
                                            _timer.cancel();
                                            setState(() {
                                              isPlaying = !isPlaying;
                                            });
                                          } else {
                                            setState(() {
                                              isPlaying = !isPlaying;
                                            });

                                            initialize(false);
                                          }
                                        },
                                      ),
                                    ]),
                                    Column(children: [
                                      Center(
                                          child: Opacity(
                                        opacity: currentRound ==
                                                    timerObj!.total_rounds &&
                                                currentSet ==
                                                    timerObj!.total_sets &&
                                                duration.length - 1 ==
                                                    currentActivity
                                            ? 0.0
                                            : 1,
                                        child: GestureDetector(
                                          onTap: () {
                                            if (currentRound ==
                                                    timerObj!.total_rounds &&
                                                currentSet ==
                                                    timerObj!.total_sets &&
                                                duration.length - 1 ==
                                                    currentActivity) {
                                            } else {
                                              nextActivityFunc();
                                            }
                                          },
                                          child: Container(
                                            color: Colors.transparent,
                                            child: Image.asset(
                                              "assets/icons/next_play_icon.png",
                                            ),
                                          ),
                                        ),
                                      ))
                                    ]),
                                  ],
                                ),
                              )),
                          FractionallySizedBox(
                              widthFactor: 0.70,
                              child: Container(
                                margin: EdgeInsets.only(top: 20.0.sp),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                        height: 90.h,
                                        alignment: Alignment.center,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Image.asset(
                                              "assets/icons/human_icon.png",
                                            ),
                                            Text(
                                                '${currentSet}/${timerObj?.total_sets}',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.white,
                                                    fontSize: 22.sp)),
                                            Text("Set",
                                                style: TextStyle(
                                                    color: Color(0xff878894),
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 16.sp))
                                          ],
                                        )),
                                    Container(
                                        height: 90.h,
                                        alignment: Alignment.center,
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Image.asset(
                                                "assets/icons/clock_icon.png",
                                              ),
                                              Text(
                                                '${timeRemaining! ~/ 60}:${timeRemaining! % 60}',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.white,
                                                    fontSize: 22.sp),
                                              ),
                                              Text("Time Remaining",
                                                  style: TextStyle(
                                                      color: Color(0xff878894),
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 16.sp))
                                            ])),
                                    Container(
                                        height: 90.h,
                                        alignment: Alignment.center,
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Image.asset(
                                                "assets/icons/replay_icon.png",
                                              ),
                                              Text(
                                                '${currentRound}/${timerObj?.total_rounds}',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.white,
                                                    fontSize: 22.sp),
                                              ),
                                              Text("Round",
                                                  style: TextStyle(
                                                      color: Color(0xff878894),
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 16.sp))
                                            ])),
                                  ],
                                ),
                              )),
                          ClipPath(
                            clipper: MyClipper(),
                            child: Container(
                              height: 150.0.w,
                              width: double.infinity.w,
                              decoration: BoxDecoration(
                                border: Border(
                                    top: BorderSide(
                                        color: Colors.transparent,
                                        width: 1,
                                        style: BorderStyle.none)),
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xffFED96A),
                                    Color(0xffFED96A),
                                    Color(0x000000),
                                    Color(0x000000),
                                    Color(0x000000),
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  tileMode: TileMode.repeated,
                                ),
                              ),
                              child: ClipPath(
                                clipper: MyClipper(),
                                child: Container(
                                  height: 150.0.w,
                                  width: double.infinity.w,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      top: BorderSide(
                                        color: Colors.red,
                                        width: 25.w,
                                      ),
                                    ),
                                    color: Color(0xff2C313F),
                                  ),
                                  child: Container(
                                      child: Column(children: [
                                    Container(
                                        margin: EdgeInsets.only(top: 30.0.w),
                                        child: Text(
                                          "UP NEXT",
                                          style: TextStyle(
                                              color: Color(0xff878894),
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w700),
                                        )),
                                    GradientTextWidget(text: activityText)
                                  ])),
                                ),
                              ),
                            ),
                          ),
                        ]),
                  ),
                ))));
  }

  final controller = Get.put(AudioController());

  void didChangeDependencies() {
    if (mounted) {
      super.didChangeDependencies();
      timerObj = ModalRoute.of(context)?.settings.arguments as TimerModel?;

      setState(() {
        timeRemaining = timerObj?.totaltime;
        duration = [
          '${(timerObj?.work_minutes ?? 0 * 60) + (timerObj?.work_seconds ?? 0)}',
          '${(timerObj?.rest_minutes ?? 0 * 60) + (timerObj?.rest_seconds ?? 0)}',
          '${(timerObj?.cool_down_minutes ?? 0 * 60) + (timerObj?.cool_down_seconds ?? 0)}',
        ];
        cooldown_duration =
            '${(timerObj?.cool_down_minutes ?? 0 * 60) + (timerObj?.cool_down_seconds ?? 0)}';
      });
      initialize(false);
    }
  }

  @override
  void dispose() {
    _percent_timer.cancel();
    _timer.cancel();
    super.dispose();
  }

  // bool playWorkAudio = true;
  bool playRestAudio = true;
  bool playWorkAudio = true;
  bool playRoundCompleteAudio = true;
  final audioPlayer = AudioPlayer(handleAudioSessionActivation: false);

  late AudioPlayer beepSoundPlayer;
  late AudioPlayer playWork;
  late AudioPlayer playRoundComplete;

  double originalVolume = 1.0; // Store the original volume level here

  @override
  void initState() {
    super.initState();
    _handlePlayRest();
    _handlePlayWork();
    _handleRoundCompleteWork();
  }

  late AudioSession session;

  void _handlePlayRest() async {
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
    await beepSoundPlayer.setAsset('assets/audio/321_Rest.mp4');
    await beepSoundPlayer.load();
    playRestAudio = false;
  }

  Future<void> playBeepSound() async {
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
      await beepSoundPlayer.setVolume(1.0); // Reset the volume
      await session.setActive(false);
    }
  }

  void _handlePlayWork() async {
    // await audioPlayer.setAsset("assets/audio/321_Work.mp3");
    // await audioPlayer.play();
    playWork = AudioPlayer();

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
    await playWork.setAsset("assets/audio/work.mp4");
    await playWork.load();

    playWorkAudio = false;
  }

  Future<void> playWorkSound() async {
    try {
      // Request audio focusx
      await session.setActive(true);

      // Ducking: Lower the volume during beep sound
      await playWork.setVolume(1.0); // Adjust the volume as needed

      // Play the beep sound
      await playWork.seek(Duration.zero);
      await playWork.play();

      // Wait for the beep sound to complete (adjust duration as needed)
      await Future.delayed(playWork.duration!);
    } finally {
      // Restore volume and release audio focus
      await playWork.setVolume(1.0); // Reset the volume
      await session.setActive(false);
    }
  }

  void _handleRoundCompleteWork() async {
    // await audioPlayer.setAsset("assets/audio/Round_Complete.mp3");
    // await audioPlayer.play();

    playRoundComplete = AudioPlayer();

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
    await playRoundComplete.setAsset("assets/audio/Round_Complete.mp4");
    await playRoundComplete.load();

    playRoundCompleteAudio = false;
  }

  Future<void> playRoundCompleteSound() async {
    try {
      // Request audio focusx
      await session.setActive(true);

      // Ducking: Lower the volume during beep sound
      await playRoundComplete.setVolume(5.0); // Adjust the volume as needed

      // Play the beep sound
      await playRoundComplete.seek(Duration.zero);
      await playRoundComplete.play();

      // Wait for the beep sound to complete (adjust duration as needed)
      await Future.delayed(playRoundComplete.duration!);
    } finally {
      // Restore volume and release audio focus
      await playRoundComplete.setVolume(1.0); // Reset the volume
      await session.setActive(false);
    }
  }

  void initialize(isNext) {
    setState(() {
      totalSets = timerObj?.total_sets ?? 0;
      totalRounds = timerObj?.total_rounds ?? 0;
      totalTimer = '${timeRemaining! ~/ 60}:${timeRemaining! % 60}';
    });

    if (duration.isNotEmpty) {
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        if (mounted) {
          setState(() {
            timeRemaining = (timeRemaining! - 1);
          });

          if (countdown_time == 0 && duration.length == currentActivity + 1) {
            if (currentRound < (timerObj?.total_rounds ?? 0)) {
              this.nextActivityFunc();
            } else {
              print("disposed");
              _timer.cancel();
              _percent_timer.cancel();

              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) =>
              //   ),
              // );

              Get.to(
                WorkoutCompleteScreen(
                  total_rounds: totalRounds,
                  total_sets: totalSets,
                  timer: totalTimer,
                ),
              );
            }
          } else {
            if (countdown_time == 0) {
              this.nextActivityFunc();
            } else {
              setState(() {
                _currentIndex = (_currentIndex + 1) % widget.texts.length;
                countdown_time = countdown_time - 1;

                // Audios for WORK, REST, and ROUND COMPLETE

                if (playRestAudio &&
                    currentSet != totalSets &&
                    totalSets != 1 &&
                    currentActivity == 0 &&
                    countdown_time - 1 == 2) {
                  playBeepSound();
                  controller.toggleVolume();
                } else if (countdown_time - 1 > 3) {
                  playRestAudio = true;
                }

                if (playWorkAudio &&
                    currentActivity == 1 &&
                    countdown_time - 1 == 2 &&
                    totalSets != 1) {
                  print("work play");
                  playWorkSound();
                  controller.toggleVolume();
                } else if (countdown_time - 1 > 3) {
                  playWorkAudio = true;
                }

                if (playRoundCompleteAudio &&
                    currentActivity == 2 &&
                    countdown_time - 1 == 2 &&
                    !(currentSet == totalSets && currentRound == totalRounds)) {
                  playWorkSound();
                  controller.toggleVolume();
                } else if (countdown_time - 1 > 3) {
                  playRoundCompleteAudio = true;
                }

                if (playRoundCompleteAudio &&
                        currentActivity == 0 &&
                        countdown_time - 1 == 2 &&
                        currentSet == totalSets
                    // &&

                    // currentRound == totalRounds
                    ) {
                  playRoundCompleteSound();
                } else if (countdown_time - 1 > 3) {
                  playRoundCompleteAudio = true;
                }
              });
            }
          }
        }
      });

      _percent_timer = Timer.periodic(Duration(milliseconds: 332), (timer) {
        setState(() {
          percent = (percent + 1);
        });
      });
    }
  }

  void nextActivityFunc() {
    if (currentRound <= (timerObj?.total_rounds ?? 0)) {
      setState(() {
        percent = 0;

        if (currentSet < (timerObj?.total_sets ?? 0)) {
          currentSet = duration.length == currentActivity + 2
              ? currentSet + 1
              : currentSet;
          currentActivity =
              duration.length == currentActivity + 2 ? 0 : currentActivity + 1;
          countdown_time = int.parse(duration[currentActivity]);
          activityText = currentSet == totalSets && currentActivity == 0
              ? "COOL DOWN"
              : nextActivity[currentActivity + 2 < duration.length
                  ? currentActivity + 1
                  : 0];
        } else {
          if (currentSet == totalSets &&
              duration.length - 1 != currentActivity) {
            currentSet = currentSet;
            currentActivity = currentSet == totalSets
                ? totalSets == 1
                    ? (currentActivity == 0
                        ? 2
                        : 0) // Alternating between 0 (Work) and 2 (Cool Down)
                    : currentActivity + 2
                : currentActivity + 1;
            countdown_time = int.parse(duration[currentActivity]);

            activityText = currentActivity + 1 == duration.length &&
                    currentRound == totalRounds
                ? "COMPLETED"
                : totalSets == 1
                    ? currentActivity == 0
                        ? "COOL DOWN"
                        : "WORK"
                    : nextActivity[currentActivity + 1 == duration.length
                        ? 0
                        : currentActivity + 1];
          } else {
            currentRound = currentRound + 1;
            currentSet = totalSets == 1
                ? currentSet
                : 1; // Reset currentSet to 1 for each round if totalSets is 1
            currentActivity = 0;
            countdown_time = int.parse(duration[currentActivity]);
            activityText = totalSets == 1
                ? "COOL DOWN"
                : nextActivity[1]; // Default to "WORK" at the start
          }
        }

        // }
      });
    }
  }
}
