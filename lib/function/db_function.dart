import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:student_register/model/data_model.dart';
import 'package:student_register/screen/edit_screen.dart';
import 'package:student_register/screen/home_screen.dart';

ValueNotifier<List<studentModel>> studenlistnotfier = ValueNotifier([]);

Future<void> addstud(studentModel value) async {
  final studentDb = await Hive.openBox<studentModel>("student_db");
  await studentDb.add(value);
  getAllStud();
}

Future<void> getAllStud() async {
  final studentDb = await Hive.openBox<studentModel>("student_db");
  studenlistnotfier.value.clear();
  studenlistnotfier.value.addAll(studentDb.values);
  studenlistnotfier.notifyListeners();
}

Future<void> deletestud(int index) async {
  final studentDb = await Hive.openBox<studentModel>("student_db");
  await studentDb.deleteAt(index);
  getAllStud();
}

Future<void> updateStudent(int index) async {
  final studentDb = await Hive.openBox<studentModel>("student_db");

  if (index >= 0 && index < studentDb.length) {
    final updatedStudent = studentModel(
      name: nameController.text,
      age: ageController.text,
      number: numberController.text,
      email: emailController.text,
      image: selectimage!.path,
    );

    await studentDb.putAt(index, updatedStudent);
    getAllStud();
  }
}
