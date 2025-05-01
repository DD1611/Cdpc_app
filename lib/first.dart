import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Import this package
import 'developer_page.dart';
import 'alumni_page.dart';
import 'schedule_page.dart';
import 'contactus_page.dart';
import 'registration_page.dart';
class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "CDPC Home",
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  const Text(
                    "Career Development and Placement Cell (CDPC)",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "Empowering students with skills and opportunities to achieve their career aspirations.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "CDPC Activities",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                  const SizedBox(height: 10),
                  activityBulletPoint("One-to-one guidance to each student to help them achieve their desired career."),
                  activityBulletPoint("Free training to improve soft skills, technical skills, and personality as per the industry requirements through expert workshops."),
                  activityBulletPoint("Feedback to each student via mock campus placement tests, including online tests, group discussions, and personal interviews."),
                  activityBulletPoint("Conducting seminar series on career prospects in the industry, public sector, government (including defense), and self-employment."),
                  activityBulletPoint("Executing campus placements and job fairs by inviting all industrial sectors for students."),
                  activityBulletPoint("Guidance regarding the requirements and procedures for higher studies in India and abroad via the Higher Studies Help Desk."),
                  activityBulletPoint("Encouraging students by providing resources to participate and clear various national and international projects and technical competitions."),
                  activityBulletPoint("Providing guidance to prepare for national and international competitive exams."),
                  activityBulletPoint("Supporting student start-ups through the Entrepreneurship and Development Cell."),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              height: 200,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/placement.jpeg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Contact Information",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),            ),
            const SizedBox(height: 10),

            // Contact Cards (Stacked)
            contactCard(
              "Dr. Ashwin Makwana",
              "Head, CDPC",
              "ashwinmakwana.ce@charusat.ac.in",
              "+91-2697-265214",
              Colors.blue,
            ),
            const SizedBox(height: 10),
            contactCard(
              "Mr. Sujal Dadhaniya",
              "TPO, CDPC",
              "tnp@charusat.ac.in",
              "+91-2697-265213 | +91-9662255116",
              Colors.green,
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "About Us",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Welcome to our Training and Placement Cell. Here, we prepare students for bright futures by connecting them with top recruiters and providing industry-relevant training.",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            facultySection(),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              height: 400,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/major.jpeg"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget activityBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.circle, size: 8, color: Colors.black),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget contactCard(String name, String role, String email, String phone, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 8), // Ensure vertical stacking
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: color,
            child: Text(
              name[0],
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(role, style: const TextStyle(fontSize: 14, color: Colors.grey)),
                const SizedBox(height: 4),
                GestureDetector(
                  onTap: () => launchEmail(email),
                  child: Text(
                    email,
                    style: const TextStyle(fontSize: 14, color: Colors.blue, decoration: TextDecoration.underline),
                  ),
                ),
                Text(phone, style: const TextStyle(fontSize: 14)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void launchEmail(String email) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    } else {
      throw 'Could not launch email';
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
}
Widget facultySection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(height: 20),
      const Text(
        "Faculty Members",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
      ),
      const SizedBox(height: 10),
      facultyCard("Dr. Sanket Suthar", "Training Coordinator", "assets/sanket_suthar.png"),
      const SizedBox(height: 10),
      facultyCard("Dr. Ashwin Makwana", "Placement Officer", "assets/ashwin_makwana.png"),
      const SizedBox(height: 10),
      facultyCard("Dr. Priyanka Patel", "Career Counselor", "assets/priyanka_patel.png"),
    ],
  );
}

Widget facultyCard(String name, String role, String imagePath) {
  return Container(
    padding: const EdgeInsets.all(16),
    margin: const EdgeInsets.symmetric(vertical: 8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          spreadRadius: 2,
          blurRadius: 5,
        ),
      ],
    ),
    child: Row(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: AssetImage(imagePath),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(role, style: const TextStyle(fontSize: 14, color: Colors.grey)),
            ],
          ),
        ),
      ],
    ),
  );
}