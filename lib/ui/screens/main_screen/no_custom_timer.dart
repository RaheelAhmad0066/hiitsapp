import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hiits/ui/storage/storage.dart';
import 'package:hiits/ui/widgets/buttons/bottom_button.dart';
import 'create_new_timer.dart';

class noCustomTimer extends StatefulWidget {
  // const noCustomTimer({super.key});
  final Function _loadTimers;

  const noCustomTimer(this._loadTimers);
  _noCustomTimer createState() => _noCustomTimer();
}

class _noCustomTimer extends State<noCustomTimer>
    with TickerProviderStateMixin {
  bool showCreateNewTimer = false;
  late String name;
  TextEditingController _nameController = TextEditingController();
  final TodoStorage _storage = TodoStorage();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: <Widget>[
      Center(
        child: Container(
          height: MediaQuery.of(context).size.height - 290,
          // width: 200,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/icons/twemoji_timer-clock.png",
                ),
                Text("No customer timer",
                    style: TextStyle(
                        color: Color(0xffffffff),
                        fontWeight: FontWeight.w600,
                        fontSize: 20)),
                Text("Create a custom timer and ",
                    style: TextStyle(
                        color: Color(0xff878894),
                        fontWeight: FontWeight.w400,
                        fontSize: 18)),
                Text("save for later use ",
                    style: TextStyle(
                        color: Color(0xff878894),
                        fontWeight: FontWeight.w400,
                        fontSize: 18)),
              ],
            ),
          ),
        ),
      ),
      bottomButton(
        Text: "Create New Timer",
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => createNewTimer(widget._loadTimers),
              ));
        },
      )
    ]));
  }

  Future<void> _loadTimers() async {
    // var loadTmers = await _storage.getTimers();

    // print(loadTmers.length);

    // setState(() {
    //   timers = loadTmers;
    // });
  }
}
