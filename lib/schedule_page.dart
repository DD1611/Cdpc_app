import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'alumni_page.dart';
import 'contactus_page.dart';
import 'first.dart';
import 'developer_page.dart';
import 'registration_page.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _notesController = TextEditingController();
  FilePickerResult? _pickerResult;
  String? _selectedFileName;
  bool _isUploading = false;
  bool _showPreview = false;

  void resetState() {
    setState(() {
      _isUploading = false;
      _showPreview = false;
      _pickerResult = null;
      _selectedFileName = null;
      _notesController.clear();
    });
  }

  Future<void> pickPDF() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _pickerResult = result;
        _selectedFileName = result.files.single.name;
        _showPreview = true;
      });
    }
  }

  Future<void> uploadPDF() async {
    if (_pickerResult != null && _pickerResult!.files.isNotEmpty) {
      setState(() {
        _isUploading = true;
      });

      String filePath = _pickerResult!.files.single.path!;
      String fileName = _pickerResult!.files.single.name;

      try {
        await _firestore.collection('schedules').add({
          'name': fileName,
          'path': filePath,
          'notes': _notesController.text,
          'timestamp': Timestamp.now(),
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Schedule uploaded successfully!")),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error uploading schedule: $e")),
        );
      } finally {
        // Reset all state variables
        _isUploading = false;
        _showPreview = false;
        _pickerResult = null;
        _selectedFileName = null;
        _notesController.clear();

        // Force a rebuild of the widget
        if (mounted) {
          setState(() {});
        }
      }
    }
  }

  void cancelUpload() {
    resetState();
  }

  void openPDF(String filePath) {
    OpenFile.open(filePath);
  }

  Future<void> deleteSchedule(String docId) async {
    await _firestore.collection('schedules').doc(docId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Schedule",
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
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _notesController,
                      decoration: InputDecoration(
                        hintText: 'Write your notes...',
                        border: InputBorder.none,
                      ),
                      maxLines: 3,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: ElevatedButton(
                            onPressed: pickPDF,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey.shade200,
                              foregroundColor: Colors.black,
                            ),
                            child: Text(
                              _selectedFileName ?? "Choose Files",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        if (_showPreview) ...[
                          ElevatedButton(
                            onPressed: uploadPDF,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                            ),
                            child: Text(_isUploading ? "Add" : "Add"),
                          ),
                          SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: cancelUpload,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                            ),
                            child: Text("Cancel"),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Schedules",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore
                    .collection('schedules')
                    .orderBy('timestamp', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return Center(child: CircularProgressIndicator());

                  var schedules = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: schedules.length,
                    itemBuilder: (context, index) {
                      var schedule = schedules[index];
                      String fileName = schedule['name'];
                      String docId = schedule.id;
                      Map<String, dynamic> data =
                          schedule.data() as Map<String, dynamic>;

                      String formattedDate = "No date";
                      if (data.containsKey('timestamp') &&
                          data['timestamp'] != null) {
                        try {
                          Timestamp timestamp = data['timestamp'] as Timestamp;
                          DateTime dateTime = timestamp.toDate();
                          formattedDate =
                              DateFormat('dd-MM-yyyy HH:mm').format(dateTime);
                        } catch (e) {
                          formattedDate = "Invalid date";
                        }
                      }

                      return Container(
                        margin: EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    fileName,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  if (data['notes'] != null &&
                                      data['notes'].toString().isNotEmpty)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        data['notes'],
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey.shade700,
                                        ),
                                      ),
                                    ),
                                  SizedBox(height: 4),
                                  Text(
                                    "Posted on: $formattedDate",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.visibility,
                                        color: Colors.blue),
                                    onPressed: () => openPDF(data['path']),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete, color: Colors.red),
                                    onPressed: () => deleteSchedule(docId),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
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
