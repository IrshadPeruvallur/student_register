import 'package:flutter/material.dart';

class StudentData extends StatefulWidget {
  final String name;
  final String age;
  final String number;
  final String email;

  const StudentData({
    Key? key,
    required this.name,
    required this.age,
    required this.number,
    required this.email,
  }) : super(key: key);

  @override
  State<StudentData> createState() => _StudentDataState();
}

class _StudentDataState extends State<StudentData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Name : ${widget.name}'),
            Text(widget.age),
            Text(widget.number),
            Text(widget.email)
          ],
        ),
      ),
    );
  }
}
