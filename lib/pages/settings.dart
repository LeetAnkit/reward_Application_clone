import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings")),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.orange.shade700, Colors.orange.shade300], // Gradient with two shades of orange
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: <Widget>[
              // Title of the page
              Text(
                'Settings menu',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),

              // Instruction with clickable containers
              _buildClickableStep(
                context,
                'Select Uninstall',
                Icons.delete_forever,
                    () => _showDialog(context, 'Uninstall'),
              ),
              _buildClickableStep(
                context,
                'Select Setup',
                Icons.settings,
                    () => _showDialog(context, 'Setup'),
              ),
              _buildClickableStep(
                context,
                'Select your account',
                Icons.account_circle,
                    () => _showDialog(context, 'Select Account'),
              ),
              _buildClickableStep(
                context,
                'Choose an existing Google account or create a new one',
                Icons.account_balance,
                    () => _showDialog(context, 'Google Account'),
              ),
              _buildClickableStep(
                context,
                'Agree to the terms of service',
                Icons.assignment_turned_in,
                    () => _showDialog(context, 'Agree to Terms'),
              ),
              _buildClickableStep(
                context,
                'Verify your identity',
                Icons.security,
                    () => _showDialog(context, 'Verify Identity'),
              ),
              _buildClickableStep(
                context,
                'Enter your first and last names, zip/postal code, and country',
                Icons.person,
                    () => _showDialog(context, 'Enter Details'),
              ),
              _buildClickableStep(
                context,
                'Select your age',
                Icons.calendar_today,
                    () => _showDialog(context, 'Select Age'),
              ),
              _buildClickableStep(
                context,
                'Select a language',
                Icons.language,
                    () => _showDialog(context, 'Select Language'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build clickable steps
  Widget _buildClickableStep(BuildContext context, String text, IconData icon, Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: <Widget>[
            Icon(icon, color: Theme.of(context).primaryColor),
            SizedBox(width: 16),
            Expanded(
              child: Text(
                text,
                style: TextStyle(fontSize: 16),
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ),
    );
  }

  // Method to show a simple dialog on tap
  void _showDialog(BuildContext context, String action) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(action),
          content: Text('You tapped on "$action". Here you can add further details.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
