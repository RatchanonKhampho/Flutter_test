import 'package:flutter/material.dart';
import 'student_model.dart';

class StudentsListModel extends ChangeNotifier {
  List<StudentModel> students;
  StudentsListModel({required this.students});
  void addStudent(StudentModel newStudent) {
    students.insert(0, newStudent);
    notifyListeners();
  }

  void editStudent(StudentModel newStudent) {
    var index = students.indexWhere((element) => element.id == newStudent.id);
    if (index != -1) {
      students[index] = StudentModel(
        id: newStudent.id,
        name: newStudent.name,
        age: newStudent.age,
      );
      notifyListeners();
    }
  }

  void deleteStudent(StudentModel editStudent) {
    students.map((e) => e.id != editStudent.id).toList();
    notifyListeners();
  }
}
