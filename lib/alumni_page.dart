import 'package:flutter/material.dart';
import 'first.dart';
import 'developer_page.dart';
import 'schedule_page.dart';
import 'contactus_page.dart';
import 'registration_page.dart';

class AlumniPage extends StatefulWidget {
  @override
  _AlumniPageState createState() => _AlumniPageState();
}

class _AlumniPageState extends State<AlumniPage> {
  final PageController _pageController = PageController(viewportFraction: 0.8);
  double _currentPage = 0.0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Alumni",
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          Text(
            "Our Alumni",
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: alumniList.length,
              itemBuilder: (context, index) {
                return _buildAnimatedCard(index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedCard(int index) {
    double scale = (_currentPage - index).abs().clamp(0.0, 1.0);
    double scaleFactor = 1 - (scale * 0.2);

    return AnimatedBuilder(
      animation: _pageController,
      builder: (context, child) {
        return Transform.scale(
          scale: scaleFactor,
          child: child,
        );
      },
      child: _buildAlumniCard(
        alumniList[index]['name']!,
        alumniList[index]['year']!,
        alumniList[index]['position']!,
      ),
    );
  }

  Widget _buildAlumniCard(String name, String year, String position) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 5,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Text("Class of $year", style: TextStyle(fontSize: 16, color: Colors.grey[700])),
            SizedBox(height: 5),
            Text(position, style: TextStyle(fontSize: 16, color: Colors.black)),
          ],
        ),
      ),
    );
  }
}

// Dummy Alumni Data
List<Map<String, String>> alumniList = [
  {"name": "John Doe", "year": "2018", "position": "Software Engineer at Google"},
  {"name": "Jane Smith", "year": "2020", "position": "Data Scientist at Facebook"},
  {"name": "Alice Johnson", "year": "2015", "position": "CEO at StartupX"},
  {"name": "Robert Brown", "year": "2019", "position": "Product Manager at Amazon"},
  {"name": "Emily Davis", "year": "2016", "position": "UI/UX Designer at Microsoft"},
];
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