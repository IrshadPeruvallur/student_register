import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final _nameController = TextEditingController();
final _ageController = TextEditingController();
final _phoneController = TextEditingController();
final _addressController = TextEditingController();
final _formKey = GlobalKey<FormState>();

Widget buildStudentList() {
  return GestureDetector(
    onTap: () => print('clicked'),
    child: ListView.separated(
        separatorBuilder: (context, index) => Divider(),
        itemBuilder: (context, index) => ListTile(
              title: Text(
                "Text",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              subtitle: Text("sub"),
              trailing: Icon(Icons.delete),
            ),
        itemCount: 10),
  );
}

Widget buildTextField({
  required TextEditingController controller,
  required String label,
  int? maxLength,
  TextInputType keyboardType = TextInputType.text,
}) {
  return Padding(
    padding: const EdgeInsets.all(15.0),
    child: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          TextFormField(
            controller: controller,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter $label";
              }
              return null; // Add this line to indicate no validation error
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
    ),
  );
}
