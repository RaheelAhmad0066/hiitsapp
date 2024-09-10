import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './routes.dart';
import 'package:device_preview/device_preview.dart';

class DrawerMain extends StatelessWidget {
  const DrawerMain({super.key});

  static const appTitle = 'Drawer Demo';

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: ThemeData(
          scaffoldBackgroundColor: Color(0xFF252835),
          appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(color: Colors.white),
          )),
      home: DrawerClass(title: appTitle),
    );
  }
}

class DrawerClass extends StatelessWidget {
  const DrawerClass({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Routes(),
    );
  }
}
