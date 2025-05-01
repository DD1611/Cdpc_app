import 'package:flutter/material.dart';
import 'first.dart';
import 'alumni_page.dart';
import 'schedule_page.dart';
import 'contactus_page.dart';
import 'registration_page.dart';
class DeveloperPage extends StatelessWidget {
  const DeveloperPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.grey[200],
        backgroundColor: Colors.white,
        appBar: AppBar(
        title: const Text(
        "CDPC - KDPIT",
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Title
            // Text(
            //   "CDPC-KDPIT",
            //   style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            //   textAlign: TextAlign.center,
            // ),

            SizedBox(height: 10),

            // Description
            Text(
              "Welcome to the Developers' Corner! We are a passionate team of IT enthusiasts dedicated to crafting this platform for the Career Development and Placement Cell (CDPC). Our goal is to create an intuitive, user-friendly website that serves as a bridge between students and their career aspirations. From seamless navigation to dynamic features, we've strived to ensure this website meets the needs of IT branch students. This project reflects our commitment to innovation, teamwork, and leveraging technology to empower our peers. Thank you for visiting, and we hope this platform helps you achieve your career goals!",
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.justify,
            ),

            SizedBox(height: 20),

            // Developer Cards
            Expanded(
              child: GridView.count(
                crossAxisCount: 2, // Two items per row
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: [
                  _buildDeveloperCard(
                      "Dhruvil Dave", "ID: 22IT018", "assets/profile1.jpeg"),
                  _buildDeveloperCard(
                      "Ankit Aal", "ID: 22IT001", "assets/profile2.jpeg"),
                  // Add more developers here...
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeveloperCard(String name, String id, String imagePath) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.asset(
              imagePath,
              height: 80,
              width: 80,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 10),
          Text(name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text(id, style: TextStyle(fontSize: 14, color: Colors.grey[700])),
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
