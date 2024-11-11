import 'package:clan_churn/utils/typography.dart';
import 'package:flutter/material.dart';

OutlineInputBorder border(BuildContext context, {Color? color}) => OutlineInputBorder(
        borderSide: BorderSide(
      width: 1.5,
      color: color ?? Theme.of(context).colorScheme.primary.withOpacity(0.6),
    ));

class CusTextEditingController extends StatelessWidget {
  const CusTextEditingController({
    super.key,
    this.width,
    required this.hintText,
    required this.controller,
    required this.onChanged,
    required this.textInputAction,
    this.isEnabled = true,
    this.isObacureText = false,
    this.errorText,
  });
  final double? width;
  final String hintText;
  final TextEditingController controller;
  final Function(String) onChanged;
  final TextInputAction textInputAction;
  final bool isEnabled;
  final bool isObacureText;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            // height: 40,
            width: width ?? 400,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
              borderRadius: BorderRadius.circular(08),
            ),
            margin: const EdgeInsets.only(right: 20, top: 10, bottom: 10),
            child: TextFormField(
              controller: controller, // Use the passed controller here
              textInputAction: textInputAction,
              onChanged: onChanged,
              enabled: isEnabled,
              obscureText: isObacureText,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: ClanChurnTypography.font18500.copyWith(
                  color: Theme.of(context).colorScheme.onSecondary.withOpacity(isObacureText ? 1.0 : 0.8),
                ),
                contentPadding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                ),
                enabledBorder: border(
                  context,
                  color: errorText == null ? null : Theme.of(context).colorScheme.error,
                ),
                focusedBorder: border(
                  context,
                  color: errorText == null ? null : Theme.of(context).colorScheme.error,
                ),
                border: border(context),
              ),
            )),
        SizedBox(
          width: width ?? 400,
          child: Text(
            errorText ?? "",
            overflow: TextOverflow.ellipsis,
            style: ClanChurnTypography.font12600.copyWith(color: Theme.of(context).colorScheme.error, fontWeight: FontWeight.normal),
          ),
        )
      ],
    );
  }
}
