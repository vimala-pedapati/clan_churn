// Define the input formatters
import 'package:clan_churn/components/cus_text.dart';
import 'package:clan_churn/utils/spacing.dart';
import 'package:clan_churn/utils/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

List<TextInputFormatter> a = <TextInputFormatter>[
  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]')),
];

List<TextInputFormatter> b = <TextInputFormatter>[
  FilteringTextInputFormatter.digitsOnly,
  LengthLimitingTextInputFormatter(20),
];

List<TextInputFormatter> c = <TextInputFormatter>[
  FilteringTextInputFormatter.allow(
      RegExp(r'[a-zA-Z0-9 ]')), // Allowing both digits and letters
];

// Define the enum
enum TextInputFormatterType { string, digitsOnly }

// Function to get the appropriate input formatter list
List<TextInputFormatter> getTextInputFormatterType(
    TextInputFormatterType textInputFormatterType) {
  switch (textInputFormatterType) {
    case TextInputFormatterType.string:
      return a;
    case TextInputFormatterType.digitsOnly:
      return b;
    default:
      return c;
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
      this.label,
      this.textInputFormatterType,
      this.readOnly = false,
      this.suffixIcon,
      this.height = 30,
      this.width = 300,
      this.isMandatory,
      Key? key})
      : super(key: key);
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
  @override
  Widget build(BuildContext context) {
    //     // final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Container(
      // color: Colors.red,
      margin: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CusText(
              text: label ?? "",
              textStyle: ClanChurnTypography.font15900,
              isNotRequired: !(isMandatory ?? true)),
          ClanChurnSpacing.h6,
          // Expanded(child: Container(),),
          Container(
              width: width,
              alignment: Alignment.center,
              height: height,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),

                  // border: Border.all(color: Colors.black),
                  // color: Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              child: TextField(
                keyboardType: textInputType,
                cursorColor: Colors.grey,
                cursorHeight: 17,
                cursorWidth: 2.5,
                controller: controller,
                obscureText: isObscureText!,
                enabled: isEnabled,
                readOnly: readOnly,
                textInputAction: textInputAction,
                style: ClanChurnTypography.font13500,
                inputFormatters: getTextInputFormatterType(
                    textInputFormatterType ??
                        TextInputFormatterType.digitsOnly),
                decoration: InputDecoration(
                  hintText: hintText ?? label,
                  suffixIcon: suffixIcon,
                  hintStyle: ClanChurnTypography.font13500
                      .copyWith(color: Theme.of(context).colorScheme.tertiary),
                  contentPadding:
                      const EdgeInsets.only(top: 10, left: 10, right: 10),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                ),
              )),
        ],
      ),
    );
  }
}
