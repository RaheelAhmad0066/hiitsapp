import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateNewWorkoutWidget extends StatefulWidget {
  final int firstColor;
  final int secondColor;
  final String workoutName;
  final String description;
  final VoidCallback onTap;

  CreateNewWorkoutWidget({
    required this.firstColor,
    required this.secondColor,
    required this.workoutName,
    required this.description,
    required this.onTap,
  });
  @override
  _CreateNewWorkoutWidget createState() => _CreateNewWorkoutWidget();
}

class _CreateNewWorkoutWidget extends State<CreateNewWorkoutWidget>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: widget.onTap,
        child: Container(
          margin: const EdgeInsets.only(top: 15),
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
          decoration: BoxDecoration(
            color: Color(0xFF2C313F),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(12.w),
              topLeft: Radius.circular(12.w),
              bottomLeft: Radius.circular(12.w),
              bottomRight: Radius.circular(12.w),

              // bottomLeft: R
            ),
          ),
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    Color(widget.firstColor),
                                    Color(widget.secondColor),
                                  ],
                                ),
                                border: Border.all(
                                    color: Colors.transparent, width: 1),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10.w),
                          child: Text(widget.workoutName,
                              style: TextStyle(
                                  color: Color(0xffffffff),
                                  fontWeight: FontWeight.w800,
                                  fontSize: 23)),
                        ),
                      ],
                    ),
                    Image.asset(
                      "assets/icons/icon _forward.png",
                    ),
                  ]),
              Container(
                padding: EdgeInsets.only(top: 8, left: 13.w),
                child: Text(
                  widget.description,
                  style: TextStyle(
                    color: Color(0xff878894),
                    fontWeight: FontWeight.w700,
                    fontSize: 17,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
