import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:student_register/widgets/widgets.dart'; // Import for FilteringTextInputFormatter

final nameController = TextEditingController();
final ageController = TextEditingController();
final numberController = TextEditingController();
final addressController = TextEditingController();
final formKey = GlobalKey<FormState>();

class AddDetails extends StatelessWidget {
  AddDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Details"),
      ),
      body: Form(
        key: formKey, // Add the formKey here
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              buildTextField(controller: nameController, label: "Name"),
              buildTextField(
                  controller: ageController,
                  label: "Age",
                  keyboardType: TextInputType.phone,
                  maxLength: 2),
              buildTextField(
                controller: numberController,
                label: "Phone",
                maxLength: 10,
                keyboardType: TextInputType.phone,
              ),
              buildTextField(controller: addressController, label: "Address"),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    // Call your add function here
                    // addOnButtonClick();
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
