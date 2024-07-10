
import 'package:clan_churn/utils/typography.dart';
import 'package:flutter/material.dart';

class CusText extends StatelessWidget {
  const CusText({
    super.key,
    required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text.rich(TextSpan(children: [
      TextSpan(
        text: text,
        style: ClanChurnTypography.font18500,
      ),
      TextSpan(
        text: " *",
        style: ClanChurnTypography.font22600.copyWith(
            color: Theme.of(context).colorScheme.error,
            fontWeight: FontWeight.w400),
      ),
    ]));
  }
}

