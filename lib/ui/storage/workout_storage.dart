// workout_storage.dart

import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/custome_timer_modal.dart';

class WorkoutStorage {
  static const String customworkout = 'customworkout';
  static Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/saved_workouts.txt');
  }

  static Future<void> saveWorkouts(List<String> workouts) async {
    final file = await _getFile();
    await file.writeAsString(workouts.join('\n'));
  }

  static Future<List<String>> loadWorkouts() async {
    try {
      final file = await _getFile();
      final lines = await file.readAsLines();
      return lines;
    } catch (e) {
      return [];
    }
  }

  Future<void> saveCustomWorkoutTime(List customtime) async {
    final prefs = await SharedPreferences.getInstance();
    final todosJson = customtime.map((todo) => todo.toJson()).toList();
    await prefs.setStringList(customworkout, todosJson.cast<String>());
  }

  Future<List<CustomeTimerModal>> getCustomer() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> todosJson = prefs.getStringList(customworkout) ?? [];
    if (todosJson != null) {
      final todos = todosJson
          .map((todoJson) => CustomeTimerModal.fromJson(todoJson))
          .toList();
      return todos;
    } else {
      return [];
    }
  }
}
