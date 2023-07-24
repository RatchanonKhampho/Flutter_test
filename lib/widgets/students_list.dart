import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'no_data.dart';
import '../models/student_model.dart';
import '../models/students_list_model.dart';
import '../widgets/students_tile.dart';

// ignore: use_key_in_widget_constructors
class StudentList extends StatefulWidget {
  @override
  _StudentListState createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  late List<StudentModel> students;
  @override
  Widget build(BuildContext context) {
    StudentsListModel studentsObject = Provider.of<StudentsListModel>(context);
    students = studentsObject.students;
    // ignore: prefer_is_empty
    return students.length == 0
        ? const NoDataScreen(
            title: 'ยังไม่มีรายชื่อนักเรียน',
            details: 'เพิ่มรายชื่อนักเรียนโดยคลิกปุ่ม + ',
          )
        : ListView.builder(
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Dismissible(
                    key: Key(students[index].id),
                    child: StudentTile(student: students[index]),
                    background: Container(
                      decoration: const BoxDecoration(
                        color: Colors.pinkAccent,
                      ),
                    ),
                    onDismissed: (direction) {
                      if (direction == DismissDirection.endToStart) {
                        studentsObject.deleteStudent(students[index]);
                        students.removeAt(index);
                      }
                    },
                    direction: DismissDirection.endToStart,
                  ),
                  const Divider(
                    color: Colors.blueGrey,
                    indent: 20,
                    endIndent: 20,
                    height: 1,
                  ),
                ],
              );
            },
            itemCount: students.length,
          );
  }
}
