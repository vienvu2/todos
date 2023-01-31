import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:todos/screen/index.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  windowManager.setAlwaysOnTop(true);
  windowManager.setSize(const Size(350, 350 * 2), animate: true);
  windowManager.setTitleBarStyle(TitleBarStyle.hidden);
  windowManager.setMinimumSize(const Size(350, 350));
  windowManager.setMaximumSize(const Size(350, 350 * 3));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: MainPage(),
    );
  }
}
