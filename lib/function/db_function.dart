import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_register/model/data_model.dart';
import 'package:student_register/screen/add_details.dart';
import 'package:student_register/screen/edit_screen.dart';
import 'package:student_register/screen/home_screen.dart';

ValueNotifier<List<StudentModel>> studentListNotifier = ValueNotifier([]);

void addStudent(StudentModel value) async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');
  await studentDB.add(value);
  getAllStudent();
}

void getAllStudent() async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');
  studentListNotifier.value.clear();
  studentListNotifier.value.addAll(studentDB.values);
  studentListNotifier.notifyListeners();
}

void deleteStudent(int index) async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');
  await studentDB.deleteAt(index);
  getAllStudent();
}

void updateStudent(BuildContext context, int index) async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');
  if (index >= 0 && index < studentDB.length) {
    final updatedStudent = StudentModel(
        name: nameController.text,
        age: ageController.text,
        phone: numberController.text,
        email: emailController.text,
        image: selectImage!.path);
    await studentDB.putAt(index, updatedStudent);
    getAllStudent();
    Navigator.pop(context);
  }
}
