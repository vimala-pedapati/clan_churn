import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class ResetPasswordScreen extends StatefulWidget {
  final String? token;

  ResetPasswordScreen(this.token);

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _isLoading = false;

  void _resetPassword() async {
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match'))
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    bool success = await _sendResetPasswordRequest(widget.token!, _passwordController.text);

    setState(() {
      _isLoading = false;
    });

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
       const SnackBar(content: Text('Password reset successful!'))
      );
      Navigator.of(context).pop(); // Navigate back to login screen
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to reset password.'))
      );
    }
  }

  Future<bool> _sendResetPasswordRequest(String token, String newPassword) async {
    // Send request to backend
    try {
      final response = await http.post(
        Uri.parse('https://your-backend.com/api/reset-password'),
        body: json.encode({'token': token, 'newPassword': newPassword}),
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
      appBar: AppBar(title: const Text('Reset Password')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text("${widget.token}"),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'New Password'),
              obscureText: true,
            ),
            TextField(
              controller: _confirmPasswordController,
              decoration: const InputDecoration(labelText: 'Confirm Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _resetPassword,
                    child: const Text('Reset Password'),
                  ),
          ],
        ),
      ),
    );
  }
}
