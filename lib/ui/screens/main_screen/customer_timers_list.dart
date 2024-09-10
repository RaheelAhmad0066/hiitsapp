import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hiits/ui/models/timer_model.dart';
import 'package:hiits/ui/storage/storage.dart';
import 'package:hiits/ui/widgets/buttons/bottom_button.dart';
import 'package:hiits/ui/widgets/modals/bottom_modal.dart';
import 'package:audio_session/audio_session.dart';

// Audio Player
import 'package:just_audio/just_audio.dart';

import 'create_new_timer.dart';
import 'edit_custom_timer.dart';

class customTimersList extends StatefulWidget {
  final Function _loadTimers;

  const customTimersList(this._loadTimers);

  @override
  _customTimersList createState() => _customTimersList();
}

class _customTimersList extends State<customTimersList>
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
    return Scaffold(
        body: Column(children: <Widget>[
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
        Container(
            padding: EdgeInsets.only(
              left: 14.w,
            ),
            child: Text(
              "Custom timers",
              style: TextStyle(
                fontSize: 27.sp,
                fontWeight: FontWeight.w800,
              ),
            )),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => createNewTimer(widget._loadTimers),
              ),
            );
          },
          child: Row(children: [
            Text(
              "New",
              style: TextStyle(
                color: Color(0xffF7D15E),
                fontWeight: FontWeight.w700,
                fontSize: 19.sp,
              ),
            ),
            Image.asset(
              'assets/icons/new.png',
              width: 30,
              height: 100,
            ),
          ]),
        ),
      ]),
      Container(
          height: MediaQuery.of(context).size.height.h / 1.8,
          child: showAddedTimer && timers.length > 0
              ? ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8.0),
                  itemCount: timers.length,
                  itemBuilder: (context, index) {
                    return Container(
                        margin: const EdgeInsets.only(top: 5),
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 20, bottom: 20),
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
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                                  Color(0xFFF6D162),
                                                  Color(0xFFFF6F6F),
                                                ],
                                              ),
                                              border: Border.all(
                                                  color: Colors.transparent,
                                                  width: 1),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Text(timers[index].name,
                                            style: TextStyle(
                                                color: Color(0xffffffff),
                                                fontWeight: FontWeight.w800,
                                                fontSize: 23.sp)),
                                      ),
                                    ],
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet<void>(
                                        backgroundColor: Colors.transparent,
                                        context: context,
                                        builder: (BuildContext context) {
                                          return bottomModal(
                                              Text: timers[index].name,
                                              buttonOneText: "Edit",
                                              buttonTwoText: "Delete",
                                              buttonOneColor: Color(0xff363D4D),
                                              buttonTwoColor: Color(0xffE14040),
                                              buttonTextColor:
                                                  Color(0xffffffff),
                                              onPressedButtonOne: () {
                                                print(timers[index]
                                                    .cool_down_seconds);
                                                Navigator.pop(context);
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => editTimer(
                                                        index,
                                                        timers[index].name,
                                                        timers[index]
                                                            .total_rounds,
                                                        timers[index]
                                                            .total_sets,
                                                        timers[index]
                                                            .cool_down_minutes,
                                                        timers[index]
                                                            .cool_down_seconds,
                                                        timers[index]
                                                            .rest_minutes,
                                                        timers[index]
                                                            .rest_seconds,
                                                        timers[index]
                                                            .work_minutes,
                                                        timers[index]
                                                            .work_seconds,
                                                        timers[index]
                                                            .total_hours,
                                                        timers[index]
                                                            .totaltime),
                                                  ),
                                                ).then(
                                                    (refresh) => _loadTimers());
                                              },
                                              onPressedButtonTwo: () {
                                                _deleteTimer(index);
                                                Navigator.pop(context);
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
                                        height: 30,
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            await _storage
                                                .saveStartTimer(timers[index]);

                                            Navigator.pushReplacementNamed(
                                                context, '/count_down',
                                                arguments: timers[index]);
                                            playAudio();
                                          },
                                          child: Text(
                                            'Start',
                                            style: TextStyle(
                                              color: Color(0xff242935),
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  (Color(0xffF7D15E)),
                                              shape: StadiumBorder()),
                                        )),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 30),
                                          child: Text(
                                            " Sets (${timers[index].total_sets})",
                                            style: TextStyle(
                                              color: Color(0xff878894),
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 30),
                                          child: Text(
                                            "Rounds (${timers[index].total_rounds})",
                                            style: TextStyle(
                                              color: Color(0xff878894),
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 30),
                                          child: Text(
                                            '${timers[index].totaltime ~/ 60}:${timers[index].totaltime % 60}',
                                            style: TextStyle(
                                              color: Color(0xff878894),
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ));
                  })
              : null),
      Row(
        children: <Widget>[
          Container(
            child: bottomButton(
                Text: "Create New Timer",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => createNewTimer(_loadTimers),
                    ),
                  );
                }),
          )
        ],
      ),
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
