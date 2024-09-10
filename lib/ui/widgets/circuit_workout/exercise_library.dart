import 'package:flutter/material.dart';
import 'package:hiits/appassets/apsizedbox.dart';
import 'package:hiits/ui/widgets/circuit_workout/create_new_exercise.dart';

import 'detabase/prefutils.dart';

class ExerciseLibrary extends StatefulWidget {
  final exercises;
  final selectedExercises;
  final VoidCallback totalSetsIncrementCounter;
  final Function(List<String>) updateSelectedExercises;
  const ExerciseLibrary({
    required this.exercises,
    required this.selectedExercises,
    required this.updateSelectedExercises,
    required this.totalSetsIncrementCounter,
  });

  @override
  State<ExerciseLibrary> createState() => _ExerciseLibraryState();
}

class _ExerciseLibraryState extends State<ExerciseLibrary> {
  List<Map<String, dynamic>> exercises = [];
  List<Map<String, dynamic>> filteredExercises = [];
  List<Map<String, dynamic>> selectedExercises = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchExercises();
  }

  void fetchExercises() async {
    exercises = await PrefUtils.getSelectedExercises();
    setState(() {
      filteredExercises = exercises;
    });
  }

  void filterExercises(String query) {
    setState(() {
      filteredExercises = exercises
          .where((exercise) =>
              exercise['name'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void toggleSelection(Map<String, dynamic> exercise) {
    setState(() {
      if (selectedExercises.contains(exercise)) {
        selectedExercises.remove(exercise);
      } else {
        selectedExercises.add(exercise);
      }
      // Update parent with the list of selected exercise names
      widget.updateSelectedExercises(
          selectedExercises.map((e) => e['name'] as String).toList());
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Stack(
        children: [
          Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            child: Center(
              child: Container(
                margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.4 - 8),
                width: 20.0,
                height: 4.0,
                decoration: BoxDecoration(
                  color: Color(0xffffffff).withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.10,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Exercise Library',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    builder: (context) {
                                      return Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                    0.9 -
                                                10,
                                        color:
                                            Colors.transparent.withOpacity(0.6),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(30.0),
                                            topRight: Radius.circular(30.0),
                                          ),
                                          child: Container(
                                            color: Color(0xFF2C313F),
                                            child: CreateNewExercise(),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Text(
                                  "Create New",
                                  style: TextStyle(
                                    color: Color(0xFFF7D15E),
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                _buildNameInputField(),
                AppSizedBoxes.normalSizedBox,
                ListView.builder(
                  itemCount: filteredExercises.length,
                  shrinkWrap: true,
                  controller: ScrollController(),
                  itemBuilder: (context, index) {
                    final exercise = filteredExercises[index];
                    final isSelected = selectedExercises.contains(exercise);
                    return GestureDetector(
                      onTap: () => toggleSelection(exercise),
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 2),
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Color(0xff3D4456),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color:
                                isSelected ? Colors.amber : Color(0xff3D4456),
                            width: 2,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              exercise['name'],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Wrap(
                              spacing: 8.0,
                              runSpacing: 4.0,
                              children: exercise['targetMuscles']
                                  .map<Widget>((muscle) {
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(9),
                                    border: Border.all(
                                        color: Colors.yellow, width: 1.5),
                                  ),
                                  child: Text(
                                    muscle,
                                    style: TextStyle(
                                      color: Colors.yellow,
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNameInputField() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Color(0xff3D4456),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextField(
        controller: searchController,
        style: TextStyle(color: Color(0xffffffff)),
        decoration: InputDecoration(
          isDense: true,
          hintText: "Name your exercise",
          hintStyle: TextStyle(color: Colors.grey, fontSize: 13),
          border: InputBorder.none,
        ),
        onChanged: (value) {
          filterExercises(value);
        },
      ),
    );
  }
}
