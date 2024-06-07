import 'package:clan_churn/utils/spacing.dart';
import 'package:clan_churn/utils/typography.dart';
import 'package:flutter/material.dart';

class GetPublishButton extends StatefulWidget {
  const GetPublishButton({super.key});

  @override
  State<GetPublishButton> createState() => _GetPublishButtonState();
}

class _GetPublishButtonState extends State<GetPublishButton> {
  bool value = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Checkbox(
              value: value,
              onChanged: (bool? v) {
                setState(() {
                  if (v != null) {
                    value = v;
                  }
                });
              },
            ),
            Text(
              "I confirm the data is correct",
              style: ClanChurnTypography.font18500,
            ),
          ],
        ),
        ClanChurnSpacing.h20,
        Row(
          children: [
            SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: value ? () {} : null,
                child: Row(
                  children: [
                    Text(
                      "Publish",
                      style: ClanChurnTypography.font18600,
                    ),
                    ClanChurnSpacing.w10,
                    const Icon(Icons.arrow_circle_right_outlined),
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}

