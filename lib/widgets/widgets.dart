import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:student_register/function/db_function.dart';

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
                print('object');
              },
              title: Text(
                data.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              subtitle: Text(data.phone),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  deleteStudent(index);
                },
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
    padding: const EdgeInsets.all(15.0),
    child: Column(
      children: [
        TextFormField(
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
              borderRadius: BorderRadius.circular(15),
            ),
            labelText: label,
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    ),
  );
}
