import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/student_model.dart';
import '../models/students_list_model.dart';

TextStyle kTextFieldStyle = const TextStyle(
  decorationColor: Colors.red,
  color: Colors.blueGrey,
);

class StudentForm extends StatefulWidget {
  final StudentModel? student;
  // ignore: use_key_in_widget_constructors
  const StudentForm({this.student});
  @override
  _StudentFormState createState() => _StudentFormState();
}

class _StudentFormState extends State<StudentForm> {
  late bool isEditing;
  late TextEditingController nameController;
  late TextEditingController ageController;
  @override
  void initState() {
    super.initState();
    isEditing = false;
    nameController = TextEditingController();
    ageController = TextEditingController();
    if (widget.student != null) {
      isEditing = true;
      nameController.text = widget.student!.name;
      nameController.selection = TextSelection.fromPosition(
        TextPosition(offset: nameController.text.length),
      );
      ageController.text = widget.student!.age.toString();
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    StudentsListModel studentsObject = Provider.of<StudentsListModel>(context);
    return Container(
      padding: const EdgeInsets.only(top: 50),
      child: Container(
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 0),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 30),
            Text(
              isEditing ? widget.student!.name : 'เพิ่มนักเรียน',
              style: const TextStyle(
                color: Colors.pinkAccent,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'ชื่อ',
                focusColor: Colors.pink,
                labelStyle: kTextFieldStyle,
                icon: const Icon(
                  Icons.person_outline,
                  color: Colors.blueGrey,
                ),
                fillColor: Colors.blueGrey,
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueGrey),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.pinkAccent),
                ),
              ),
              controller: nameController,
              autofocus: true,
              autocorrect: false,
              style: kTextFieldStyle,
            ),
            const SizedBox(
              height: 30,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'อายุ',
                focusColor: Colors.pink,
                labelStyle: kTextFieldStyle,
                icon: const Icon(
                  Icons.drive_file_rename_outline,
                  color: Colors.blueGrey,
                ),
                fillColor: Colors.blueGrey,
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueGrey),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.pinkAccent),
                ),
              ),
              controller: ageController,
              keyboardType: TextInputType.number,
              style: kTextFieldStyle,
            ),
            const SizedBox(
              height: 30,
            ),
            _buildButton(studentsObject),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(StudentsListModel studentsObject) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'ยกเลิก',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            if (isEditing) {
              studentsObject.editStudent(
                StudentModel(
                  id: widget.student!.id,
                  name: nameController.text,
                  age: int.tryParse(ageController.text) ?? 0,
                ),
              );
            } else {
              studentsObject.addStudent(
                StudentModel(
                  id: DateTime.now().toIso8601String(),
                  name: nameController.text,
                  age: int.tryParse(ageController.text) ?? 0,
                ),
              );
            }
            Navigator.of(context).pop();
          },
          child: Text(
            isEditing ? 'แก้ไข' : 'เพิ่ม',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ],
    );
  }
}
