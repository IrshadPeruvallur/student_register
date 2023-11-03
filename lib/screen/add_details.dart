import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_register/function/db_function.dart';
import 'package:student_register/model/data_model.dart';
import 'package:student_register/widgets/widgets.dart';

final nameController = TextEditingController();
final ageController = TextEditingController();
final numberController = TextEditingController();
final emailController = TextEditingController();
final formKey = GlobalKey<FormState>();

class AddDetails extends StatefulWidget {
  AddDetails({Key? key}) : super(key: key);

  @override
  State<AddDetails> createState() => _AddDetailsState();
}

class _AddDetailsState extends State<AddDetails> {
  final imagePicker = ImagePicker();

  File? picked;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Details"),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SizedBox(height: 110),
              GestureDetector(
                onTap: () {
                  getImage(ImageSource.camera);
                },
                child: CircleAvatar(
                  child: picked == null
                      ? Icon(Icons.add_a_photo)
                      : ClipOval(
                          child: Image.file(
                            picked!,
                            fit: BoxFit.cover,
                            width: 120,
                            height: 120,
                          ),
                        ),
                  radius: 50,
                ),
              ),
              SizedBox(height: 20),
              buildTextField(controller: nameController, label: "Name"),
              SizedBox(height: 20),
              buildTextField(
                controller: ageController,
                label: "Age",
                keyboardType: TextInputType.phone,
                maxLength: 2,
              ),
              buildTextField(
                controller: numberController,
                label: "Phone",
                maxLength: 10,
                keyboardType: TextInputType.phone,
              ),
              buildTextField(
                controller: emailController,
                label: "Email",
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    addOnButtonClick(context);
                  }
                },
                child: Text("Submit"),
              )
            ],
          ),
        ),
      ),
    );
  }

  void addOnButtonClick(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      final name = nameController.text.trim();
      final age = ageController.text.trim();
      final number = numberController.text.trim();
      final email = emailController.text.trim();

      if (name.isNotEmpty &&
          age.isNotEmpty &&
          number.isNotEmpty &&
          email.isNotEmpty) {
        final student = StudentModel(
            name: name,
            age: age,
            phone: number,
            email: email,
            image: picked?.path ?? "");
        addStudent(student);
        Navigator.pop(context);
      }
      nameController.clear();
      ageController.clear();
      numberController.clear();
      emailController.clear();
    }
  }

  void getImage(ImageSource source) async {
    final img = await imagePicker.pickImage(source: source);
    setState(() {
      picked = File(img!.path);
    });
  }
}
