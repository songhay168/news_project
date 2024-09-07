import 'package:flutter/material.dart';
import 'package:news_project/constan.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Smile Bee News'),
        backgroundColor: Colors.blue, // Blue as the primary color
      ),
      body: Container(
        color: Colors.white, // White background color
        padding: const EdgeInsets.all(16.0),
        child: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: CircleAvatar(
                  backgroundColor: secondaryColor,
                  radius: 50.0,
                  backgroundImage:
                      AssetImage('images/Logo.png'), // Your logo image path
                ),
              ),
              SizedBox(height: 20.0),
              Center(
                child: Text(
                  'Smile Bee News',
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue, // Blue for the title
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'About Us',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue, // Blue for section titles
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'Smile Bee News is your go-to source for the latest news, providing accurate and up-to-date information on various topics around the world. Our mission is to keep you informed with integrity and professionalism.',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black87, // Black text for readability
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'Our Team',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'Smile Bee News was created by a dedicated team of passionate individuals:',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                '• SOK SONGHAY\n'
                '• LY SOPUTHEA\n'
                '• SENG VIRAK',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'Our Vision',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'At Smile Bee News, our vision is to build a platform where people can trust the news they read. We believe in transparency, accountability, and providing a balanced perspective on every story.',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'Contact Us',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'If you have any questions, suggestions, or feedback, feel free to reach out to us at smilebeenews@gmail. We\'d love to hear from you!',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
