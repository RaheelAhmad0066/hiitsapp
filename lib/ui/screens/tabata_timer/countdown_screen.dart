import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../../models/timer_model.dart';
import '../workout/create_custom_workout/controllerworkout/controllerworkout.dart';
import 'track_timer_screen.dart';

class CountDownScreen extends StatefulWidget {
  final List<String> texts;

  CountDownScreen({this.texts = const ['3', '2', '1']});

  @override
  _CountDownState createState() => _CountDownState();
}

class _CountDownState extends State<CountDownScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  int _currentIndex = 0;

  late Timer _timer;
  TimerModel? timerObj;

  @override
  Widget build(BuildContext context) {
    timerObj = ModalRoute.of(context)?.settings.arguments as TimerModel?;
    return Scaffold(
      body: Center(
        child: AnimatedOpacity(
          opacity: 1,
          duration: Duration(seconds: 2),
          child: Container(
            child: GradientText(
              widget.texts[_currentIndex],
              style: TextStyle(
                  fontSize: 300.0.sp,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w700),
              colors: const [
                Color(0xFFF6D162),
                Color(0xFFFF6F6F),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void didChangeDependencies() {
    super.didChangeDependencies();
    timerObj = ModalRoute.of(context)?.settings.arguments as TimerModel?;
    runTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  void runTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timer.tick == 3) {
        timer.cancel();

        Get.to(TrackTimerScreen(), arguments: timerObj);
      } else {
        setState(() {
          _currentIndex = timer.tick;
        });
      }
    });
  }
}

class CountDownCustomworkoutScreen extends StatefulWidget {
  final List<String> texts;

  CountDownCustomworkoutScreen({this.texts = const ['3', '2', '1']});

  @override
  _CountDownCustomworkoutScreenState createState() =>
      _CountDownCustomworkoutScreenState();
}

class _CountDownCustomworkoutScreenState
    extends State<CountDownCustomworkoutScreen> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  int _currentIndex = 0;

  late Timer _timer;
  Workout? timerObj;

  @override
  Widget build(BuildContext context) {
    timerObj = ModalRoute.of(context)?.settings.arguments as Workout?;
    return Scaffold(
      body: Center(
        child: AnimatedOpacity(
          opacity: 1,
          duration: Duration(seconds: 2),
          child: Container(
            child: GradientText(
              widget.texts[_currentIndex],
              style: TextStyle(
                  fontSize: 300.0.sp,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w700),
              colors: const [
                Color(0xFFF6D162),
                Color(0xFFFF6F6F),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void didChangeDependencies() {
    super.didChangeDependencies();
    timerObj = ModalRoute.of(context)?.settings.arguments as Workout?;
    runTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  void runTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timer.tick == 3) {
        timer.cancel();
        Navigator.pushReplacementNamed(context, '/track_timer',
            arguments: timerObj);
      } else {
        setState(() {
          _currentIndex = timer.tick;
        });
      }
    });
  }
}
