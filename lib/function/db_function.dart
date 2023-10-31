import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_register/model/data_model.dart';

ValueNotifier<List<StudentModel>> studentListNotifier = ValueNotifier([]);

void addStudent(StudentModel value) async {
  // studentListNotifier.value.add(value);
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
