import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import './custom_timers.dart';
import '../../models/timer_model.dart';
import '../../storage/storage.dart';
import '../../widgets/buttons/bottom_button.dart';
import '../../widgets/buttons/inactive_button.dart';
import '../../widgets/timer_widgets/set_time_section.dart';

class createNewTimer extends StatefulWidget {
  final Function _loadTimers;

  const createNewTimer(this._loadTimers);
  _createNewTimer createState() => _createNewTimer();
}

class _createNewTimer extends State<createNewTimer> {
  bool showCreateNewTimer = false;
  bool showCreatedTimer = false;

  TextEditingController _nameController = TextEditingController();
  final FocusNode _nameFocusNode = FocusNode(); // Create a FocusNode

  late String name;
  bool _inputHasValue = false;
  int cool_down = 0;
  int total_sets = 8;
  int total_rounds = 8;
  int work_seconds = 20;
  int work_minutes = 0;
  int rest_minutes = 0;
  int rest_seconds = 10;
  int cool_down_minutes = 0;
  int cool_down_seconds = 60;
  int totaltime = 0;
  int total_hours = 0;

  List timers = [];
  List exerciseTimers = [];

  final TodoStorage _storage = TodoStorage();

  @override
  Widget build(BuildContext context) {
    int totalHours = 0;

    int _total = 0;
    if (_total == 59) {
      _total = 0;
      totalHours++;
    } else if (_total == 0) {
      _total = (((work_seconds + (work_minutes * 60)) * total_sets) +
              ((rest_seconds + (rest_minutes * 60)) * (total_sets - 1)) +
              (cool_down_seconds + (cool_down_minutes * 60))) *
          (total_rounds - 1);
    }

    setState(() {
      totaltime = _total;
      total_hours = totalHours;
    });

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: SingleChildScrollView(
                  child: Container(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(top: 20),
                          child: Image.asset(
                            'assets/icons/crose.png',
                            height: 60,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20.0, right: 20),
                      child: TextField(
                        focusNode: _nameFocusNode,
                        controller: _nameController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Timer name',
                          // hintStyle: TextStyle(color: Colors.redAccent)
                          filled: true, //<-- SEE HERE
                          fillColor: Color(0xff2C313F),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Color(0xffF7D15E)),
                          ),

                          enabled: true,
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xff3D4456)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                        ),
                      ),
                      // ),
                    ),
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
                            title: 'Cool Down',
                            time: cool_down_seconds > 9
                                ? "0$cool_down_minutes:$cool_down_seconds"
                                : "0$cool_down_minutes:0$cool_down_seconds",
                            incrementCounter: () => cool_downincrementCounter(),
                            decrementCounter: () => cool_downDecrementCounter(),
                          ),
                        ]),
                    // // Row(
                    Row(
                        // ROW 3
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          setCustomTimer(
                            title: 'Sets',
                            time: total_sets < 0 ? '0' : '$total_sets',
                            incrementCounter: () =>
                                total_setsincrementCounter(),
                            decrementCounter: () =>
                                total_setsDecrementCounter(),
                          ),
                        ]),

                    Row(
                        // ROW 3
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          setCustomTimer(
                            title: 'Rounds',
                            time: total_rounds < 0 ? '0' : '$total_rounds',
                            incrementCounter: () =>
                                total_roundsincrementCounter(),
                            decrementCounter: () =>
                                total_roundsDecrementCounter(),
                          ),
                        ]),

                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                              padding:
                                  EdgeInsets.only(left: 14.w, bottom: 10.w),
                              child: Text(
                                "Total Time",
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              )),
                          Padding(
                              padding:
                                  EdgeInsets.only(right: 14.w, bottom: 10.w),
                              child: Text(
                                '${totaltime ~/ 60}:${totaltime % 60}',
                                style: TextStyle(
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              )),
                        ]),

                    if (!_nameFocusNode.hasFocus)
                      Row(
                        children: <Widget>[
                          Container(
                            child: _nameController.text.isNotEmpty
                                ? bottomButton(
                                    Text: "Save Timer",
                                    onPressed: _nameController.text.isNotEmpty
                                        ? () {
                                            String name = _nameController.text;

                                            _addTodo(TimerModel(
                                                rest_minutes: rest_minutes > 9
                                                    ? int.parse(
                                                        '${rest_minutes}')
                                                    : int.parse(
                                                        '0${rest_minutes}'),
                                                rest_seconds: rest_seconds > 9
                                                    ? rest_seconds
                                                    : int.parse(
                                                        '0${rest_seconds}'),
                                                cool_down_minutes:
                                                    cool_down_minutes > 9
                                                        ? cool_down_minutes
                                                        : int.parse(
                                                            '0${cool_down_minutes}'),
                                                cool_down_seconds:
                                                    cool_down_seconds > 9
                                                        ? cool_down_seconds
                                                        : int.parse(
                                                            '0${cool_down_seconds}'),
                                                work_minutes: work_minutes > 9
                                                    ? work_minutes
                                                    : int.parse(
                                                        '0${work_minutes}'),
                                                work_seconds: work_seconds > 9
                                                    ? work_seconds
                                                    : int.parse(
                                                        '0${work_seconds}'),
                                                name: name,
                                                total_rounds: total_rounds,
                                                total_sets: total_sets,
                                                totaltime: totaltime,
                                                total_hours: totalHours));
                                            widget._loadTimers();
                                            Navigator.pop(context);
                                          }
                                        : () => null,
                                  )
                                : inactiveButton(
                                    Text: 'Edit Timer',
                                  ),
                          ),
                        ],
                      ),
                  ]))
                  // }
                  )),
        ));
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

  @override
  void initState() {
    super.initState();
    _loadTodos();
    _nameController.addListener(_onInputChanged);
  }

  void total_roundsDecrementCounter() {
    setState(() {
      total_rounds--;
    });
    if (total_rounds < 0) {
      setState(() {
        total_rounds++;
      });
    }
  }

  void total_roundsincrementCounter() {
    setState(() {
      total_rounds++;
    });
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

  void _addTodo(timer) {
    setState(() {
      exerciseTimers.add(timer);
    });
    _saveExerciseTimer();
  }

  Future<void> _loadTodos() async {
    final todos = await _storage.getTimers();
    setState(() {
      exerciseTimers = todos;
    });
  }

  void _onInputChanged() {
    setState(() {
      _inputHasValue = _nameController.text.isNotEmpty;
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

  Future<void> _saveExerciseTimer() async {
    await _storage.saveExerciseTimer(exerciseTimers);
  }
}
