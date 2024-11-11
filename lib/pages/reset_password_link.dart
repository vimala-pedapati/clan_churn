import 'dart:convert';
import 'dart:developer';

import 'package:clan_churn/components/input_sheet_columns.dart';
import 'package:clan_churn/utils/api_endpoins.dart';
import 'package:clan_churn/utils/typography.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ResetPasswordScreen extends StatefulWidget {
  final String? token;

  const ResetPasswordScreen(this.token, {super.key});

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> with SingleTickerProviderStateMixin {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  final GlobalKey _formKey = GlobalKey<FormState>();
  bool passwordSetSuccessfully = false;
  bool isPasswordUpdating = false;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_validateForm);
    _confirmController.addListener(_validateForm);
  }

  void _validateForm() {
    setState(() {});
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  resetPassword({required String token, required String password}) async {
    setState(() {
      isPasswordUpdating = true;
    });
    final String resetPass = BaseUrl.baseUrl + ApiEndpoints.resetPassword;
    final Map<String, dynamic> requestBody = {"token": token, "password": password};

    try {
      final http.Response response = await http.post(
        Uri.parse(resetPass),
        headers: BaseUrl.headers,
        body: json.encode(requestBody),
      );
      log("reset password response: $response");
      if (response.statusCode == 200) {
        setState(() {
          passwordSetSuccessfully = true;
          _passwordController.text = '';
          _confirmController.text = '';
        });
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Password reset successful!')));

        final Map<String, dynamic> data = json.decode(response.body);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${json.decode(response.body)['detail']}')));

        log('Status Code: ${response.statusCode}');
        if (response.statusCode == 401) {
          log('Unauthorized - Please check your credentials');
        } else if (response.statusCode == 404) {
          log('API endpoint not found');
        } else {
          log('Unexpected Error');
        }
      }
      // return AuthenticationStatus.unauthenticated;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Failed to reset password.')));
      log('Network Error: $e');
    }
    setState(() {
      isPasswordUpdating = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          // gradient: LinearGradient(
          //       colors: [
          //         Theme.of(context).colorScheme.background,
          //         Theme.of(context).colorScheme.primary
          //       ],
          //       begin: const FractionalOffset(0.0, 0.0),
          //       end: const FractionalOffset(1.0, 0.0),
          //       stops: [0,1],
          //       tileMode: TileMode.clamp),
          ),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.4),
        body: Center(
          child: Container(
            // height: MediaQuery.of(context).size.height * 0.45,
            width: MediaQuery.of(context).size.width * 0.3,
            padding: const EdgeInsets.all(30.0),
            decoration: BoxDecoration(color: Theme.of(context).colorScheme.background, borderRadius: BorderRadius.circular(20)),
            child: Form(
              key: _formKey,
              child: passwordSetSuccessfully
                  ? const SuccessfulRestPassword()
                  : Column(
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
                          style: ClanChurnTypography.font12600.copyWith(color: Colors.red),
                        ),
                        Text(
                          "Choose a new one to complete the process",
                          style: ClanChurnTypography.font12600.copyWith(color: Colors.red),
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
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
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
                                    //   color: Theme.of(context).colorScheme.primary,
                                    // ),
                                    ),
                              ),
                              child: Icon(
                                Icons.lock_open,
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
                            focusColor: Theme.of(context).colorScheme.primary,
                            hoverColor: Theme.of(context).colorScheme.primary,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
                            hintText: 'Confirm Password',
                            prefixIcon: Container(
                              margin: const EdgeInsets.only(left: 10.0),
                              padding: const EdgeInsets.all(10.0),
                              child: Icon(
                                Icons.lock_open,
                                color: Theme.of(context).colorScheme.primary,
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
                        isPasswordUpdating
                            ? const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircularProgressIndicator(),
                                ],
                              )
                            : SizedBox(
                                height: 40,
                                width: MediaQuery.of(context).size.width * 0.25,
                                child: ElevatedButton(
                                  onPressed: _confirmController.text.isEmpty || _passwordController.text.isEmpty || _passwordController.text.length < 6 || _confirmController.text.trim() != _passwordController.text.trim()
                                      ? null
                                      : () async {
                                          await resetPassword(token: widget.token ?? "", password: _passwordController.text.trim());
                                        },
                                  style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(1.0)),
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
      ),
    );
  }
}

class SuccessfulRestPassword extends StatelessWidget {
  const SuccessfulRestPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          "assets/churn_logo.png",
          width: MediaQuery.of(context).size.width * 0.07,
        ),
        const SizedBox(
          height: 40,
        ),
        Text(
          "Successfull reset password!",
          style: ClanChurnTypography.font20600.copyWith(color: Colors.green),
        ),
        const SizedBox(
          height: 30,
        ),
        Text(
          "You can now use your new password to login to",
          style: ClanChurnTypography.font15600,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          "your account 🙌",
          style: ClanChurnTypography.font15600,
        ),
        const SizedBox(
          height: 30,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(1.0)),
            child: const Text("Login"),
            onPressed: () {
              launchURL("https://churn.clanonline.in/");
            },
          ),
        )
      ],
    );
  }
}
