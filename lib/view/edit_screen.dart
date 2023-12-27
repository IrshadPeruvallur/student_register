import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_register/services/db_function.dart';
import 'package:student_register/model/data_model.dart';
import 'package:student_register/view/home_screen.dart';

final TextEditingController nameController = TextEditingController();
final TextEditingController ageController = TextEditingController();
final TextEditingController numberController = TextEditingController();
final TextEditingController emailController = TextEditingController();
File? selectimage;

class EditDetails extends StatefulWidget {
  final String name;
  final String age;
  final String number;
  final String email;
  final String image;
  final int index;

  const EditDetails({
    super.key,
    required this.name,
    required this.age,
    required this.number,
    required this.email,
    required this.image,
    required this.index,
  });

  @override
  State<EditDetails> createState() => _EditDetailsState();
}

class _EditDetailsState extends State<EditDetails> {
  final _formkey = GlobalKey<FormState>();
  final ImagePicker imagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.name;
    ageController.text = widget.age;
    numberController.text = widget.number;
    emailController.text = widget.email;
    selectimage = widget.image != null ? File(widget.image) : null;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit Student'),
          elevation: 15,
          centerTitle: true,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(25))),
          backgroundColor: Color.fromARGB(255, 27, 79, 144),
        ),
        body: Form(
          key: _formkey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () => updateImage(ImageSource.camera),
                      child: CircleAvatar(
                        backgroundColor: Color.fromARGB(255, 133, 193, 233),
                        child: selectimage == null
                            ? Icon(
                                Icons.add_a_photo,
                                color: Color.fromARGB(255, 27, 79, 144),
                                size: 35,
                              )
                            : ClipOval(
                                child: Image.file(
                                  selectimage!,
                                  fit: BoxFit.cover,
                                  height: 120,
                                  width: 120,
                                ),
                              ),
                        radius: 60,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromARGB(255, 27, 79, 144)),
                      ),
                      onPressed: () {
                        updateImage(ImageSource.gallery);
                      },
                      child: Text("Choose from Gallery"),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-z\s]'))
                      ],
                      controller: nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: "Name",
                        hintText: "Enter your Name",
                        prefixIcon: Icon(Icons.person),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'value is empty';
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: ageController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          labelText: "Age",
                          hintText: "Enter your Age",
                          prefixIcon: Icon(Icons.calendar_month_outlined),
                        ),
                        maxLength: 3,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'value is empty';
                          } else {
                            return null;
                          }
                        }),
                    TextFormField(
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: numberController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          labelText: "phone",
                          hintText: "enter your phone number",
                          prefixText: "+91",
                          prefixIcon: Icon(Icons.phone),
                        ),
                        maxLength: 10,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'value is empty';
                          } else {
                            return null;
                          }
                        }),
                    TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            labelText: "Email",
                            hintText: "Enter your Email",
                            prefixIcon: Icon(Icons.email)),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'value is empty';
                          } else {
                            return null;
                          }
                        }),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                Color.fromARGB(255, 27, 79, 144)),
                            padding: MaterialStatePropertyAll(
                                EdgeInsets.fromLTRB(50, 15, 50, 15)),
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)))),
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            updateStudent(widget.index);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()));
                          }
                        },
                        child: Text("Update"))
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  updateImage(ImageSource source) async {
    var img = await imagePicker.pickImage(source: source);
    setState(() {
      selectimage = File(img!.path);
    });
  }
}
