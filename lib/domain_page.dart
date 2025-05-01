import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DomainPage extends StatefulWidget {
  const DomainPage({super.key});

  @override
  _DomainPageState createState() => _DomainPageState();
}

class _DomainPageState extends State<DomainPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
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

  void deleteStudent(String docId) {
    _firestore.collection('students').doc(docId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Domain-wise Students",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Domain selection dropdown
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(4),
              ),
              child: DropdownButton<String>(
                value: selectedDomain,
                hint: Text("Select Domain"),
                isExpanded: true,
                underline: SizedBox(),
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
            ),
            SizedBox(height: 20),

            // Student count
            StreamBuilder<QuerySnapshot>(
              stream: selectedDomain != null
                  ? _firestore
                      .collection('students')
                      .where('domain', isEqualTo: selectedDomain)
                      .snapshots()
                  : _firestore.collection('students').snapshots(),
              builder: (context, snapshot) {
                int studentCount = 0;
                if (snapshot.hasData) {
                  studentCount = snapshot.data!.docs.length;
                }
                return Text(
                  "Total Students: $studentCount",
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
                stream: selectedDomain != null
                    ? _firestore
                        .collection('students')
                        .where('domain', isEqualTo: selectedDomain)
                        .snapshots()
                    : _firestore.collection('students').snapshots(),
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
