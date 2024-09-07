import 'package:flutter/material.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms and Conditions'),
        backgroundColor: Colors.blue, // Blue color for the app bar
      ),
      body: Container(
        color: Colors.white, // White background
        padding: const EdgeInsets.all(16.0),
        child: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Introduction',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue, // Blue color for the section title
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'Welcome to Smile Bee News (the "App"). By accessing or using the App, you agree to be bound by these Terms and Conditions (the "Terms"). Please read them carefully before using the App.',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black87, // Dark text color for readability
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'Use of the App',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'You must be at least 13 years old to use this App. By using the App, you represent and warrant that you meet this age requirement.',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'To access certain features of the App, you may be required to create an account. You agree to provide accurate and complete information when creating your account and to update your information as necessary.',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'You agree not to use the App for any unlawful or prohibited activities, including but not limited to:',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                '• Harassing, threatening, or abusing others.\n'
                '• Posting or transmitting any content that is illegal, harmful, defamatory, or otherwise objectionable.\n'
                '• Infringing on the intellectual property rights of others.\n'
                '• Disrupting the operation of the App or its servers.',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'Intellectual Property',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'All content, including but not limited to text, images, graphics, logos, and software, available on the App is the property of Smile Bee News or its licensors and is protected by copyright, trademark, and other intellectual property laws.',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'You are granted a limited, non-exclusive, non-transferable license to access and use the App for personal, non-commercial purposes. You may not modify, reproduce, distribute, or create derivative works based on the content of the App without the express written consent of Smile Bee News.',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'If you submit content to the App, such as comments or articles, you grant Smile Bee News a perpetual, worldwide, royalty-free, and non-exclusive license to use, reproduce, modify, and distribute your content in any media.',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'Privacy Policy',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'Your use of the App is also governed by our Privacy Policy, which can be found [here]. Please review the Privacy Policy to understand how we collect, use, and protect your personal information.',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'Disclaimers and Limitation of Liability',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'The content provided on the App is for informational purposes only. While we strive for accuracy, Smile Bee News does not warrant that the information provided is complete, accurate, or up-to-date.',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'The App is provided "as is" and "as available" without any warranties of any kind, either express or implied. Smile Bee News disclaims all warranties, including but not limited to the implied warranties of merchantability, fitness for a particular purpose, and non-infringement.',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'To the maximum extent permitted by law, Smile Bee News shall not be liable for any direct, indirect, incidental, consequential, or punitive damages arising out of your use of or inability to use the App.',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'Changes to the Terms',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'Smile Bee News reserves the right to modify these Terms at any time. Any changes will be effective immediately upon posting. Your continued use of the App after any changes constitutes your acceptance of the new Terms.',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'Governing Law',
                style: const TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'These Terms are governed by and construed in accordance with the laws of [Your Jurisdiction]. Any disputes arising from these Terms or your use of the App shall be resolved in the courts of [Your Jurisdiction].',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'Contact Information',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'If you have any questions or concerns about these Terms, please contact us at smilebeenews@gmail.com.',
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
