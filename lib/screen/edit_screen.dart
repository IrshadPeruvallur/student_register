import 'package:flutter/material.dart';
import 'package:student_register/function/db_function.dart';
import 'package:student_register/function/nr_function.dart';
import 'package:student_register/screen/add_details.dart';
import 'package:student_register/widgets/widgets.dart';

class EditDeatils extends StatefulWidget {
  final String name;
  final String age;
  final String number;
  final String email;
  final int index;

  const EditDeatils(
      {super.key,
      required this.name,
      required this.age,
      required this.number,
      required this.email,
      required this.index});

  @override
  State<EditDeatils> createState() => _EditDeatilsState();
}

class _EditDeatilsState extends State<EditDeatils> {
  @override
  void initState() {
    nameController.text = widget.name;
    ageController.text = widget.age;
    numberController.text = widget.number;
    emailController.text = widget.number;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(12, 58, 45, 255),
      appBar: AppBar(
        title: Text("Add Details"),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SizedBox(height: 150),
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
                    updateStudent(context, widget.index);
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
}
