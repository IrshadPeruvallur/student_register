import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:student_register/function/db_function.dart';
import 'package:student_register/screen/edit_screen.dart';
import 'package:student_register/screen/student_data.dart';

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
