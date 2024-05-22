// import 'package:clan_churn/utils/input_field_strings.dart';
// import 'package:clan_churn/utils/typography.dart';
// import 'package:flutter/material.dart';

// class GetFields extends StatefulWidget {
//   const GetFields({super.key});

//   @override
//   State<GetFields> createState() => _GetFieldsState();
// }

// class _GetFieldsState extends State<GetFields> {
//   /// Form Key
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//   // TextEditingControllers
//   final List<TextEditingController> controllers =
//       List.generate(38, (_) => TextEditingController());

//   // FocusNodes
//   final List<FocusNode> focusNodes = List.generate(38, (_) => FocusNode());
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: MediaQuery.of(context).size.height * 0.65,
//       width: MediaQuery.of(context).size.width,
//       // color: Colors.amber,
//       child: SingleChildScrollView(
//         child: Form(
//           key: formKey,
//           child: Column(children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 GetTextFormField(
//                   label: InputFieldLabels.customerName,
//                   controller: controllers[1],
//                   focusNode: focusNodes[0],
//                   nextFocusNode: focusNodes[1],
//                 ),
//                 GetTextFormField(
//                   label: InputFieldLabels.projectName,
//                   controller: controllers[2],
//                   focusNode: focusNodes[1],
//                   nextFocusNode: focusNodes[2],
//                 ),
//               ],
//             ),
//           ]),
//         ),
//       ),
//     );
//   }
// }

// class GetTextFormField extends StatelessWidget {
//   const GetTextFormField({
//     super.key,
//     required this.label,
//     this.textInputAction = TextInputAction.done,
//     required this.controller,
//     required this.focusNode,
//     this.nextFocusNode,
//   });
//   final String label;
//   final TextInputAction textInputAction;
//   final TextEditingController controller;
//   final FocusNode focusNode;
//   final FocusNode? nextFocusNode;

//   @override
//   Widget build(BuildContext context) {
//     // final h = MediaQuery.of(context).size.height;
//     final w = MediaQuery.of(context).size.width;
//     return Column(
//       // mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         InputLabel(
//           label: label,
//         ),
//         Container(
//           width: w * 0.35,
//           height: 40,
//           decoration: BoxDecoration(
//               color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(8.0)),
//           margin: const EdgeInsets.only(top: 5, bottom: 20),
//           child: TextFormField(
//             // controller: clientController,
//             keyboardType: TextInputType.emailAddress,
//             autofocus: false,
//             cursorHeight: 15,

//             textInputAction: textInputAction,
//             // readOnly: true,
//             decoration: InputDecoration(
//               hintText: label,
//               hintStyle: ClanChurnTypography.font12500
//                   .copyWith(color: Theme.of(context).colorScheme.tertiary),
//               contentPadding:
//                   const EdgeInsets.only(top: 10, left: 10, right: 10),
//               border:
//                   OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
//             ),
//             onChanged: (value) {},
//             validator: (String? val) {},
//             onSaved: (String? val) {},
//             onFieldSubmitted: (String? val) {
//               print("onFieldSubmitted");
//               if (nextFocusNode != null) {
//                 FocusScope.of(context).requestFocus(nextFocusNode);
//               }
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
import 'package:clan_churn/utils/typography.dart';
import 'package:flutter/material.dart';

class InputLabel extends StatelessWidget {
  const InputLabel({super.key, required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.35,
      child: Text(
        label,
        style: ClanChurnTypography.font15600,
      ),
    );
  }
}


class SignUpContainer extends StatefulWidget {
  const SignUpContainer({Key? key}) : super(key: key);

  @override
  State<SignUpContainer> createState() => _SignUpContainerState();
}

class _SignUpContainerState extends State<SignUpContainer> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  /// controllers
  final TextEditingController c1 = TextEditingController();
  final TextEditingController c2 = TextEditingController();
  final TextEditingController c3 = TextEditingController();
  final TextEditingController c4 = TextEditingController();
  final TextEditingController c5 = TextEditingController();
  final TextEditingController c6 = TextEditingController();

  @override
  void dispose() {
    c1.clear();
    c2.clear();
    c3.clear();
    c4.clear();
    c6.clear();
    c5.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          /// sign up Form
          Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    
                    Row(
                      children: [
                        CustomTextFormField(
                          controller: c1,
                          textInputType: TextInputType.name,
                          hintText: "hint text",
                          prefixIcon: Icons.person,
                          isObscureText: false,
                          isEnabled: true,
                          textInputAction: TextInputAction.next,
                        ),
                        CustomTextFormField(
                          controller: c1,
                          textInputType: TextInputType.name,
                          hintText: "hint text",
                          prefixIcon: Icons.person,
                          isObscureText: false,
                          isEnabled: true,
                          textInputAction: TextInputAction.next,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
              
                    /// E mail
                    Row(
                      children: [
                        CustomTextFormField(
                          controller: c2,
                          textInputType: TextInputType.emailAddress,
                          hintText: "hint text",
                          prefixIcon: Icons.mail,
                          isObscureText: false,
                          isEnabled: true,
                          textInputAction: TextInputAction.next,
                        ),
                        CustomTextFormField(
                          controller: c2,
                          textInputType: TextInputType.emailAddress,
                          hintText: "hint text",
                          prefixIcon: Icons.mail,
                          isObscureText: false,
                          isEnabled: true,
                          textInputAction: TextInputAction.next,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
              
                    /// Phone Number
                    Row(
                      children: [
                        CustomTextFormField(
                          controller: c3,
                          textInputType: const TextInputType.numberWithOptions(
                              signed: true, decimal: true),
                          hintText: "hint text",
                          prefixIcon: Icons.phone,
                          isObscureText: false,
                          isEnabled: true,
                          textInputAction: TextInputAction.next,
                        ),
                        CustomTextFormField(
                          controller: c3,
                          textInputType: const TextInputType.numberWithOptions(
                              signed: true, decimal: true),
                          hintText: "hint text",
                          prefixIcon: Icons.phone,
                          isObscureText: false,
                          isEnabled: true,
                          textInputAction: TextInputAction.next,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
              
                    /// Password
                    Row(
                      children: [
                        CustomTextFormField(
                          controller: c4,
                          textInputType: TextInputType.visiblePassword,
                          hintText: "hint text",
                          prefixIcon: Icons.lock,
                          isObscureText: true,
                          isEnabled: true,
                          textInputAction: TextInputAction.next,
                        ),
                        CustomTextFormField(
                          controller: c4,
                          textInputType: TextInputType.visiblePassword,
                          hintText: "hint text",
                          prefixIcon: Icons.lock,
                          isObscureText: true,
                          isEnabled: true,
                          textInputAction: TextInputAction.next,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
              
                    /// Confirm Password
                    Row(
                      children: [
                        CustomTextFormField(
                          controller: c6,
                          textInputType: TextInputType.visiblePassword,
                          hintText: "hint text",
                          prefixIcon: Icons.lock,
                          isObscureText: true,
                          isEnabled: true,
                          textInputAction: TextInputAction.done,
                        ),
                        CustomTextFormField(
                          controller: c6,
                          textInputType: TextInputType.visiblePassword,
                          hintText: "hint text",
                          prefixIcon: Icons.lock,
                          isObscureText: true,
                          isEnabled: true,
                          textInputAction: TextInputAction.done,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
              
                    /// Cafe/Restaurant Address
                    Row(
                      children: [
                        CustomTextFormField(
                          controller: c5,
                          hintText: "hint text",
                          prefixIcon: Icons.my_location,
                          isObscureText: false,
                          isEnabled: false,
                          textInputAction: TextInputAction.done,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
              
                    
                    const SizedBox(
                      height: 10,
                    ),
              
                    /// Sign Up Button
              
                    ElevatedButton(
                      onPressed: () {
                        print(c2.text.trim());
                        print(c4.text.trim());
                        print(c3.text.trim());
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.cyan.shade900,
                      ),
                      child: Text(
                        "sign up",
                        style: AppTextStyle.authLoginAndRegister,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {this.controller,
      this.textInputType,
      this.hintText,
      this.prefixIcon,
      required this.isObscureText,
      required this.isEnabled,
      this.textInputAction,
      Key? key})
      : super(key: key);
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final String? hintText;
  final IconData? prefixIcon;
  final bool? isObscureText;
  final bool? isEnabled;
  final TextInputAction? textInputAction;
  @override
  Widget build(BuildContext context) {
    //     // final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Column(
      children: [
               const  InputLabel(
          label: "label",
        ),
        Container(
            width: w * 0.35,
            alignment: Alignment.center,
            padding: const EdgeInsets.fromLTRB(10, 3, 20, 0),
            margin: const EdgeInsets.only(left: 10, right: 10),
            height: 50,
            decoration: BoxDecoration(
                // border: Border.all(color: Colors.black),
                color: Colors.white,
                borderRadius: BorderRadius.circular(100)),
            child: TextField(
              keyboardType: textInputType,
              cursorColor: Colors.grey,
              cursorHeight: 17,
              cursorWidth: 2.5,
              controller: controller,
              obscureText: isObscureText!,
              enabled: isEnabled,
              textInputAction: textInputAction,
              decoration: InputDecoration(
                hintText: "label",
                hintStyle: ClanChurnTypography.font12500
                    .copyWith(color: Theme.of(context).colorScheme.tertiary),
                contentPadding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
              ),
              style: AppTextStyle.textFieldTextStyle,
            )),
      ],
    );
  }
}

class AppTextStyle {
  static TextStyle splashTextStyle = TextStyle(
    fontSize: 50.0,
    fontFamily: FontFamily.signatraFontFamily,
  );
  static TextStyle iFoodTextStyle = TextStyle(
      fontSize: 60,
      color: Colors.white,
      fontFamily: FontFamily.signatraFontFamily);
  static TextStyle authLoginAndRegister = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      fontFamily: FontFamily.signatraFontFamily);
  static TextStyle textFieldHintTextStyle = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.normal,
      color: Colors.grey,
      fontFamily: FontFamily.signatraFontFamily);
  static TextStyle textFieldTextStyle = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.normal,
      color: Colors.black,
      fontFamily: FontFamily.signatraFontFamily);
}

class FontFamily {
  static String signatraFontFamily = 'Signatra';
}
