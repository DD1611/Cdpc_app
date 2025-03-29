import 'package:flutter/material.dart';
import 'alumni_page.dart';
import 'schedule_page.dart';
import 'first.dart';
import 'developer_page.dart';
import 'registration_page.dart';

class ContactPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
        title: const Text(
        "Contact",
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
      body: Center(
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          margin: EdgeInsets.all(20),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Contact Info Section
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Contact Us",
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Feel free to reach out to us with your inquiries, feedback, or concerns. Our team is here to assist you with any questions you may have.",
                        style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                      ),
                      SizedBox(height: 10),
                      Text("📧 Email: contact@example.com", style: TextStyle(fontSize: 16)),
                      SizedBox(height: 5),
                      Text("📞 Phone: +1 (555) 555-5555", style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
                // Placeholder for Image or Map
                SizedBox(width: 20),
                Container(
                  width: 150,
                  height: 150,
                  color: Colors.grey[300], // Placeholder
                  child: Icon(Icons.image, size: 50, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
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
