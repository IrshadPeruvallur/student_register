import 'package:flutter/material.dart';
import 'package:student_register/function/db_function.dart';
import 'package:student_register/model/data_model.dart';
import 'package:student_register/screen/add_details.dart';

void addOnButtonClick(BuildContext context) {
  if (formKey.currentState!.validate()) {
    final name = nameController.text.trim();
    final age = ageController.text.trim();
    final number = numberController.text.trim();
    final email = emailController.text.trim();

    if (name.isNotEmpty &&
        age.isNotEmpty &&
        number.isNotEmpty &&
        email.isNotEmpty) {
      final student =
          StudentModel(name: name, age: age, phone: number, email: email);
      addStudent(student);
      Navigator.pop(context);
    }
    nameController.clear();
    ageController.clear();
    numberController.clear();
    emailController.clear();
  }
}
