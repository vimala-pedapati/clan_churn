// // Define the input formatters
// import 'package:clan_churn/components/cus_text.dart';
// import 'package:clan_churn/utils/spacing.dart';
// import 'package:clan_churn/utils/typography.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// List<TextInputFormatter> a = <TextInputFormatter>[
//   FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]')),
// ];

// List<TextInputFormatter> b = <TextInputFormatter>[
//   FilteringTextInputFormatter.digitsOnly,
//   LengthLimitingTextInputFormatter(20),
// ];

// List<TextInputFormatter> c = <TextInputFormatter>[
//   FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9 ]')), // Allowing both digits and letters
// ];

// // Define the enum
// enum TextInputFormatterType { string, digitsOnly }

// // Function to get the appropriate input formatter list
// List<TextInputFormatter> getTextInputFormatterType(TextInputFormatterType textInputFormatterType) {
//   switch (textInputFormatterType) {
//     case TextInputFormatterType.string:
//       return a;
//     case TextInputFormatterType.digitsOnly:
//       return b;
//     default:
//       return c;
//   }
// }

// class CustomTextFormField extends StatelessWidget {
//   const CustomTextFormField({this.controller, this.textInputType, this.hintText, this.prefixIcon, required this.isObscureText, required this.isEnabled, this.textInputAction, this.label, this.textInputFormatterType, this.readOnly = false, this.suffixIcon, this.height = 30, this.width = 300, this.isMandatory, Key? key}) : super(key: key);
//   final TextEditingController? controller;
//   final TextInputType? textInputType;
//   final String? hintText;
//   final IconData? prefixIcon;
//   final bool? isObscureText;
//   final bool? isEnabled;
//   final TextInputAction? textInputAction;
//   final String? label;
//   final TextInputFormatterType? textInputFormatterType;
//   final bool readOnly;
//   final Widget? suffixIcon;
//   final double? height;
//   final double? width;
//   final bool? isMandatory;
//   @override
//   Widget build(BuildContext context) {
//     //     // final h = MediaQuery.of(context).size.height;
//     final w = MediaQuery.of(context).size.width;
//     return Container(
//       // color: Colors.red,
//       margin: const EdgeInsets.only(bottom: 15),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           CusText(text: label ?? "", textStyle: ClanChurnTypography.font14900, isNotRequired: !(isMandatory ?? true)),
//           ClanChurnSpacing.h6,
//           // Expanded(child: Container(),),
//           Container(
//               width: width,
//               alignment: Alignment.center,
//               height: height,
//               decoration: BoxDecoration(
//                   color: Theme.of(context).colorScheme.primary.withOpacity(0.1),

//                   // border: Border.all(color: Colors.black),
//                   // color: Colors.white,
//                   borderRadius: BorderRadius.circular(10)),
//               child: TextField(
//                 keyboardType: textInputType,
//                 cursorColor: Colors.grey,
//                 cursorHeight: 17,
//                 cursorWidth: 2.5,
//                 controller: controller,
//                 obscureText: isObscureText!,
//                 enabled: isEnabled,
//                 readOnly: readOnly,
//                 textInputAction: textInputAction,
//                 style: ClanChurnTypography.font13500,
//                 inputFormatters: getTextInputFormatterType(textInputFormatterType ?? TextInputFormatterType.digitsOnly),
//                 decoration: InputDecoration(
//                   hintText: hintText ?? label,
//                   suffixIcon: suffixIcon,
//                   hintStyle: ClanChurnTypography.font13500.copyWith(color: Theme.of(context).colorScheme.tertiary),
//                   contentPadding: const EdgeInsets.only(top: 10, left: 10, right: 10),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8.0),
//                   ),
//                 ),
//               )),
//         ],
//       ),
//     );
//   }
// }

import 'package:clan_churn/components/cus_text.dart';
import 'package:clan_churn/utils/spacing.dart';
import 'package:clan_churn/utils/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    this.controller,
    this.textInputType,
    this.hintText,
    this.prefixIcon,
    required this.isObscureText,
    required this.isEnabled,
    this.textInputAction,
    this.label,
    this.textInputFormatterType,
    this.readOnly = false,
    this.suffixIcon,
    this.height = 30,
    this.width = 300,
    this.isMandatory,
    this.onDeletePressed,
    Key? key,
  }) : super(key: key);

  final TextEditingController? controller;
  final TextInputType? textInputType;
  final String? hintText;
  final IconData? prefixIcon;
  final bool? isObscureText;
  final bool? isEnabled;
  final TextInputAction? textInputAction;
  final String? label;
  final TextInputFormatterType? textInputFormatterType;
  final bool readOnly;
  final Widget? suffixIcon;
  final double? height;
  final double? width;
  final bool? isMandatory;
  final VoidCallback? onDeletePressed;

  CustomTextFormField copyWith({
    TextEditingController? controller,
    TextInputType? textInputType,
    String? hintText,
    IconData? prefixIcon,
    bool? isObscureText,
    bool? isEnabled,
    TextInputAction? textInputAction,
    String? label,
    TextInputFormatterType? textInputFormatterType,
    bool? readOnly,
    Widget? suffixIcon,
    double? height,
    double? width,
    bool? isMandatory,
    VoidCallback? onDeletePressed,
  }) {
    return CustomTextFormField(
      controller: controller ?? this.controller,
      textInputType: textInputType ?? this.textInputType,
      hintText: hintText ?? this.hintText,
      prefixIcon: prefixIcon ?? this.prefixIcon,
      isObscureText: isObscureText ?? this.isObscureText,
      isEnabled: isEnabled ?? this.isEnabled,
      textInputAction: textInputAction ?? this.textInputAction,
      label: label ?? this.label,
      textInputFormatterType: textInputFormatterType ?? this.textInputFormatterType,
      readOnly: readOnly ?? this.readOnly,
      suffixIcon: suffixIcon ?? this.suffixIcon,
      height: height ?? this.height,
      width: width ?? this.width,
      isMandatory: isMandatory ?? this.isMandatory,
      onDeletePressed: onDeletePressed ?? this.onDeletePressed,
    );
  }

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CusText(
                  text: widget.label ?? "",
                  textStyle: ClanChurnTypography.font14900,
                  isNotRequired: !(widget.isMandatory ?? true),
                ),
                ClanChurnSpacing.h6,
                Container(
                  width: widget.width,
                  alignment: Alignment.center,
                  height: widget.height,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    keyboardType: widget.textInputType,
                    cursorColor: Colors.grey,
                    cursorHeight: 17,
                    cursorWidth: 2.5,
                    controller: widget.controller,
                    obscureText: widget.isObscureText!,
                    enabled: widget.isEnabled,
                    readOnly: widget.readOnly,
                    textInputAction: widget.textInputAction,
                    style: ClanChurnTypography.font13500,
                    inputFormatters: getTextInputFormatterType(
                      widget.textInputFormatterType ?? TextInputFormatterType.digitsOnly,
                    ),
                    decoration: InputDecoration(
                      hintText: widget.hintText ?? widget.label,
                      suffixIcon: widget.suffixIcon,
                      hintStyle: ClanChurnTypography.font13500.copyWith(
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                      contentPadding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (_isHovered && widget.onDeletePressed != null)
            Positioned(
              top: 0,
              right: 0,
              child: MouseRegion(
                onEnter: (_) => setState(() => _isHovered = true),
                onExit: (_) => setState(() => _isHovered = false),
                child: GestureDetector(
                  onTap: widget.onDeletePressed,
                  child: const Icon(
                    Icons.delete,
                    color: Colors.red,
                    size: 20,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// Define the input formatters and enums as before
List<TextInputFormatter> a = <TextInputFormatter>[
  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]')),
];

List<TextInputFormatter> b = <TextInputFormatter>[
  FilteringTextInputFormatter.digitsOnly,
  LengthLimitingTextInputFormatter(20),
];

List<TextInputFormatter> c = <TextInputFormatter>[
  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9 ]')),
];

enum TextInputFormatterType { string, digitsOnly }

List<TextInputFormatter> getTextInputFormatterType(TextInputFormatterType textInputFormatterType) {
  switch (textInputFormatterType) {
    case TextInputFormatterType.string:
      return a;
    case TextInputFormatterType.digitsOnly:
      return b;
    default:
      return c;
  }
}
