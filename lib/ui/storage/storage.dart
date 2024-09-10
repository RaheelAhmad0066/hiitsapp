import 'dart:convert';

import 'package:hiits/ui/models/timer_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/custome_timer_modal.dart';

class TodoStorage {
  static const String _todoKey = 'todos';
  static const String customworkout = 'customworkout';

  Future<TimerModel?> getSavedTimer() async {
    final prefs = await SharedPreferences.getInstance();
    final encodedTimer = prefs.getString('selectedTimer');

    if (encodedTimer != null) {
      final decodedTimer = jsonDecode(encodedTimer);
      return TimerModel.fromJson(decodedTimer);
    }

    return null;
  }

  Future<List<TimerModel>> getTimers() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> todosJson = prefs.getStringList(_todoKey) ?? [];
    if (todosJson != null) {
      final todos =
          todosJson.map((todoJson) => TimerModel.fromJson(todoJson)).toList();
      return todos;
    } else {
      return [];
    }
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

  Future<void> saveExerciseTimer(List todos) async {
    final prefs = await SharedPreferences.getInstance();
    final todosJson = todos.map((todo) => todo.toJson()).toList();
    await prefs.setStringList(_todoKey, todosJson.cast<String>());
  }

  Future<void> saveCustomWorkoutTime(List customtime) async {
    final prefs = await SharedPreferences.getInstance();
    final todosJson = customtime.map((todo) => todo.toJson()).toList();
    await prefs.setStringList(customworkout, todosJson.cast<String>());
  }

  Future<void> saveStartTimer(TimerModel timer) async {
    final prefs = await SharedPreferences.getInstance();
    final _timer = jsonEncode(timer.toJson());
    await prefs.setString('selectedTimer', _timer);
  }

  Future<void> nullStartTimer() async {
    final prefs = await SharedPreferences.getInstance();
    final nullTimer = null;
    await prefs.setString('selectedTimer', nullTimer.cast<String>());
  }
}
