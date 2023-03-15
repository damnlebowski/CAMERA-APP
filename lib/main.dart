import 'package:camera_app/screens/screen_home.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

void main(List<String> args) {
  WidgetsFlutterBinding.ensureInitialized();
  Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(),
    );
  }
}
