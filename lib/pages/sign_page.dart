import 'package:clan_churn/api_repos/auth_repo.dart';
import 'package:clan_churn/churn_blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:clan_churn/utils/routes.dart';
import 'package:clan_churn/utils/spacing.dart';
import 'package:clan_churn/utils/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../main.dart';

class ClanChurnSignInPage extends StatelessWidget {
  const ClanChurnSignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    final shadowColor = Theme.of(context).colorScheme.shadow;
    final background = Theme.of(context).colorScheme.background;
    final secondary2 = Theme.of(context).colorScheme.onSecondary;
    return ResponsiveBuilder(builder: (context, sizingInformation) {
      Widget a = Image.asset(
        "assets/sign_in.png",
        scale: 3,
      );
      Widget b = Center(
        child: IntrinsicWidth(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(""),
              IntrinsicHeight(
                child: Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/clan_logo.png",
                        scale: 2,
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
                        scale: 2,
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: h * 0.05, bottom: h * 0.05),
                child: Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "welcome",
                        style: ClanChurnTypography.font48400,
                      ),
                    ],
                  ),
                ),
              ),
              BlocBuilder<SignInBloc, SignInBlocState>(
                builder: (context, state) {
                  return Text("${state.status}");
                },
              ),
              Text(
                "Login ID",
                style: ClanChurnTypography.font18500,
              ),
              Container(
                width: w * 0.3,
                height: h * 0.05,
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(56, 56, 56, 0.1),
                    borderRadius: BorderRadius.circular(8.0)),
                margin: const EdgeInsets.only(top: 5, bottom: 20),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  autofocus: false,
                  decoration: InputDecoration(
                    hintText: 'Enter Login ID',
                    hintStyle: ClanChurnTypography.font18500
                        .copyWith(color: secondary2),
                    contentPadding:
                        const EdgeInsets.only(top: 10, left: 10, right: 10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                  ),
                  validator: (String? val) {
                    return null;
                  },
                  onSaved: (String? val) {},
                ),
              ),
              Text(
                "Password",
                style: ClanChurnTypography.font18500,
              ),
              Container(
                width: w * 0.3,
                height: h * 0.05,
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(56, 56, 56, 0.1),
                    borderRadius: BorderRadius.circular(8.0)),
                margin: const EdgeInsets.only(top: 5, bottom: 25),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  autofocus: false,
                  decoration: InputDecoration(
                    hintText: 'Enter Password',
                    hintStyle: ClanChurnTypography.font18500
                        .copyWith(color: secondary2),
                    contentPadding:
                        const EdgeInsets.only(top: 10, left: 10, right: 10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                  ),
                  validator: (String? val) {
                    return null;
                  },
                  onSaved: (String? val) {},
                ),
              ),
              SizedBox(
                  width: w * 0.3,
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<SignInBloc>().add(SignInEvent(email: "test2@tminetwork.com", password: "123456", context: context));
                    },
                    child: Text(
                      "Submit",
                      style: ClanChurnTypography.font18600,
                    ),
                  )),
              ClanChurnSpacing.h20,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Forgot Password?",
                    style: ClanChurnTypography.font18500,
                  ),
                ],
              ),
            ],
          ),
        ),
      );

      return Scaffold(
        body: Center(
          child: Container(
            height: h * 0.8,
            width: w * 0.9,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      color: shadowColor,
                      blurRadius: 5,
                      spreadRadius: 2,
                      offset: const Offset(0, 2))
                ],
                color: background),
            child: sizingInformation.deviceScreenType == DeviceScreenType.mobile
                ? SingleChildScrollView(
                    child: Column(
                      children: [a, b],
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [a, b]),
          ),
        ),
      );
    });
  }
}
