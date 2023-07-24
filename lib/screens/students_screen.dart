import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/students_list_model.dart';
import '../screens/add_student_screen.dart';
import '../widgets/students_list.dart';

// ignore: use_key_in_widget_constructors
class StudentsScreen extends StatefulWidget {
  @override
  _StudentsScreenState createState() => _StudentsScreenState();
}

class _StudentsScreenState extends State<StudentsScreen> {
  @override
  Widget build(BuildContext context) {
    StudentsListModel studentsObject = Provider.of<StudentsListModel>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 40.0,
                    child: Icon(
                      Icons.people_alt,
                      size: 40.0,
                      color: Colors.white,
                    ),
                    backgroundColor: Colors.pink,
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    'รายชื่อนักเรียน',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.grey.shade400,
                      fontSize: 40,
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    'นักเรียนทั้งหมด ${studentsObject.students.length} คน',
                    style: const TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    // left: 40,
                    // right: 40,
                    top: 20,
                    bottom: 10,
                  ),
                  child: StudentList(),
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Color.fromARGB(255, 230, 3, 3),
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) => AddStudentScreen(),
          );
        },
      ),
    );
  }
}
