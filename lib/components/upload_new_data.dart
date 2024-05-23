import 'dart:io';

import 'package:clan_churn/utils/spacing.dart';
import 'package:clan_churn/utils/typography.dart';
import 'package:file_picker/_internal/file_picker_web.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
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
            child: Column(
              children: [
                InkWell(
                    onTap: () async {
                      
                      if (kIsWeb) {
                        var picked = await FilePickerWeb.platform.pickFiles();

                        if (picked != null) {
                          print(picked.files.first.name);
                        }
                      }
                    },
                    child: Image.asset(
                      "assets/upload.png",
                      scale: 2,
                    )),
                // FileUploadButton()
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class FileUploadButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text('UPLOAD FILE'),
      onPressed: () async {
        var picked = await FilePicker.platform.pickFiles();

        if (picked != null) {
          print(picked.files.first.name);
        }
      },
    );
  }
}
