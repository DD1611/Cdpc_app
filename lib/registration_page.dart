import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'alumni_page.dart';
import 'schedule_page.dart';
import 'contactus_page.dart';
import 'developer_page.dart';
import 'first.dart';
import 'package:intl/intl.dart'; // Add this for date formatting
import 'domain_page.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController idController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  String? enteredID;
  String? enteredName;
  String? selectedDomain;

  final List<String> domains = [
    'AI/ML',
    'Cyber Security',
    'Mobile Application Development',
    'Full stack development',
    'Cloud',
    'Backend',
    'Testing',
    'Data Analytics',
    'Marketing'
  ];

  void saveStudent() async {
    if (enteredID != null && enteredName != null && selectedDomain != null) {
      await _firestore.collection('students').add({
        'id': enteredID,
        'name': enteredName,
        'domain': selectedDomain,
        'createdAt': FieldValue.serverTimestamp(),
      });
      setState(() {
        enteredID = null;
        enteredName = null;
        selectedDomain = null;
      });
      Navigator.pop(context);
    }
  }

  void deleteStudent(String docId) {
    _firestore.collection('students').doc(docId).delete();
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
            Text("Domain: $selectedDomain"),
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
            SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: selectedDomain,
              decoration: InputDecoration(
                labelText: "Select Domain",
                border: OutlineInputBorder(),
              ),
              items: domains.map((String domain) {
                return DropdownMenuItem<String>(
                  value: domain,
                  child: Text(domain),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedDomain = newValue;
                });
              },
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
              if (selectedDomain == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Please select a domain")),
                );
                return;
              }
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case "Home":
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => FirstPage()));
                  break;
                case "Developer":
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => DeveloperPage()));
                  break;
                case "Alumni":
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AlumniPage()));
                  break;
                case "Schedule":
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SchedulePage()));
                  break;
                case "Contact Us":
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ContactPage()));
                  break;
                case "Registration":
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RegistrationPage()));
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "Student Register",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20),

            // Action buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 5),
                    ),
                    child: Text("Add Student Using File"),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DomainPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: Text("Domain"),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: showStudentInput,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: Text("Student"),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Student count with StreamBuilder to get accurate count
            StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('students').snapshots(),
              builder: (context, snapshot) {
                int studentCount = 0;
                if (snapshot.hasData) {
                  studentCount = snapshot.data!.docs.length;
                }
                return Text(
                  "Total Number of Students Register: $studentCount",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                );
              },
            ),
            SizedBox(height: 10),

            // Student table
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('students').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text("Error: ${snapshot.error}"),
                    );
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  var students = snapshot.data!.docs;

                  return Column(
                    children: [
                      // Table header
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                        color: Colors.grey.shade200,
                        child: Row(
                          children: [
                            SizedBox(
                                width: 30,
                                child: Text("#",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold))),
                            Expanded(
                                flex: 2,
                                child: Text("ID",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold))),
                            Expanded(
                                flex: 3,
                                child: Text("Name",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold))),
                            Expanded(
                                flex: 3,
                                child: Text("Domain",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold))),
                            SizedBox(
                                width: 80,
                                child: Text("Action",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold))),
                          ],
                        ),
                      ),

                      // Table body
                      Expanded(
                        child: ListView.builder(
                          itemCount: students.length,
                          itemBuilder: (context, index) {
                            var student = students[index];
                            String docId = student.id;
                            Map<String, dynamic> data =
                                student.data() as Map<String, dynamic>;

                            String studentId = data['id'] ?? 'No ID';
                            String name = data['name'] ?? 'No Name';
                            String domain = data['domain'] ?? 'No Domain';

                            return Container(
                              color:
                                  index % 2 == 0 ? Colors.grey.shade100 : null,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 16),
                                child: Row(
                                  children: [
                                    SizedBox(
                                        width: 30, child: Text("${index + 1}")),
                                    Expanded(flex: 2, child: Text(studentId)),
                                    Expanded(flex: 3, child: Text(name)),
                                    Expanded(flex: 3, child: Text(domain)),
                                    SizedBox(
                                      width: 80,
                                      child: ElevatedButton(
                                        onPressed: () => deleteStudent(docId),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red,
                                          foregroundColor: Colors.white,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 0),
                                          minimumSize: Size(60, 30),
                                        ),
                                        child: Text("Delete",
                                            style: TextStyle(fontSize: 12)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
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
