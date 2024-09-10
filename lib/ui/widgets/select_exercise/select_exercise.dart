import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class selectExercise extends StatefulWidget {
  final exercise;
  final selectedExercises;
  final VoidCallback total_setsincrementCounter;
  final Function(List<String>) updateSelectedExercises;
  final Function filterExercises;
  final combinedMuscles;

  const selectExercise(
      {required this.exercise,
      required this.selectedExercises,
      required this.updateSelectedExercises, // Make sure it's included in the constructor
      required this.total_setsincrementCounter,
      required this.filterExercises,
      required this.combinedMuscles});

  @override
  selectExerciseClass createState() => selectExerciseClass();
}

class selectExerciseClass extends State<selectExercise> {
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.exercise['Exercise'],
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 17,
                ),
              ),
              // ),
              SizedBox(height: 10.0),
              SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment:
                          CrossAxisAlignment.start, // Align items at the start

                      children: [
                        ...widget.combinedMuscles.map((muscle) {
                          return Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  print("Start tapped");
                                  // Add your onTap logic here
                                },
                                child: Container(
                                  height: 25,
                                  padding: EdgeInsets.only(
                                      right: 8,
                                      left:
                                          8), // Add padding to all sides of the container
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Color(0xffF7D15E), // Border color
                                      width: 1.0, // Border width
                                    ),
                                    borderRadius: BorderRadius.circular(
                                        8.0), // Optional: for rounded corners
                                  ),
                                  child: Center(
                                    child: Text(
                                      muscle,
                                      style: TextStyle(
                                          color: Color(0xffF7D15E),
                                          fontWeight: FontWeight.w800,
                                          fontSize: 11),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 8.0),
                            ],
                          );
                        }).toList(),
                        SizedBox(width: 8.0),
                      ])),
            ],
            // ),
          )
        ]);
  }
}
