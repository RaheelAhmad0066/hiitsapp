import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'controller/playbar_controller.dart';

class PlayBar extends StatelessWidget {
  final AudioController _audioController = Get.put(AudioController());

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return FractionallySizedBox(
      widthFactor: 0.95,
      child: Container(
        height: screenHeight * 0.10,
        decoration: BoxDecoration(
          border: Border.all(width: 1.w, color: Color(0xff3D4456)),
          borderRadius: BorderRadius.all(Radius.circular(10.0.w)),
        ),
        child: Padding(
          padding: EdgeInsets.all(14.0.w),
          child: Align(
            alignment: Alignment.center,
            child: Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      _selectMusic().then((value) {
                        _audioController.playMusic();
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Currently playing",
                          style: TextStyle(
                            color: Color(0xff878894),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        if (_audioController.fileName.value != null)
                          Text(
                            _audioController.fileName.value!.length > 30
                                ? _audioController.fileName.value!
                                        .substring(0, 30) +
                                    '...'
                                : _audioController.fileName.value!,
                            style: TextStyle(fontSize: 10),
                          )
                        else
                          Text("A popular workout music - Artist ...")
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (_audioController.isPlaying.value) {
                        _audioController.pauseMusic();
                      } else {
                        _audioController.playMusic();
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Image.asset(
                        _audioController.isPlaying.value
                            ? "assets/icons/pause_icon.png"
                            : "assets/icons/play_icon.png",
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectMusic() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
    );

    if (result != null && result.files.single.path != null) {
      _audioController.selectMusic(
          result.files.single.path, result.files.single.name);
    }
  }
}
