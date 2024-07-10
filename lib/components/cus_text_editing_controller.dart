import 'package:clan_churn/utils/typography.dart';
import 'package:flutter/material.dart';

OutlineInputBorder border(BuildContext context) => OutlineInputBorder(
    borderSide: BorderSide(
        width: 1.5,
        color: Theme.of(context).colorScheme.primary.withOpacity(0.6)));

class CusTextEditingController extends StatelessWidget {
  const CusTextEditingController(
      {super.key,
      this.width,
      required this.hintText,
      required this.controller,
      required this.onChanged,
      required this.textInputAction});
  final double? width;
  final String hintText;
  final TextEditingController controller;
  final Function(String) onChanged;
  final TextInputAction textInputAction;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 40,
        width: width ?? 400,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
            borderRadius: BorderRadius.circular(08)),
        margin: const EdgeInsets.only(right: 20, top: 10, bottom: 10),
        child: TextFormField(
          controller: controller, // Use the passed controller here
          textInputAction: textInputAction,
          onChanged: onChanged,
          decoration: InputDecoration(
              hintText: hintText,
              hintStyle: ClanChurnTypography.font18500.copyWith(
                  color: Theme.of(context)
                      .colorScheme
                      .onSecondary
                      .withOpacity(0.8)),
              contentPadding: const EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              enabledBorder: border(context),
              focusedBorder: border(context),
              border: border(context)),
        ));
  }
}
