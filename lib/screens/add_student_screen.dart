import 'package:flutter/material.dart';
import '../widgets/student_form.dart';

// ignore: use_key_in_widget_constructors
class AddStudentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff747574),
      child: StudentForm(),
    );
  }
}
