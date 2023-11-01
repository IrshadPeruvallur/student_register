import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:student_register/function/db_function.dart';
import 'package:student_register/function/nr_function.dart';
import 'package:student_register/model/data_model.dart';
import 'package:student_register/widgets/widgets.dart'; // Import for StudentModel

final nameController = TextEditingController();
final ageController = TextEditingController();
final numberController = TextEditingController();
final emailController = TextEditingController();
final formKey = GlobalKey<FormState>();

class AddDetails extends StatelessWidget {
  AddDetails({Key? key}) : super(key: key);

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
}
