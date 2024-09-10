import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hiits/appassets/apptextstyle.dart';
import 'package:hiits/appassets/apsizedbox.dart';

import '../../widgets/sidebar/sidebar.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF252835),
      drawer: Sidebar(),
      body: Column(
        children: [
          AppSizedBoxes.largeSizedBox,
          Row(
            children: [
              Builder(
                builder: (context) => IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: Image.asset(
                    'assets/icons/sidebar_icon.png',
                    height: 24,
                  ),
                ),
              ),
              AppSizedBoxes.largeWidthSizedBox,
              AppSizedBoxes.largeWidthSizedBox,
              AppSizedBoxes.largeWidthSizedBox,
              Center(
                child: Text(
                  'Settings',
                  style: AppTextStyles.heading1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
