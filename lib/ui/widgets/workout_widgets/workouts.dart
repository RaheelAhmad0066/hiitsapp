import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class Workouts extends StatefulWidget {
  final String title;
  final int sets;
  final int rounds;
  final int hours;
  final int minutes;
  final String image;

  const Workouts(
      {required this.title,
      required this.sets,
      required this.rounds,
      required this.hours,
      required this.minutes,
      required this.image});

  @override
  _Workouts createState() => _Workouts();
}

class _Workouts extends State<Workouts> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
              margin: const EdgeInsets.only(top: 5),
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 10, bottom: 10),
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
                    Row(children: [
                      Image.asset(
                        widget.image,
                        height: 80,
                        width: 80,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(widget.title,
                                      style: TextStyle(
                                          color: Color(0xffffffff),
                                          fontWeight: FontWeight.w800,
                                          fontSize: 23.sp)),
                                ),
                              ]),
                          Padding(
                              padding: EdgeInsets.only(
                                top: 14.w,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Text(
                                      // " Sets",
                                      '${widget.sets} Sets',

                                      style: TextStyle(
                                        color: Color(0xff878894),
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 30),
                                    child: Text(
                                      "${widget.rounds} Rounds",
                                      style: TextStyle(
                                        color: Color(0xff878894),
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 30),
                                    child: Text(
                                      '${widget.hours}:${widget.minutes}',
                                      style: TextStyle(
                                        color: Color(0xff878894),
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        ],
                      )
                    ]),
                  ],
                ),

                // ]
              ))
        ],
      ),
    );
  }
}
