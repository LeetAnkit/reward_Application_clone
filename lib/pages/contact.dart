import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatelessWidget {
  // Function to launch a phone call
  void _launchPhone(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    await launchUrl(launchUri);
  }

  // Function to send an email
  void _launchEmail(String email) async {
    final Uri emailUri = Uri(scheme: 'mailto', path: email);
    await launchUrl(emailUri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Contact Us',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.orange.shade200, Colors.orange.shade400],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Contact Information',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'For any queries or support, please reach out to us:',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 32),
                Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ListTile(
                          title: Text(
                            'Phone:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.orange.shade700,
                            ),
                          ),
                          subtitle: Text(
                            '+91 9907431228',
                            style: TextStyle(color: Colors.orange.shade600),
                          ),
                          trailing: IconButton(
                            icon: Icon(
                              Icons.phone,
                              color: Colors.orange.shade600,
                            ),
                            onPressed: () => _launchPhone('+919907431228'),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'Email:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.orange.shade700,
                            ),
                          ),
                          subtitle: Text(
                            'ankit@example.com',
                            style: TextStyle(color: Colors.orange.shade600),
                          ),
                          trailing: IconButton(
                            icon: Icon(
                              Icons.email,
                              color: Colors.orange.shade600,
                            ),
                            onPressed: () => _launchEmail('ankit@example.com'),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'Address:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.orange.shade700,
                            ),
                          ),
                          subtitle: Text(
                            '1234 Example St, City, Country',
                            style: TextStyle(color: Colors.orange.shade600),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to map or any other action if needed
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.orange.shade600),
                    padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 14)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    )),
                  ),
                  child: Text(
                    'View Location on Map',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
