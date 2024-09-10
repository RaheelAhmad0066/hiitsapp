import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'set_time_section.dart';

class createTimer extends StatefulWidget {
  final int work_hours;
  final int work_minutes;
  final int rest_hours;
  final int rest_minutes;
  final int cool_down_minutes;
  final int cool_down_Hours;
  final int total_rounds;
  final int total_sets;
  final VoidCallback total_roundsDecrementCounter;
  final VoidCallback total_roundsincrementCounter;
  final VoidCallback total_setsDecrementCounter;
  final VoidCallback total_setsincrementCounter;
  final VoidCallback workDecrementCounter;
  final VoidCallback workincrementCounter;
  final VoidCallback restDecrementCounter;
  final VoidCallback restincrementCounter;
  final VoidCallback cool_downDecrementCounter;
  final VoidCallback cool_downincrementCounter;
  final int totaltime;

  const createTimer(
      {super.key,
      required this.rest_hours,
      required this.rest_minutes,
      required this.work_hours,
      required this.work_minutes,
      required this.cool_down_Hours,
      required this.cool_down_minutes,
      required this.total_rounds,
      required this.total_sets,
      required this.total_roundsDecrementCounter,
      required this.total_roundsincrementCounter,
      required this.total_setsDecrementCounter,
      required this.total_setsincrementCounter,
      required this.workDecrementCounter,
      required this.workincrementCounter,
      required this.cool_downDecrementCounter,
      required this.cool_downincrementCounter,
      required this.restDecrementCounter,
      required this.restincrementCounter,
      required this.totaltime});
  _createTimer createState() => _createTimer();
}

class _createTimer extends State<createTimer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          setCustomTimer(
            title: 'Work',
            time: widget.work_minutes > 9
                ? "0${widget.work_hours}:${widget.work_minutes}"
                : "0${widget.work_hours}:0${widget.work_minutes}",
            incrementCounter: () => widget.workincrementCounter(),
            decrementCounter: () => widget.workDecrementCounter(),
          )
        ]),
        Row(
            // ROW 3
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              setCustomTimer(
                title: 'Rest',
                time: widget.rest_minutes > 9
                    ? "0${widget.rest_hours}:${widget.rest_minutes}"
                    : "0${widget.rest_hours}:0${widget.rest_minutes}",
                incrementCounter: () => widget.restincrementCounter(),
                decrementCounter: () => widget.restDecrementCounter(),
              ),
            ]),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          setCustomTimer(
            title: 'Cool Down',
            time: widget.cool_down_minutes > 9
                ? "0${widget.cool_down_Hours}:${widget.cool_down_minutes}"
                : "0${widget.cool_down_Hours}:0${widget.cool_down_minutes}",
            incrementCounter: () => widget.cool_downincrementCounter(),
            decrementCounter: () => widget.cool_downDecrementCounter(),
          ),
        ]),
        // Row(
        Row(
            // ROW 3
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              setCustomTimer(
                title: 'Sets',
                time: widget.total_sets < 0 ? '0' : '${widget.total_sets}',
                incrementCounter: () => widget.total_setsincrementCounter(),
                decrementCounter: () => widget.total_setsDecrementCounter(),
              ),
            ]),

        Row(
            // ROW 3
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              setCustomTimer(
                title: 'Rounds',
                time: widget.total_rounds < 0 ? '0' : '${widget.total_rounds}',
                incrementCounter: () => widget.total_roundsincrementCounter(),
                decrementCounter: () => widget.total_roundsDecrementCounter,
              ),
            ]),

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
                  )),
              Padding(
                  padding: EdgeInsets.only(right: 14.w, bottom: 10.w),
                  child: Text(
                    widget.totaltime.toString(),
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  )),
            ]),
      ],
    );
  }
}
