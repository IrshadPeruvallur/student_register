import 'package:student_register/screen/add_details.dart';

void addOnButtonClick() {
  if (formKey.currentState!.validate()) {
    final name = nameController.text.trim();
    final age = ageController.text.trim();
    final phoneNumber = numberController.text.trim();
    final address = addressController.text.trim();

    if (name.isNotEmpty &&
        age.isNotEmpty &&
        phoneNumber.isNotEmpty &&
        address.isNotEmpty) {
      print('object');
    }
  }
}
