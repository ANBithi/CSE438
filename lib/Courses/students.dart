import 'package:flutter/material.dart'; // Import the Student model

class StudentsPage extends StatelessWidget {
  final dynamic students;

  StudentsPage({required this.students});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Students'),
      ),
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          dynamic student =
              students[index]; // Get the student at the current index
          return ListTile(
            leading: Icon(Icons
                .account_circle), // Display an icon or image for the student
            title: Text(student["name"]), // Display the name of the student
            subtitle:
                Text(student["studentId"]), // Display the email of the student
          );
        },
      ),
    );
  }
}

class Student {
  final String name;
  final String email;

  Student({required this.name, required this.email});
}
