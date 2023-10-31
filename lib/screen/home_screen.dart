import 'package:flutter/material.dart';
import 'package:student_register/screen/add_details.dart';
import 'package:student_register/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [Icon(Icons.search)]),
      body: buildStudentList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddDetails(),
            )),
        child: Icon(Icons.person_add),
      ),
    );
  }
}