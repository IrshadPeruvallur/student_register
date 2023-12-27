import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_register/model/data_model.dart';
import 'package:student_register/services/db_function.dart';

class AddProvider extends ChangeNotifier {
  final namecontroller = TextEditingController();

  final ageController = TextEditingController();

  final numberController = TextEditingController();

  final emailController = TextEditingController();
  final ImagePicker imagePicker = ImagePicker();
  File? picked;

  final formkey = GlobalKey<FormState>();

  Future<void> onAddStudentOnClick() async {
    final _name = namecontroller.text.trim();
    final _number = numberController.text.trim();
    final _age = ageController.text.trim();
    final _email = emailController.text.trim();
    if (_name.isEmpty || _number.isEmpty || _age.isEmpty) {
      return;
    }

    final _student = StudentModel(
        name: _name,
        age: _age,
        number: _number,
        email: _email,
        image: picked?.path ?? '');

    addStudent(_student);
    notifyListeners();
  }

  getimage(ImageSource source) async {
    var img = await imagePicker.pickImage(source: source);
    picked = File(img!.path);
    notifyListeners();
  }
}
