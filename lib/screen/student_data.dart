import 'dart:io';

import 'package:flutter/material.dart';

class StudentDat extends StatelessWidget {
  final String name;
  final String age;
  final String number;
  final String email;
  final String image;

  const StudentDat(
      {super.key,
      required this.name,
      required this.age,
      required this.number,
      required this.email,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 235, 245, 251),
      appBar: AppBar(
          title: Text("Details Form"),
          elevation: 15,
          centerTitle: true,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(25))),
          backgroundColor: Color.fromARGB(255, 27, 79, 144)),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            CircleAvatar(
              backgroundImage: FileImage(File(image)),
              radius: 80,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Container(
                    width: double
                        .infinity, // Make the container fill the screen width
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          'Name : $name',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: double
                        .infinity, // Make the container fill the screen width
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          'Age : $age',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: double
                        .infinity, // Make the container fill the screen width
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          'Number : $number',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: double
                        .infinity, // Make the container fill the screen width
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          'Email: $email',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
