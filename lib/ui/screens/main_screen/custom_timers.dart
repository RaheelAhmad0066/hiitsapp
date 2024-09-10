import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hiits/ui/models/timer_model.dart';
import 'package:hiits/ui/screens/main_screen/customer_timers_list.dart';
import 'package:hiits/ui/screens/main_screen/no_custom_timer.dart';
import 'package:hiits/ui/storage/storage.dart';

class customTimers extends StatefulWidget {
  customTimers();

  @override
  _customTimers createState() => _customTimers();
}

class _customTimers extends State<customTimers> with TickerProviderStateMixin {
  late List<TimerModel> timers = [];

  final TodoStorage _storage = TodoStorage();

  @override
  Widget build(BuildContext context) {
    return timers.length > 0
        ? customTimersList(_loadTimers)
        : noCustomTimer(_loadTimers);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _loadTimers();
  }

  void didChangeDependencies() {
    super.didChangeDependencies();

    print("=-0-0-");
  }

  Future<void> _loadTimers() async {
    var loadTmers = await _storage.getTimers();

    setState(() {
      timers = loadTmers.reversed.toList();
    });
  }
}
