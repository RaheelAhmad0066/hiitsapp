import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'detabase/prefutils.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CreateNewExercise extends StatefulWidget {
  @override
  State<CreateNewExercise> createState() => _CreateNewExerciseState();
}

class _CreateNewExerciseState extends State<CreateNewExercise> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  List<dynamic> exercises = [];
  Map<String, bool> selectedMuscles = {};
  List<dynamic> filteredExercises = [];

  @override
  void initState() {
    super.initState();
    loadExercises();
    _searchController.addListener(_filterExercises);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> loadExercises() async {
    // Define the default muscle names
    final List<Map<String, String>> defaultMuscles = [
      {'Specific Mucle Table': 'Abs'},
      {'Specific Mucle Table': 'Back'},
      {'Specific Mucle Table': 'Biceps'},
      {'Specific Mucle Table': 'Calves'},
      {'Specific Mucle Table': 'Chest'},
      {'Specific Mucle Table': 'Forearms'},
      {'Specific Mucle Table': 'Glutes'},
      {'Specific Mucle Table': 'Hamstring'},
      {'Specific Mucle Table': 'Neck'},
      {'Specific Mucle Table': 'Quadriceps'},
    ];

    setState(() {
      exercises = defaultMuscles;
      filteredExercises = defaultMuscles;
    });
  }

  void _filterExercises() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      filteredExercises = exercises
          .where((exercise) =>
              exercise['Specific Mucle Table'].toLowerCase().contains(query))
          .toList();
    });
  }

  void _submit() {
    final name = _nameController.text;
    final selected = selectedMuscles.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();

    if (name.isNotEmpty && selected.isNotEmpty) {
      final newExercise = {
        'name': name,
        'targetMuscles': selected,
        'duration': 20, // Default duration
        'rounds': 8, // Default rounds
      };

      PrefUtils.getSelectedExercises().then((exercises) {
        exercises.add(newExercise);
        PrefUtils.saveSelectedExercises(exercises);
      });
      Get.back();
      Fluttertoast.showToast(
          msg: 'Workout added',
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.white,
          textColor: Colors.black);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: Name and target muscles must be selected.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.4 -
                        8), // Adjust the value as needed
                width: 20.0,
                height: 4.0,
                decoration: BoxDecoration(
                  color: Color(0xffffffff).withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            _buildHeader(),
            _buildNameInputField(),
            _buildMuscleSelection(screenWidth),
            SizedBox(
              height: 80,
            ),
            _buildSubmitButton(screenWidth),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // GestureDetector(
              //   onTap: () => widget.setShowCreateNewExercise(false),
              //   child: Image.asset("assets/icons/goBack.png"),
              // ),
              Text(
                'Create new exercise',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 20), // To maintain spacing consistency
            ],
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
        controller: _nameController,
        style: TextStyle(color: Color(0xffffffff)),
        decoration: InputDecoration(
          isDense: true,
          hintText: "Name your exercise",
          hintStyle: TextStyle(color: Colors.grey, fontSize: 13),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildMuscleSelection(double screenWidth) {
    return Column(
      children: [
        _buildSearchField(),
        SizedBox(
          height: Get.height * 0.4,
          child: Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: filteredExercises.length,
              itemBuilder: (context, index) {
                final muscle = filteredExercises[index]['Specific Mucle Table'];
                return Row(
                  children: [
                    Checkbox(
                      value: selectedMuscles[muscle] ?? false,
                      activeColor: Color(0xffF7D15E),
                      onChanged: (bool? value) {
                        setState(() {
                          selectedMuscles[muscle] = value ?? false;
                        });
                      },
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        muscle,
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchField() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Color(0xff3D4456)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Image.asset('assets/icons/search_icon.png'),
          SizedBox(width: 8.0),
          Expanded(
            child: TextField(
              controller: _searchController,
              style: TextStyle(color: Color(0xffffffff)),
              decoration: InputDecoration(
                hintText: "Search",
                hintStyle: TextStyle(color: Colors.grey, fontSize: 13),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton(double screenWidth) {
    return Container(
      width: screenWidth,
      height: MediaQuery.of(context).size.height * 0.06,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xffF7D15E),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(26))),
        onPressed: _submit,
        child: Text(
          'Add To Workout',
          style: TextStyle(
            color: Color(0xff242935),
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
