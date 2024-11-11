import 'dart:convert';
import 'dart:developer';

import 'package:clan_churn/components/input_sheet_columns.dart';
import 'package:clan_churn/utils/api_endpoins.dart';
import 'package:clan_churn/utils/routes.dart';
import 'package:clan_churn/utils/typography.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  bool isMailSent = false;
  bool isMailSending = false;

  final String forgotPass = BaseUrl.baseUrl + ApiEndpoints.forgotPasword;

  Future forgotPassword({required email, required Function(bool) sendingMailHasStarted, required Function(bool) isMailSentSuccessfully}) async {
    final Map<String, dynamic> requestBody = {
      "email": email,
    };
    sendingMailHasStarted(true);
    try {
      final http.Response response = await http.post(
        Uri.parse(forgotPass),
        headers: BaseUrl.headers,
        body: json.encode(requestBody),
      );
      log("forgot password response: $response");
      if (response.statusCode == 200) {
        // final Map<String, dynamic> data = json.decode(response.body);
        isMailSentSuccessfully(true);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Mail sent to your mail id to rest your password')));
      } else {
        isMailSentSuccessfully(false);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Failed to send mail.')));
        log('Status Code: ${response.statusCode}');
        if (response.statusCode == 401) {
          log('Unauthorized - Please check your credentials');
        } else if (response.statusCode == 404) {
          log('API endpoint not found');
        } else {
          log('Unexpected Error');
        }
      }
    } catch (e) {
      log('Network Error: $e');
    }
    sendingMailHasStarted(false);
  }

  @override
  void initState() {
    _emailController.addListener(_validateForm);
    super.initState();
  }

  void _validateForm() {
    setState(() {});
  }

  bool isValidEmail(String email) {
    // Regular expression for validating an email address
    final RegExp emailRegex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+(?:\.[a-zA-Z0-9-]+)*$");
    return emailRegex.hasMatch(email);
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.4),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.3,
          padding: const EdgeInsets.all(30.0),
          decoration: BoxDecoration(color: Theme.of(context).colorScheme.background, borderRadius: BorderRadius.circular(20)),
          child: isMailSent
              ? SentMailSuccessfully(
                  email: _emailController.text,
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Reset your password!",
                      style: ClanChurnTypography.font20600,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Enter your email, and we'll help you reset it in a snap",
                      style: ClanChurnTypography.font15400,
                    ),
                    Text(
                      "Security made simple",
                      style: ClanChurnTypography.font15400,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Email",
                          style: ClanChurnTypography.font14600,
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    // email
                    TextFormField(
                      // obscureText: true,
                      // obscuringCharacter: "⦿",
                      // obscuringCharacter: "♦",
                      controller: _emailController,
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
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                        hintText: 'example@gmail.com',
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
                                //   color: Theme.of(context).colorScheme.primary,
                                // ),
                                ),
                          ),
                          child: Icon(
                            Icons.mail_outline_outlined,
                            color: Theme.of(context).colorScheme.primary,
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
                    const SizedBox(height: 40),
                    // Text("$isMailSent"),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: isMailSending
                          ? const Center(child: CircularProgressIndicator())
                          : ElevatedButton(
                              style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(1.0)),
                              onPressed: (_emailController.text.trim().isEmpty || isMailSent)
                                  ? null
                                  : isValidEmail(_emailController.text.trim()) == false
                                      ? null
                                      : () {
                                          forgotPassword(
                                            email: _emailController.text.trim(),
                                            sendingMailHasStarted: (value) {
                                              setState(() {
                                                isMailSending = value;
                                              });
                                            },
                                            isMailSentSuccessfully: (value) {
                                              print("mail sent successfully $value");
                                              setState(() {
                                                isMailSent = value;
                                              });
                                            },
                                          );
                                        },
                              child: Text(isMailSent ? "Mail sent" : "Continue"),
                            ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class SentMailSuccessfully extends StatelessWidget {
  final String email;
  const SentMailSuccessfully({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 30,
          child: Icon(
            Icons.mail_outline_outlined,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        Text(
          "Check your email",
          style: ClanChurnTypography.font20600,
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          "We have sent password reset link to",
          style: ClanChurnTypography.font15400,
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          email.isEmpty ? "vimalapedapati@tminetwork.com" : email,
          style: ClanChurnTypography.font14400,
        ),
        const SizedBox(
          height: 30,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(1.0)),
            child: const Text("Open email app"),
            onPressed: () {
              launchURL("https://mail.google.com/mail/u/0/#inbox");
            },
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "Didn't receive the email? ",
                style: ClanChurnTypography.font14400,
              ),
              TextSpan(
                text: ' Click to resend',
                style: ClanChurnTypography.font14400.copyWith(color: Theme.of(context).colorScheme.primary),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        InkWell(
          onTap: () {
            GoRouter.of(context).go(AppRoutes.intial);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.arrow_back_outlined),
              Text(
                " Back to login",
                style: ClanChurnTypography.font15600,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
