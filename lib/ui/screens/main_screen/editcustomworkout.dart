import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hiits/ui/models/custome_timer_modal.dart';
import 'package:hiits/ui/models/timer_model.dart';
import 'package:hiits/ui/storage/storage.dart';
import 'package:hiits/ui/widgets/timer_widgets/set_time_section.dart';

class EditCustomTime extends StatefulWidget {
  final String name;
  final int index;
  final int _rounds;
  final int _sets;
  final int totalHours;
  final int work_minutes;
  final int work_seconds;
  final int rest_minutes;
  final int rest_seconds;
  final int cool_down_minutes;
  final int cool_down_seconds;
  final int totaltime;

  const EditCustomTime(
      this.index,
      this.name,
      this._rounds,
      this._sets,
      this.cool_down_minutes,
      this.cool_down_seconds,
      this.rest_minutes,
      this.rest_seconds,
      this.work_minutes,
      this.work_seconds,
      this.totalHours,
      this.totaltime);

  @override
  _EditCustomTime createState() => _EditCustomTime();
}

class _EditCustomTime extends State<EditCustomTime> {
  final FocusNode _nameFocusNode = FocusNode();

  bool _inputHasValue = false;
  int finalRest = 0;
  int finalCooldown = 0;
  int finalSets = 0;
  int finalRounds = 0;
  int finalTotal = 0;
  int finaltotalHours = 0;
  int finalwork_seconds = 0;

  int finalwork_minutes = 0;
  int finalrest_seconds = 0;
  int finalrest_minutes = 0;
  int finalcool_down_seconds = 0;
  int finalcool_down_minutes = 0;
  int finalTotalTime = 0;
  String finalName = '';

  TextEditingController _nameController = TextEditingController();

  int _sets = 0;
  int _rounds = 0;

  final TodoStorage _storage = TodoStorage();
  List<CustomeTimerModal> exerciseTimers = [];

  Future<void> _savedCustomWorkout() async {
    await _storage.saveCustomWorkoutTime(exerciseTimers);
  }

  void _updateTimer(index, timer) {
    exerciseTimers.replaceRange(index, index + 1, [timer]);
    setState(() {
      exerciseTimers;
    });
    _savedCustomWorkout();
  }

  Future<void> _loadTodos() async {
    final todos = await _storage.getCustomer();
    setState(() {
      exerciseTimers = todos;
    });
  }

  @override
  Widget build(BuildContext context) {
    int totalHours = 0;
    int _total = 0;

    if (_total == 59) {
      _total = 0;
      totalHours++;
    } else if (_total == 0) {
      _total = (((finalwork_seconds + (finalwork_minutes * 60)) * finalSets) +
              ((finalrest_seconds + (finalrest_minutes * 60)) *
                  (finalSets - 1)) +
              (finalcool_down_seconds + (finalcool_down_minutes * 60))) *
          (finalRounds - 1);
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          margin: _nameFocusNode.hasFocus
              ? EdgeInsets.only(top: 100)
              : EdgeInsets.only(top: 0.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () {
                    // Navigator.pushReplacementNamed(context, '/');
                  },
                  child: GestureDetector(
                    onTap: () {
                      showModalBottomSheet<void>(
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            margin: EdgeInsets.all(20),
                            child: SizedBox(
                              height: 200,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color(0xff242935),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Wrap(
                                            children: [
                                              Container(
                                                  width: 250.w,
                                                  child: Text(
                                                    "Do you want to leave? You will lose the changes you made.",
                                                    maxLines: 2,
                                                    softWrap: true,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      color: Color(0xffffffff),
                                                      fontSize: 18.0.sp,
                                                    ),
                                                  ))
                                            ],
                                          ),
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: GestureDetector(
                                              child: Image.asset(
                                                "assets/icons/crose.png",
                                              ),
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        width: double.infinity,
                                        margin: const EdgeInsets.only(top: 20),
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                (Color(0xff363D4D)),
                                          ),
                                          onPressed: () {
                                            int count = 0;
                                            Navigator.of(context).popUntil(
                                              (_) => count++ >= 2,
                                            );
                                          },
                                          child: const Text(
                                            'Yes',
                                            style: TextStyle(
                                              color: Color(0xffffffff),
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                (Color(0xff363D4D)),
                                          ),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text(
                                            'No',
                                            style: TextStyle(
                                              color: Color(0xffffffff),
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
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
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  setCustomTimer(
                    title: 'Work',
                    time: finalwork_seconds > 9
                        ? "$finalwork_minutes:$finalwork_seconds"
                        : "$finalwork_minutes:0$finalwork_seconds",
                    incrementCounter: () => workincrementCounter(),
                    decrementCounter: () => workDecrementCounter(),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  setCustomTimer(
                    title: 'Rest',
                    time: finalrest_seconds > 9
                        ? "$finalrest_minutes:$finalrest_seconds"
                        : "$finalrest_minutes:0$finalrest_seconds",
                    incrementCounter: () => _restincrementCounter(),
                    decrementCounter: () => _restDecrementCounter(),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  setCustomTimer(
                    title: 'Cool Down',
                    time: finalcool_down_seconds > 9
                        ? "$finalcool_down_minutes:$finalcool_down_seconds"
                        : "$finalcool_down_minutes:0$finalcool_down_seconds",
                    incrementCounter: () => _coolDownincrementCounter(),
                    decrementCounter: () => _coolDownDecrementCounter(),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  setCustomTimer(
                    title: 'Sets',
                    time: finalSets < 0 ? '0' : '$finalSets',
                    incrementCounter: () => _setsincrementCounter(),
                    decrementCounter: () => _setsDecrementCounter(),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  setCustomTimer(
                    title: 'Rounds',
                    time: finalRounds < 0 ? '0' : '$finalRounds',
                    incrementCounter: () => _roundsincrementCounter(),
                    decrementCounter: () => _roundsDecrementCounter(),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 14.w, bottom: 10.w),
                    child: Text(
                      "Total Time",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 14.w, bottom: 10.w),
                    child: Text(
                      '${_total ~/ 60}:${_total % 60}',
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              if (!_nameFocusNode.hasFocus)
                Expanded(
                  child: Container(
                    width: double.infinity,
                    child: Align(
                      widthFactor: double.infinity,
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: double.infinity,
                        margin: const EdgeInsets.all(20),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: (_nameController.text.isNotEmpty
                                ? Color(0xffF7D15E)
                                : Color(0xffFfffff)),
                          ),
                          onPressed: _nameController.text.isNotEmpty
                              ? () {
                                  _updateTimer(
                                      widget.index,
                                      CustomeTimerModal(
                                          rest_minutes: finalrest_minutes > 9
                                              ? int.parse(
                                                  '${finalrest_minutes}')
                                              : int.parse(
                                                  '0${finalrest_minutes}'),
                                          rest_seconds: finalrest_seconds > 9
                                              ? finalrest_seconds
                                              : int.parse(
                                                  '0${finalrest_seconds}'),
                                          cool_down_minutes:
                                              finalcool_down_minutes > 9
                                                  ? finalcool_down_minutes
                                                  : int.parse(
                                                      '0${finalcool_down_minutes}'),
                                          cool_down_seconds:
                                              finalcool_down_seconds > 9
                                                  ? finalcool_down_seconds
                                                  : int.parse(
                                                      '0${finalcool_down_seconds}'),
                                          work_minutes: finalwork_minutes > 9
                                              ? finalwork_minutes
                                              : int.parse(
                                                  '0${finalwork_minutes}'),
                                          work_seconds: finalwork_seconds > 9
                                              ? finalwork_seconds
                                              : int.parse(
                                                  '0${finalwork_seconds}'),
                                          total_rounds: finalRounds,
                                          total_sets: finalSets,
                                          name: finalName,
                                          totaltime: _total,
                                          total_hours: totalHours));

                                  Navigator.pop(context);
                                }
                              : null,
                          child: const Text(
                            'Edit Timer',
                            style: TextStyle(
                              color: Color(0xff242935),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_onInputChanged);

    finalwork_seconds = widget.work_seconds;
    finalwork_minutes = widget.work_minutes;
    finalrest_minutes = widget.rest_minutes;
    finalrest_seconds = widget.rest_seconds;
    finalcool_down_minutes = widget.cool_down_minutes;
    finalcool_down_seconds = widget.cool_down_seconds;
    finaltotalHours = widget.totalHours;

    finalSets = widget._sets;
    finalRounds = widget._rounds;
    finalTotalTime = widget.totaltime;

    _nameController.value = TextEditingValue(text: "$finalName");
    _loadTodos();
  }

  void workDecrementCounter() {
    setState(() {
      finalwork_seconds--;
      if (finalwork_seconds < 0) {
        setState(() {
          finalwork_seconds++;
        });
      }
    });
  }

  void workincrementCounter() {
    setState(() {
      if (finalwork_minutes == 9 && finalwork_seconds == 59) {
        finalwork_minutes = 0;
        finalwork_seconds = 0;
      } else if (finalwork_seconds == 59) {
        finalwork_minutes++;
        finalwork_seconds = 0;
      } else {
        finalwork_seconds++;
      }
    });
  }

  void _coolDownDecrementCounter() {
    setState(() {
      finalCooldown--;
    });
    if (finalCooldown < 0) {
      setState(() {
        finalCooldown++;
      });
    }
  }

  void _coolDownincrementCounter() {
    setState(() {
      finalCooldown++;
    });
  }

  void _onInputChanged() {
    setState(() {
      _inputHasValue = _nameController.text.isNotEmpty;
    });
  }

  void _restDecrementCounter() {
    setState(() {
      if (finalrest_minutes <= 0 && finalrest_seconds <= 0) {
        finalrest_minutes;
        finalrest_seconds;
      } else if (finalrest_seconds == 0) {
        finalrest_minutes--;
        finalrest_seconds = 59;
      } else {
        finalrest_seconds--;
      }
    });
  }

  void _restincrementCounter() {
    setState(() {
      if (finalrest_minutes == 9 && finalrest_seconds == 59) {
        finalrest_minutes = 0;
        finalrest_seconds = 0;
      } else if (finalrest_seconds == 59) {
        finalrest_minutes++;
        finalrest_seconds = 0;
      } else {
        finalrest_seconds++;
      }
    });
  }

  void _roundsDecrementCounter() {
    setState(() {
      finalRounds--;
    });
    if (finalRounds < 0) {
      setState(() {
        _rounds++;
      });
    }
  }

  void _roundsincrementCounter() {
    setState(() {
      finalRounds++;
    });
  }

  void _setsDecrementCounter() {
    setState(() {
      finalSets--;
    });
    if (finalSets < 0) {
      setState(() {
        finalSets++;
      });
    }
  }

  void _setsincrementCounter() {
    setState(() {
      finalSets++;
    });
  }
}
