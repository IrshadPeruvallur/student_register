import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:student_register/controller/add_provider.dart';
import 'package:student_register/services/db_function.dart';
import 'package:student_register/model/data_model.dart';
import 'package:student_register/view/home_screen.dart';
import 'package:student_register/view/student_data.dart';

class AddDetails extends StatelessWidget {
  AddDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final getProvider = Provider.of<AddProvider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 235, 245, 251),
        appBar: AppBar(
          title: Text("Details Form"),
          elevation: 15,
          centerTitle: true,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(25))),
          backgroundColor: Color.fromARGB(255, 27, 79, 144),
          automaticallyImplyLeading: false,
        ),
        body: Form(
          key: getProvider.formkey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Consumer<AddProvider>(builder: (context, value, child) {
                      return GestureDetector(
                        onTap: () => getProvider.getimage(ImageSource.camera),
                        child: CircleAvatar(
                          backgroundColor: Color.fromARGB(255, 133, 193, 233),
                          child: value.picked == null
                              ? Icon(
                                  Icons.add_a_photo,
                                  color: Color.fromARGB(255, 27, 79, 144),
                                  size: 35,
                                )
                              : ClipOval(
                                  child: Image.file(
                                    value.picked!,
                                    fit: BoxFit.cover,
                                    height: 120,
                                    width: 120,
                                  ),
                                ),
                          radius: 60,
                        ),
                      );
                    }),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromARGB(255, 27, 79, 144)),
                      ),
                      onPressed: () {
                        getProvider.getimage(ImageSource.gallery);
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
                      controller: getProvider.namecontroller,
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
                        controller: getProvider.ageController,
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
                        controller: getProvider.numberController,
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
                        controller: getProvider.emailController,
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
                          if (getProvider.formkey.currentState!.validate()) {
                            getProvider.onAddStudentOnClick();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()));
                          }
                        },
                        child: Text("Submit"))
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
