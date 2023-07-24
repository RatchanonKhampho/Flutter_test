import 'package:flutter/material.dart';
import '../models/student_model.dart';
import '../screens/edit_student_screen.dart';

TextStyle kTileTextStyle = const TextStyle(
  color: Colors.pinkAccent,
  fontSize: 18,
  fontWeight: FontWeight.w500,
);

class StudentTile extends StatelessWidget {
  final StudentModel student;
  // ignore: use_key_in_widget_constructors
  const StudentTile({required this.student});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(
        left: 60,
        right: 60,
        top: 0,
        bottom: 0,
      ),
      title: Text(
        student.name,
        style: kTileTextStyle,
      ),
      trailing: Text(
        student.age.toString(),
        style: kTileTextStyle,
      ),
      onTap: () {
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context) => EditStudentScreen(
            student: student,
          ),
        );
      },
    );
  }
}
