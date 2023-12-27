import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:student_register/model/data_model.dart';
import 'package:student_register/view/edit_screen.dart';
import 'package:student_register/view/home_screen.dart';

ValueNotifier<List<StudentModel>> studenlistnotfier = ValueNotifier([]);

Future<void> addStudent(StudentModel value) async {
  final studentDb = await Hive.openBox<StudentModel>("student_db");
  await studentDb.add(value);
  getAllStudent();
}

Future<void> getAllStudent() async {
  final studentDb = await Hive.openBox<StudentModel>("student_db");
  studenlistnotfier.value.clear();
  studenlistnotfier.value.addAll(studentDb.values);
  studenlistnotfier.notifyListeners();
}

Future<void> deleteStudent(int index) async {
  final studentDb = await Hive.openBox<StudentModel>("student_db");
  await studentDb.deleteAt(index);
  getAllStudent();
}

Future<void> updateStudent(int index) async {
  final studentDb = await Hive.openBox<StudentModel>("student_db");

  if (index >= 0 && index < studentDb.length) {
    final updatedStudent = StudentModel(
      name: nameController.text,
      age: ageController.text,
      number: numberController.text,
      email: emailController.text,
      image: selectimage!.path,
    );

    await studentDb.putAt(index, updatedStudent);
    getAllStudent();
  }
}
