import 'dart:developer';

import 'package:clan_churn/animation/show_up_animation/enums.dart';
import 'package:clan_churn/animation/show_up_animation/show_up.dart';
import 'package:clan_churn/churn_blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:clan_churn/utils/device_types.dart';
import 'package:clan_churn/utils/routes.dart';
import 'package:clan_churn/utils/spacing.dart';
import 'package:clan_churn/utils/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ClanChurnSignInPage extends StatefulWidget {
  const ClanChurnSignInPage({super.key});

  @override
  State<ClanChurnSignInPage> createState() => _ClanChurnSignInPageState();
}

class _ClanChurnSignInPageState extends State<ClanChurnSignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String email = '';
  String password = '';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isHovered = false;
  bool isPasswordVisible = false;
  void _onHover(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
    });
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    final shadowColor = Theme.of(context).colorScheme.shadow;
    final background = Theme.of(context).colorScheme.background;
    final secondary2 = Theme.of(context).colorScheme.onSecondary;

    return ResponsiveBuilder(builder: (context, sizingInformation) {
      Widget a = Container(
        // color: Colors.amber,
        child: ShowUpAnimation(
          delayStart: const Duration(seconds: 0),
          animationDuration: const Duration(seconds: 2),
          curve: Curves.easeInOutCubicEmphasized,
          direction: Direction.horizontal,
          offset: -0.9,
          child: Image.asset(
            "assets/sign_in.png",
            width: SignInRespUi.respValSignImage(context),
            // scale: 3,
          ),
        ),
      );
      Widget b = Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction, //
        child: Center(
          child: FittedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text("${MediaQuery.of(context).size}"),
                // logo
                ShowUpAnimation(
                  delayStart: const Duration(seconds: 0),
                  animationDuration: const Duration(seconds: 2),
                  curve: Curves.easeInOutCubicEmphasized,
                  direction: Direction.horizontal,
                  offset: 0.9,
                  child: Container(
                    width: w * 0.3,
                    child: IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/clan_logo.png",
                            width: SignInRespUi.respValSignImageLogo(context),
                            // scale: 1.5,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: VerticalDivider(
                              color: Color.fromRGBO(175, 175, 175, 1),
                              thickness: 1,
                            ),
                          ),
                          Image.asset(
                            "assets/churn_logo.png",
                            // scale: 1.5,
                            width: SignInRespUi.respValSignImageLogo(context),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                // welcome
                ShowUpAnimation(
                  delayStart: const Duration(milliseconds: 500),
                  animationDuration: const Duration(seconds: 2),
                  curve: Curves.easeInOutCubicEmphasized,
                  direction: Direction.horizontal,
                  offset: 0.9,
                  child: Container(
                    width: w * 0.3,
                    padding: EdgeInsets.only(top: h * 0.05, bottom: h * 0.05),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Welcome",
                          style: ClanChurnTypography.font48400,
                        ),
                      ],
                    ),
                  ),
                ),
                // email text
                ShowUpAnimation(
                  delayStart: const Duration(milliseconds: 1000),
                  animationDuration: const Duration(seconds: 2),
                  curve: Curves.easeInOutCubicEmphasized,
                  direction: Direction.horizontal,
                  offset: 0.9,
                  child: Text(
                    "Login ID",
                    style: ClanChurnTypography.font18500.copyWith(
                        fontSize: SignInRespUi.respSignFont(context, 18)),
                  ),
                ),
                // email input field
                ShowUpAnimation(
                  delayStart: const Duration(milliseconds: 1000),
                  animationDuration: const Duration(seconds: 2),
                  curve: Curves.easeInOutCubicEmphasized,
                  direction: Direction.horizontal,
                  offset: 0.9,
                  child: Container(
                    width: w * 0.3,
                    // height: h * 0.05,
                    decoration: BoxDecoration(
                        // color: const Color.fromRGBO(56, 56, 56, 0.1),
                        borderRadius: BorderRadius.circular(8.0)),
                    margin: const EdgeInsets.only(top: 5, bottom: 20),
                    child: TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      autofocus: false,
                      textInputAction: TextInputAction.next,
                      style: ClanChurnTypography.font18500.copyWith(
                          fontSize: SignInRespUi.respSignFont(context, 18)),
                      decoration: InputDecoration(
                        hintText: 'Enter Login ID',
                        hintStyle: ClanChurnTypography.font18500
                            .copyWith(color: secondary2),
                        contentPadding:
                            const EdgeInsets.only(top: 10, left: 10, right: 10),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                      ),
                      onChanged: (value) {
                        setState(() {
                          email = value;
                        });
                      },
                      validator: (String? val) {
                        // if (val == null || val.isEmpty) {
                        //   return 'Please enter an email';
                        // }
                        // if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                        //     .hasMatch(val)) {
                        //   return 'Please enter a valid email';
                        // }
                        // return null;
                      },
                      onSaved: (String? val) {},
                    ),
                  ),
                ),
                // password text
                ShowUpAnimation(
                  delayStart: const Duration(milliseconds: 1500),
                  animationDuration: const Duration(seconds: 2),
                  curve: Curves.easeInOutCubicEmphasized,
                  direction: Direction.horizontal,
                  offset: 0.9,
                  child: Text(
                    "Password",
                    style: ClanChurnTypography.font18500.copyWith(
                        fontSize: SignInRespUi.respSignFont(context, 18)),
                  ),
                ),
                // password input field
                // ShowUpAnimation(
                //   delayStart: const Duration(milliseconds: 1500),
                //   animationDuration: const Duration(seconds: 2),
                //   curve: Curves.easeInOutCubicEmphasized,
                //   direction: Direction.horizontal,
                //   offset: 0.9,
                //   child: Container(
                //     width: w * 0.3,
                //     // height: h * 0.05,
                //     decoration: BoxDecoration(
                //         // color: const Color.fromRGBO(56, 56, 56, 0.1),
                //         borderRadius: BorderRadius.circular(8.0)),
                //     margin: const EdgeInsets.only(top: 5, bottom: 25),
                //     child: TextFormField(
                //       controller: passwordController,
                //       keyboardType: TextInputType.emailAddress,
                //       autofocus: false,
                //       obscureText: true,
                //       textInputAction: TextInputAction.next,
                //       obscuringCharacter: '*',
                //       style: ClanChurnTypography.font18500.copyWith(
                //           fontSize: SignInRespUi.respSignFont(context, 18)),
                //       decoration: InputDecoration(
                //         hintText: 'Enter Password',
                //         hintStyle: ClanChurnTypography.font18500
                //             .copyWith(color: secondary2),
                //         contentPadding:
                //             const EdgeInsets.only(top: 10, left: 10, right: 10),
                //         errorBorder: OutlineInputBorder(
                //             gapPadding: 0,
                //             borderRadius: BorderRadius.circular(8.0)),
                //         border: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(8.0)),
                //       ),
                //       onChanged: (value) {
                //         setState(() {
                //           password = value;
                //         });
                //       },
                //       validator: (String? val) {
                //         // if (val == null || val.isEmpty) {
                //         //   return "Password shouldn't be empty";
                //         // }
                //         // return null;
                //       },
                //       onSaved: (String? val) {
                //         // You can add functionality here if needed
                //       },
                //     ),
                //   ),
                // ),
                ShowUpAnimation(
                  delayStart: const Duration(milliseconds: 1500),
                  animationDuration: const Duration(seconds: 2),
                  curve: Curves.easeInOutCubicEmphasized,
                  direction: Direction.horizontal,
                  offset: 0.9,
                  child: Container(
                    width: w * 0.3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    margin: const EdgeInsets.only(top: 5, bottom: 25),
                    child: TextFormField(
                      controller: passwordController,
                      keyboardType: TextInputType.text,
                      autofocus: false,
                      obscureText: !isPasswordVisible, // Toggle visibility
                      textInputAction: TextInputAction.next,
                      obscuringCharacter: '*',
                      style: ClanChurnTypography.font18500.copyWith(
                        fontSize: SignInRespUi.respSignFont(context, 18),
                      ),
                      decoration: InputDecoration(
                        hintText: 'Enter Password',
                        hintStyle: ClanChurnTypography.font18500
                            .copyWith(color: secondary2),
                        contentPadding:
                            const EdgeInsets.only(top: 10, left: 10, right: 10),
                        errorBorder: OutlineInputBorder(
                          gapPadding: 0,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              isPasswordVisible = !isPasswordVisible;
                            });
                          },
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          password = value;
                        });
                      },
                      validator: (String? val) {
                        // You can add validation logic here
                      },
                      onSaved: (String? val) {
                        // You can add save functionality here if needed
                      },
                    ),
                  ),
                ),

                // submit
                ShowUpAnimation(
                  delayStart: const Duration(milliseconds: 2000),
                  animationDuration: const Duration(seconds: 2),
                  curve: Curves.easeInOutCubicEmphasized,
                  direction: Direction.horizontal,
                  offset: 0.9,
                  child: SizedBox(
                      width: w * 0.3,
                      height: 50,
                      child: MouseRegion(
                        onEnter: (_) => _onHover(true),
                        onExit: (_) => _onHover(false),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    _isHovered ? 30.0 : 8.0),
                              ),
                            ),
                          ),
                          onPressed: () {
                            //  email
                            //       if (val == null || val.isEmpty) {
                            //   return 'Please enter an email';
                            // }
                            // if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                            //     .hasMatch(val)) {
                            //   return 'Please enter a valid email';
                            // }

                            // return null;
                            // password
                            //   if (val == null || val.isEmpty) {
                            //   return "Password shouldn't be empty";
                            // }
                            // return null;
                            if (_formKey.currentState!.validate()) {
                              log("$email, $password");
                              context.read<SignInBloc>().add(SignInEvent(
                                  email: email,
                                  password: password,
                                  context: context));
                            }
                          },
                          child: Text(
                            "Submit",
                            style: ClanChurnTypography.font18600.copyWith(
                                fontSize:
                                    SignInRespUi.respSignFont(context, 18)),
                          ),
                        ),
                      )),
                ),
                ClanChurnSpacing.h20,
                ShowUpAnimation(
                  delayStart: const Duration(milliseconds: 2500),
                  animationDuration: const Duration(seconds: 2),
                  curve: Curves.easeInOutCubicEmphasized,
                  direction: Direction.horizontal,
                  offset: 0.9,
                  child: SizedBox(
                    width: w * 0.3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            GoRouter.of(context).go(AppRoutes.forgotPassword);
                          },
                          child: Text("Forgot Password?",
                              style: ClanChurnTypography.font18500.copyWith(
                                  fontSize:
                                      SignInRespUi.respSignFont(context, 18),
                                  color:
                                      Theme.of(context).colorScheme.primary)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
      return Scaffold(
        body: Center(
          child: ShowUpAnimation(
            delayStart: const Duration(milliseconds: 0),
            animationDuration: const Duration(seconds: 2),
            curve: Curves.easeInOutCubicEmphasized,
            direction: Direction.vertical,
            offset: -0.9,
            child: Container(
              height: h * 0.78,
              width: w * 0.8,
              padding: EdgeInsets.only(
                  left: SignInRespUi().respValSignPadding(context, 0.05),
                  right: SignInRespUi().respValSignPadding(context, 0.05),
                  top: SignInRespUi().respValSignPadding(context, 0.05),
                  bottom: SignInRespUi().respValSignPadding(context, 0.05)),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: shadowColor,
                        blurRadius: 5,
                        spreadRadius: 2,
                        offset: const Offset(0, 2))
                  ],
                  // color: Colors.cyan,
                  color: background),
              child:
                  sizingInformation.deviceScreenType == DeviceScreenType.mobile
                      ? SingleChildScrollView(
                          child: Column(
                            children: [a, b],
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [a, ClanChurnSpacing.w70, b]),
            ),
          ),
        ),
      );
    });
  }
}
