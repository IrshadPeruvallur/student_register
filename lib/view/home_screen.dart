import 'dart:io';
import 'package:flutter/material.dart';
import 'package:student_register/services/db_function.dart';
import 'package:student_register/model/data_model.dart';
import 'package:student_register/view/add_details.dart';
import 'package:student_register/view/edit_screen.dart';
import 'package:student_register/view/student_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  List<StudentModel> studentList = [];
  List<StudentModel> filteredStudentList = [];

  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    // Initialize your studentList here, e.g., calling getAllStud()
    getAllStudent();
  }

  void filterStudents(String search) {
    if (search.isEmpty) {
      // If the search query is empty, show all students.
      setState(() {
        filteredStudentList = List.from(studentList);
      });
    } else {
      setState(() {
        filteredStudentList = studentList
            .where((student) =>
                student.name.toLowerCase().contains(search.toLowerCase()))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 235, 245, 251),
        appBar: AppBar(
          elevation: 15,
          centerTitle: true,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(25))),
          backgroundColor: Color.fromARGB(255, 27, 79, 144),
          title: isSearching ? buildSearchField() : Text("Student List"),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  isSearching = !isSearching;
                  if (!isSearching) {
                    // Clear the search query and show all students.
                    searchController.clear();
                    filteredStudentList = List.from(studentList);
                  }
                });
              },
              icon: Icon(isSearching ? Icons.cancel : Icons.search),
            ),
          ],
        ),
        body: Center(
          child: isSearching
              ? filteredStudentList.isNotEmpty
                  ? ListView.separated(
                      itemBuilder: (ctx, index) {
                        final data = filteredStudentList[index];
                        return buildStudentCard(data, index);
                      },
                      separatorBuilder: (ctx, index) {
                        return const Divider();
                      },
                      itemCount: filteredStudentList.length,
                    )
                  : Center(
                      child: Text("No results found."),
                    )
              : buildStudentList(),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.fromLTRB(30, 5, 0, 0),
          child: Container(
            width: double.infinity,
            child: FloatingActionButton.extended(
              backgroundColor: Color.fromARGB(255, 27, 79, 144),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddDetails(),
                  ),
                );
              },
              label: Text("Add Student"),
              icon: Icon(Icons.add),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSearchField() {
    return TextField(
      controller: searchController,
      onChanged: (query) {
        filterStudents(query);
      },
      autofocus: true,
      style: TextStyle(
        color: Colors.white, // Set the text color to white
      ),
      decoration: InputDecoration(
        hintText: "Search students...",
        hintStyle: TextStyle(
          color: Colors.white.withOpacity(0.7), // Set the hint text color
        ),
        border: InputBorder.none,
      ),
    );
  }

  Widget buildStudentCard(StudentModel data, int index) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: ListTile(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StudentDat(
                      name: data.name,
                      age: data.age,
                      number: data.number,
                      email: data.email,
                      image: data.image),
                ));
          },
          leading: CircleAvatar(
            radius: 25,
            backgroundColor: Color.fromARGB(255, 43, 112, 190),
            backgroundImage: FileImage(File(data.image)),
          ),
          title: Text(
            data.name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            data.number,
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditDetails(
                        index: index,
                        name: data.name,
                        age: data.age,
                        number: data.number,
                        email: data.email,
                        image: data.image,
                      ),
                    ),
                  );
                },
                icon: Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () {
                  deleteStudent(index);
                },
                icon: Icon(Icons.delete_rounded),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildStudentList() {
    return ValueListenableBuilder(
      valueListenable: studenlistnotfier,
      builder:
          (BuildContext ctx, List<StudentModel> studentlist, Widget? child) {
        studentList = studentlist;
        filteredStudentList = List.from(studentList);

        return ListView.separated(
          itemBuilder: (ctx, index) {
            final data = studentList[index];
            return buildStudentCard(data, index);
          },
          separatorBuilder: (ctx, index) {
            return const Divider();
          },
          itemCount: studentList.length,
        );
      },
    );
  }
}
