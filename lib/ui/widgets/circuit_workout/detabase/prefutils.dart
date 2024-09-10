import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class PrefUtils {
  static Future<void> saveSelectedExercises(
      List<Map<String, dynamic>> exercises) async {
    final prefs = await SharedPreferences.getInstance();
    final exerciseList =
        exercises.map((exercise) => json.encode(exercise)).toList();
    await prefs.setStringList('selectedExercises', exerciseList);
  }

  static Future<List<Map<String, dynamic>>> getSelectedExercises() async {
    final prefs = await SharedPreferences.getInstance();
    final exerciseList = prefs.getStringList('selectedExercises') ?? [];
    return exerciseList
        .map((exercise) => json.decode(exercise))
        .cast<Map<String, dynamic>>()
        .toList();
  }
}
