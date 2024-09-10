import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WorkoutController extends GetxController {
  var workoutList = <Workout>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadWorkoutData();
  }

  Future<void> _loadWorkoutData() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? workoutListJson = prefs.getStringList('workoutList');

    if (workoutListJson != null) {
      workoutList.value = workoutListJson
          .map((item) => Workout.fromMap(json.decode(item)))
          .toList();
    }
  }

  Future<void> saveWorkoutList() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> workoutListJson =
        workoutList.map((workout) => json.encode(workout.toMap())).toList();
    await prefs.setStringList('workoutList', workoutListJson);
  }

  void addWorkout(Workout workout) {
    workoutList.add(workout);
    saveWorkoutList();
  }

  void updateWorkout(int index, Workout updatedWorkout) {
    if (index >= 0 && index < workoutList.length) {
      workoutList[index] = updatedWorkout;
      saveWorkoutList();
    }
  }

  void deleteWorkout(int index) {
    if (index >= 0 && index < workoutList.length) {
      workoutList.removeAt(index);
      saveWorkoutList();
    }
  }
}

class Workout {
  final String name;
  final int sets;
  final String duration;
  final List<String> exersisename;
  final int round;
  final int restMinutes;
  final int restSeconds;
  final int coolDownMinutes;
  final int coolDownSeconds;
  final int workMinutes;
  final int workSeconds;
  final int totalRounds;
  final int totalSets;
  final int totalTime;
  final int totalHours;

  Workout({
    required this.name,
    required this.exersisename,
    required this.sets,
    required this.duration,
    required this.round,
    required this.restMinutes,
    required this.restSeconds,
    required this.coolDownMinutes,
    required this.coolDownSeconds,
    required this.workMinutes,
    required this.workSeconds,
    required this.totalRounds,
    required this.totalSets,
    required this.totalTime,
    required this.totalHours,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'sets': sets,
      'duration': duration,
      'exersiename': exersisename,
      'round': round,
      'restMinutes': restMinutes,
      'restSeconds': restSeconds,
      'coolDownMinutes': coolDownMinutes,
      'coolDownSeconds': coolDownSeconds,
      'workMinutes': workMinutes,
      'workSeconds': workSeconds,
      'totalRounds': totalRounds,
      'totalSets': totalSets,
      'totalTime': totalTime,
      'totalHours': totalHours,
    };
  }

  factory Workout.fromMap(Map<String, dynamic> map) {
    return Workout(
      name: map['name'] ?? '',
      exersisename: map['exersiename'] ?? '',
      sets: map['sets'] ?? 0,
      duration: map['duration'] ?? '',
      round: map['round'] ?? 0,
      restMinutes: map['restMinutes'] ?? 0,
      restSeconds: map['restSeconds'] ?? 0,
      coolDownMinutes: map['coolDownMinutes'] ?? 0,
      coolDownSeconds: map['coolDownSeconds'] ?? 0,
      workMinutes: map['workMinutes'] ?? 0,
      workSeconds: map['workSeconds'] ?? 0,
      totalRounds: map['totalRounds'] ?? 0,
      totalSets: map['totalSets'] ?? 0,
      totalTime: map['totalTime'] ?? 0,
      totalHours: map['totalHours'] ?? 0,
    );
  }
}
