import 'package:final_course/screens/mainScreen.dart';
import 'package:flutter/material.dart';
import 'package:final_course/screens/signInScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
     
      home: login(),
      routes: {
        'login': (context) => const login(),
        'MainScreen': (context) => MainScreen(),
      },
    );
  }
}