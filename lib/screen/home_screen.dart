import 'dart:io';
import 'package:flutter/material.dart';
import 'package:student_register/function/db_function.dart';
import 'package:student_register/model/data_model.dart';
import 'package:student_register/screen/add_details.dart';
import 'package:student_register/screen/edit_screen.dart';
import 'package:student_register/screen/student_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  List<StudentModel> studentList = [];
  List<StudentModel> filterStudentList = [];
  bool isSearching = false;
  @override
  void initState() {
    // Call getAllStudent() only once in the initState

    super.initState();
    getAllStudent();
  }

  void filterStudents(String search) {
    if (search.isEmpty) {
      // If the search query is empty, show all students.
      setState(() {
        filterStudentList = List.from(studentList);
      });
    } else {
      setState(() {
        filterStudentList = studentList
            .where((student) =>
                student.name.toLowerCase().contains(search.toLowerCase()))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    getAllStudent();
    return Scaffold(
      // backgroundColor: Color.fromARGB(255, 33, 68, 51),
      appBar: AppBar(
        backgroundColor: Colors.blue,
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
                  filterStudentList = List.from(studentList);
                }
              });
            },
            icon: Icon(isSearching ? Icons.cancel : Icons.search),
          ),
        ],
      ),
      body: Center(
        child: isSearching
            ? filterStudentList.isNotEmpty
                ? ListView.separated(
                    itemBuilder: (context, index) {
                      final data = filterStudentList[index];
                      return buildStudentTile(data, index);
                    },
                    separatorBuilder: (context, index) {
                      return Divider();
                    },
                    itemCount: filterStudentList.length)
                : Center(child: Text("No results found"))
            : buildStudentList(),
      ),

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

  Widget buildStudentList() {
    return ValueListenableBuilder(
        valueListenable: studentListNotifier,
        builder:
            (BuildContext ctx, List<StudentModel> studentlist, Widget? child) {
          studentList = studentlist;
          filterStudentList = List.from(studentList);
          return ListView.separated(
            separatorBuilder: (context, index) => Divider(),
            itemBuilder: (context, index) {
              final data = studentList[index];
              return buildStudentTile(data, index);
            },
            itemCount: studentList.length,
          );
        });
  }

  Widget buildStudentTile(StudentModel data, int index) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Color.fromARGB(255, 43, 112, 190),
        backgroundImage: FileImage(File(data.image)),
      ),
      onTap: () {
        print('Data button clicked');
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => StudentData(
                  name: data.name,
                  age: data.age,
                  number: data.phone,
                  email: data.email),
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
                        image: data.image,
                        index: index),
                  ));
            },
          ),
        ],
      ),
    );
  }
}
