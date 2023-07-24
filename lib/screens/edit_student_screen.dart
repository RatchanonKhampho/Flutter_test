import 'package:flutter/material.dart';
import '../widgets/student_form.dart';
import '../models/student_model.dart';

class EditStudentScreen extends StatelessWidget {
  final StudentModel student;
  // ignore: use_key_in_widget_constructors
  const EditStudentScreen({required this.student});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff747574),
      child: StudentForm(student: student),
    );
  }
}
