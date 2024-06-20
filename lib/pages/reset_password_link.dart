import 'dart:convert';

import 'package:clan_churn/utils/typography.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ResetPasswordScreen extends StatefulWidget {
  final String? token;

  const ResetPasswordScreen(this.token);

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();
  bool _isLoading = false;
  final GlobalKey _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _passwordController.addListener(_validateForm);
    _confirmController.addListener(_validateForm);
  }

  void _validateForm() {
    setState(() {}); // Trigger rebuild to update button state
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _resetPassword() async {
    setState(() {
      _isLoading = true;
    });

    bool success = await _sendResetPasswordRequest(
        widget.token!, _passwordController.text);

    setState(() {
      _isLoading = false;
    });

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Password reset successful!')));
      Navigator.of(context).pop(); // Navigate back to login screen
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to reset password.')));
    }
  }

  Future<bool> _sendResetPasswordRequest(
      String token, String newPassword) async {
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
      backgroundColor: Theme.of(context).colorScheme.secondary.withOpacity(1.0),
      body: Center(
        child: Container(
          // height: MediaQuery.of(context).size.height * 0.45,
          width: MediaQuery.of(context).size.width * 0.3,
          padding: const EdgeInsets.all(30.0),
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.circular(20)),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  "assets/churn_logo.png",
                  width: MediaQuery.of(context).size.width * 0.07,
                ),
                const SizedBox(height: 40),
                Text(
                  'Set your password',
                  style: ClanChurnTypography.font18600,
                ),
                const SizedBox(height: 15),
                Text(
                  "Your password is reset!",
                  style:
                      ClanChurnTypography.font12600.copyWith(color: Colors.red),
                ),
                Text(
                  "Choose a new one to complete the process",
                  style:
                      ClanChurnTypography.font12600.copyWith(color: Colors.red),
                ),
                // Text("${widget.token}"),
                const SizedBox(height: 15),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Password",
                      style: ClanChurnTypography.font14600,
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                // password
                TextFormField(
                  obscureText: true,
                  // obscuringCharacter: "⦿",
                  obscuringCharacter: "♦",
                  controller: _passwordController,
                  // textAlign: TextAlign.center,
                  textAlignVertical: TextAlignVertical.center,
                  textInputAction: TextInputAction.next,
                  onChanged: (value) {
                    // setState(() {
                    // _passwordController.text = value;
                    // });
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(top: 30),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                    hintText: 'Password',
                    prefixIcon: Container(
                      // width: 36,
                      // height: 36,
                      margin: const EdgeInsets.only(left: 10.0),
                      padding: const EdgeInsets.all(10.0),
                      decoration: const BoxDecoration(
                        // color: Colors.amber,
                        border: Border(
                            // right: BorderSide(
                            //   width: 1.0,
                            //   color: Theme.of(context).colorScheme.secondary,
                            // ),
                            ),
                      ),
                      child: Icon(
                        Icons.lock_open,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),

                    // suffixIcon: Icon(Icons.remove_red_eye_sharp)
                  ),
                  validator: (String? value) {
                    if (value != null) {
                      if (value.length < 8) {
                        return 'Password must be at least 8 characters long.';
                      }
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Confirm Password",
                      style: ClanChurnTypography.font14600,
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                // confirm password
                TextFormField(
                  controller: _confirmController,
                  obscureText: true,
                  obscuringCharacter: "♦",
                  // obscuringCharacter: "⚫",
                  // obscuringCharacter: "•",
                  // obscuringCharacter: "🔒",
                  // obscuringCharacter: "●",
                  // obscuringCharacter: "🤨",
                  // obscuringCharacter: "🙈",
                  onChanged: (value) {
                    // setState(() {
                    // _confirmController.text = value;
                    // });
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    focusColor: Theme.of(context).colorScheme.secondary,
                    hoverColor: Theme.of(context).colorScheme.secondary,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    hintText: 'Confirm Password',
                    prefixIcon: Container(
                      margin: const EdgeInsets.only(left: 10.0),
                      padding: const EdgeInsets.all(10.0),
                      child: Icon(
                        Icons.lock_open,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
                  validator: (String? value) {
                    if (value != null) {
                      if (value.length < 8) {
                        return 'Password must be at least 8 characters long.';
                      }
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 40),

                //  set new password button
                _isLoading
                    ? CircularProgressIndicator(
                        color: Theme.of(context).colorScheme.secondary,
                      )
                    : SizedBox(
                        height: 40,
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: ElevatedButton(
                          onPressed: _confirmController.text.isEmpty ||
                                  _passwordController.text.isEmpty ||
                                  _passwordController.text.length < 6 ||
                                  _confirmController.text.trim() !=
                                      _passwordController.text.trim()
                              ? null
                              : _resetPassword,
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .secondary
                                  .withOpacity(1.0)),
                          child: const Text('Set new password'),
                        ),
                      ),
                // Text("${_confirmController.text} ${_passwordController.text} ${_confirmController.text == _passwordController.text}"),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
