import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hiits/navigation/bottom_tab.dart';
import 'package:hiits/ui/widgets/buttons/bottom_button.dart';
import 'package:hiits/ui/widgets/workout_widgets/wout_complete_widget.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../../models/timer_model.dart';

class WorkoutCompleteScreen extends StatefulWidget {
  final int? total_rounds;
  final int? total_sets;
  final String? timer;
  const WorkoutCompleteScreen({
    super.key,
    this.total_sets,
    this.total_rounds,
    this.timer,
  });
  _WorkoutCompleteScreen createState() => _WorkoutCompleteScreen();
}

class _WorkoutCompleteScreen extends State<WorkoutCompleteScreen>
    with TickerProviderStateMixin {
  bool showCreateNewTimer = false;

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

  late ConfettiController _controllerTopCenter;

  @override
  Widget build(BuildContext context) {
    print(widget.total_rounds);

    return Scaffold(
        body: Stack(children: [
      Container(
          width: double.infinity, // or other appropriate constraints

          child: Column(children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(
                      top: 100, left: 20, right: 20, bottom: 10),
                  child: Center(
                      child: Image.asset(
                    'assets/icons/workout_complete.png',
                    // width: 50,'
                    height: 150.h,
                  )),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [heading()],
            ),
            Row(
                //ROW 2
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  WorkoutCompleteWidget(
                    MaincontainerWidth: 146.83.w,
                    MaincontainerHeight: 147.h,
                    WorkRestContainerHeight: 73.h,
                    WorkRestContainerWidth: 146.w,
                    titleFontSize: 20.sp,
                    title: 'Total Sets',
                    number: '${widget.total_sets}',
                    isGradient: true,
                    boxColor: Color(0xFF2C313F),
                  ),
                  WorkoutCompleteWidget(
                    MaincontainerWidth: 146.83.w,
                    MaincontainerHeight: 147.h,
                    WorkRestContainerHeight: 73.h,
                    WorkRestContainerWidth: 146.w,
                    titleFontSize: 20.sp,
                    title: 'Rounds',
                    number: '${widget.total_rounds}',
                    isGradient: true,
                    boxColor: Color(0xFF2C313F),
                  ),
                ]),
            Row(
                //ROW 2

                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  WorkoutCompleteWidget(
                    MaincontainerWidth: 146.83.w,
                    MaincontainerHeight: 147.h,
                    WorkRestContainerHeight: 73.h,
                    WorkRestContainerWidth: 146.w,
                    titleFontSize: 15.sp,
                    title: 'Total time',
                    // number: '08:00',
                    // '${timeRemaining! ~/ 60}:${timeRemaining! % 60}',

                    // number: '${timer}',
                    number: '${widget.timer}',
                    isGradient: false,
                    boxColor: Color(0xFF242935),
                  ),
                ]),
            bottomButton(
              Text: "Done",
              onPressed: () {
                // Navigator.pushNamedAndRemoveUntil(
                //     context, '/BottomTab', (route) => false);
                Get.offAll(BottomTab());
              },
            )
          ])),
      Positioned(
          top: 0,
          width: 400, // or other appropriate constraints
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                  child: ConfettiWidget(
                confettiController: _controllerTopCenter,
                blastDirection: pi / 5,
                maxBlastForce: 5, // set a lower max blast force
                minBlastForce: 2, // set a lower min blast force
                emissionFrequency: 0.05,
                numberOfParticles: 10, // a lot of particles at once
                gravity: 0.5,
                colors: const [
                  Colors.green,
                  Colors.blue,
                  Colors.pink,
                  Colors.orange,
                  Colors.purple
                ], // manually specify the colors to be used
                createParticlePath: drawStar, // define a custom shape/path.
              )),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                  child: ConfettiWidget(
                confettiController: _controllerTopCenter,
                blastDirection: pi,
                maxBlastForce: 5, // set a lower max blast force
                minBlastForce: 2, // set a lower min blast force
                emissionFrequency: 0.05,
                numberOfParticles: 10, // a lot of particles at once
                gravity: 1,
                colors: const [
                  Colors.green,
                  Colors.blue,
                  Colors.pink,
                  Colors.orange,
                  Colors.purple
                ], // manually specify the colors to be used
                // createParticlePath: drawStar, // define a custom shape/path.
              )),
            )
          ])),
    ]));
  }

  @override
  void dispose() {
    _controllerTopCenter.dispose();
    super.dispose();
  }

  /// A custom Path to paint stars.
  Path drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }

  Widget heading() {
    return GradientText(
      'Workout Complete!',
      style: TextStyle(fontSize: 32.0.sp),
      colors: const [
        Color(0xFFF6D162),
        Color(0xFFFF6F6F),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    _controllerTopCenter =
        ConfettiController(duration: const Duration(seconds: 2));

    _controllerTopCenter.play();
  }
}
