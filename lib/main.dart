import 'package:flutter/material.dart';

// import 'exercises/lesson_2.1.dart';
// import 'exercises/lesson_2.2.dart';
// import 'exercises/lesson_2.3.dart';
// import 'exercises/lesson_2.4.dart';
// import 'exercises/lesson_2.5.dart';
// import 'exercises/lesson_2.6.dart';
import 'exercises/lesson_2.7.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
