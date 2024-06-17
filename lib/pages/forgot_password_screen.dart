import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;

  void _sendPasswordResetEmail() async {
    setState(() {
      _isLoading = true;
    });

    // Assume _sendResetRequest is a function that sends the request to your backend
    bool success = await _sendResetRequest(_emailController.text);
    
    setState(() {
      _isLoading = false;
    });

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Password reset email sent!'))
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to send password reset email.'))
      );
    }
  }

  Future<bool> _sendResetRequest(String email) async {
    // Send request to backend
    // Use an HTTP client like http or dio package
    try {
      final response = await http.post(
        Uri.parse('https://your-backend.com/api/forgot-password'),
        body: json.encode({'email': email}),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Forgot Password')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _sendPasswordResetEmail,
                    child: Text('Send Reset Email'),
                  ),
          ],
        ),
      ),
    );
  }
}
