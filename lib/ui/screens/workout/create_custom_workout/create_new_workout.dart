import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hiits/navigation/bottom_tab.dart';
import '../../../widgets/workout_widgets/create_new_workout_widget.dart';
import "./circuit_workout/circuit_workout.dart";

class CreateNewWorkout extends StatefulWidget {
  @override
  _CreateNewWorkout createState() => _CreateNewWorkout();
}

class _CreateNewWorkout extends State<CreateNewWorkout>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    // Calculate font size based on screen width
    // double fontSize = screenWidth *
    //     0.02; // You can adjust this factor according to your preference

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF252835),
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BottomTab(
                              initialIndex: 1,
                            )));
                print("CLICKKWRDD!!");
              },
              icon: Image.asset(
                'assets/icons/goBack.png',
                height: 24, // Adjust height as needed
              )),
          title: Center(
              child: Image.asset(
            "assets/icons/hiits_workout_logo.png",
          )),
        ),
        body: Stack(children: <Widget>[
          Container(
              color: Color(0xFF252835),
              child: Column(children: [
                Container(
                  padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 39),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Create new workout",
                        style: TextStyle(
                            // fontSize: 30.sp,
                            fontSize: 17, // Set the font style to normal
                            fontWeight: FontWeight.w800,
                            fontFamily: 'Hind',
                            color: Color(0xffffffff)),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 7),
                        child: Text(
                          "Select the type of workout you want to create",
                          style: TextStyle(
                              color: Color(0xff878894),
                              fontWeight: FontWeight.w700,
                              // fontSize: 20.sp,
                              fontSize: 17 // Set the font style to normal
                              ),
                        ),
                      ),
                      CreateNewWorkoutWidget(
                        firstColor: 0xFFC953F2,
                        secondColor: 0xFF8D55FF,
                        workoutName: "Circuit",
                        description:
                            "A timed workout session with a set of exercises.",
                        onTap: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => circuitWorkout(),
                              ))
                        },
                      ),
                    ],
                  ),
                ),
              ]))
        ]));
  }
}
