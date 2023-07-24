import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './models/students_list_model.dart';
import './screens/students_screen.dart';

void main() {
  runApp(MyApp());
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => StudentsListModel(students: []),
      builder: (_, __) => MaterialApp(
        home: StudentsScreen(),
        theme: ThemeData.dark(),
      ),
    );
  }
}
