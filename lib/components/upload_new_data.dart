import 'package:clan_churn/utils/spacing.dart';
import 'package:clan_churn/utils/typography.dart';
import 'package:flutter/material.dart';

class UploadNewData extends StatefulWidget {
  const UploadNewData({super.key, required this.onPressed});
  final Function() onPressed;

  @override
  State<UploadNewData> createState() => _UploadNewDataState();
}

class _UploadNewDataState extends State<UploadNewData> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.keyboard_backspace,
                color: Theme.of(context).colorScheme.secondary,
              ),
              onPressed: widget.onPressed,
            ),
            ClanChurnSpacing.w10,
            Text(
              "Upload New Data",
              style: ClanChurnTypography.font18600,
            ),
          ],
        ),
        Expanded(
          child: Center(
            child: Image.asset("assets/upload.png", scale: 2,),
          ),
        ),
      ],
    );
  }
}
