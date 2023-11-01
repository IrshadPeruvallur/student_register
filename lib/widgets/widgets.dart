import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:student_register/function/db_function.dart';
import 'package:student_register/screen/edit_screen.dart';
import 'package:student_register/screen/student_data.dart';

// final nameController = TextEditingController();
// final _ageController = TextEditingController();
// final _phoneController = TextEditingController();
// final _addressController = TextEditingController();
// final _formKey = GlobalKey<FormState>();

Widget buildStudentList() {
  return ValueListenableBuilder(
      valueListenable: studentListNotifier,
      builder: (context, studentList, child) {
        return ListView.separated(
          separatorBuilder: (context, index) => Divider(),
          itemBuilder: (context, index) {
            final data = studentList[index];
            return ListTile(
              onTap: () {
                print('Data button clicked');
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StudentData(),
                    ));
              },
              title: Text(
                data.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              subtitle: Text(data.phone),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      deleteStudent(index);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditDeatils(
                                name: data.name,
                                age: data.age,
                                number: data.phone,
                                email: data.email,
                                index: index),
                          ));
                    },
                  ),
                ],
              ),
            );
          },
          itemCount: studentList.length,
        );
      });
}

Widget buildTextField({
  required TextEditingController controller,
  required String label,
  int? maxLength,
  TextInputType keyboardType = TextInputType.text,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 75),
    child: Column(
      children: [
        Center(
          child: TextFormField(
            controller: controller,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter $label";
              }
              return null;
            },
            maxLength: maxLength,
            keyboardType: keyboardType,
            inputFormatters: [
              if (keyboardType == TextInputType.phone)
                FilteringTextInputFormatter.digitsOnly,
            ],
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              labelText: label,
            ),
          ),
        ),
      ],
    ),
  );
}
