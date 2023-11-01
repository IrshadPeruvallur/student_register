import 'package:flutter/material.dart';
import 'package:student_register/function/db_function.dart';
import 'package:student_register/screen/add_details.dart';
import 'package:student_register/screen/student_data.dart';
import 'package:student_register/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    getAllStudent();
    return Scaffold(
      // backgroundColor: Color.fromARGB(255, 33, 68, 51),
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
