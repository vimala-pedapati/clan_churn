import 'package:clan_churn/utils/typography.dart';
import 'package:flutter/material.dart';

class CusText extends StatelessWidget {
  const CusText(
      {super.key,
      required this.text,
      this.isNotRequired = false,
      this.textStyle});
  final String text;
  final bool isNotRequired;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Text.rich(TextSpan(children: [
      TextSpan(
        text: text,
        style: textStyle ?? ClanChurnTypography.font18500,
      ),
      TextSpan(
        text: isNotRequired ? "" : " *",
        style: (textStyle ?? ClanChurnTypography.font22600).copyWith(
            color: Theme.of(context).colorScheme.error,
            fontWeight: FontWeight.w400),
      ),
    ]));
  }
}
