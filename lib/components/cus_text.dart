import 'package:clan_churn/utils/typography.dart';
import 'package:flutter/material.dart';

class CusText extends StatelessWidget {
  const CusText({super.key, required this.text, this.isNotRequired = false});
  final String text;
  final bool isNotRequired;

  @override
  Widget build(BuildContext context) {
    return Text.rich(TextSpan(children: [
      TextSpan(
        text: text,
        style: ClanChurnTypography.font18500,
      ),
      TextSpan(
        text: isNotRequired ? "" : " *",
        style: ClanChurnTypography.font22600.copyWith(
            color: Theme.of(context).colorScheme.error,
            fontWeight: FontWeight.w400),
      ),
    ]));
  }
}

class CusTextForPC extends StatelessWidget {
  const CusTextForPC(
      {super.key, required this.text, this.isNotRequired = false});
  final String text;
  final bool isNotRequired;

  @override
  Widget build(BuildContext context) {
    return Text.rich(TextSpan(children: [
      TextSpan(
        text: text,
        style: ClanChurnTypography.font15900,
      ),
      TextSpan(
        text: isNotRequired ? "" : "  *",
        style: ClanChurnTypography.font12600.copyWith(color: Colors.red),
      ),
    ]));
  }
}
