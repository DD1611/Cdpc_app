import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'alumni_page.dart';
import 'schedule_page.dart';
import 'contactus_page.dart';
import 'developer_page.dart';
import 'first.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController idController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  String? enteredID;
  String? enteredName;

  void saveStudent() async {
    if (enteredID != null && enteredName != null) {
      await _firestore.collection('students').add({
        'id': enteredID,
        'name': enteredName,
      });
      setState(() {
        enteredID = null;
        enteredName = null;
      });
      Navigator.pop(context);
    }
  }

  void deleteStudent(String docId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Delete Student"),
        content: Text("Are you sure you want to delete this student?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              _firestore.collection('students').doc(docId).delete();
              Navigator.pop(context);
            },
            child: Text("Delete"),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          ),
        ],
      ),
    );
  }

  void showConfirmDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Confirm Student Details"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("ID: $enteredID"),
            Text("Name: $enteredName"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              saveStudent();
              Navigator.pop(context);
            },
            child: Text("Confirm & Save"),
          ),
        ],
      ),
    );
  }

  void showStudentInput() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Enter Student Details"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: idController,
              decoration: InputDecoration(labelText: "Student ID"),
            ),
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: "Student Name"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                enteredID = idController.text;
                enteredName = nameController.text;
              });
              idController.clear();
              nameController.clear();
              Navigator.pop(context);
              showConfirmDialog();
            },
            child: Text("Next"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Registration",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case "Home":
                  Navigator.push(context, MaterialPageRoute(builder: (context) => FirstPage()));
                  break;
                case "Developer":
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DeveloperPage()));
                  break;
                case "Alumni":
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AlumniPage()));
                  break;
                case "Schedule":
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SchedulePage()));
                  break;
                case "Contact Us":
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ContactPage()));
                  break;
                case "Registration":
                  Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationPage()));
                  break;
              }
            },
            icon: const Icon(Icons.more_vert, color: Colors.black),
            itemBuilder: (BuildContext context) => [
              menuItem("Home", Icons.home),
              menuItem("Developer", Icons.code),
              menuItem("Alumni", Icons.people),
              menuItem("Schedule", Icons.calendar_today),
              menuItem("Contact Us", Icons.contact_mail),
              menuItem("Registration", Icons.app_registration),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: _firestore.collection('students').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

                var students = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: students.length,
                  itemBuilder: (context, index) {
                    var student = students[index];
                    String docId = student.id; // Firestore document ID

                    return ListTile(
                      title: Text(student['name']),
                      subtitle: Text("ID: ${student['id']}"),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => deleteStudent(docId),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: showStudentInput,
              child: Text("Add Student"),
            ),
          ),
        ],
      ),
    );
  }
}

PopupMenuItem<String> menuItem(String title, IconData icon) {
  return PopupMenuItem(
    value: title,
    child: Row(
      children: [
        Icon(icon, color: Colors.black54),
        const SizedBox(width: 10),
        Text(title),
      ],
    ),
  );
}
