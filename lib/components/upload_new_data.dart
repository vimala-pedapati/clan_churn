import 'dart:io';

import 'package:clan_churn/churn_blocs/user/user_bloc.dart';
import 'package:clan_churn/utils/spacing.dart';
import 'package:clan_churn/utils/typography.dart';
import 'package:file_picker/_internal/file_picker_web.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
            child: InkWell(
                onTap: () async {
                  if (kIsWeb) {
                    FilePickerResult? picked =
                        await FilePickerWeb.platform.pickFiles(
                      type: FileType.custom,
                      allowedExtensions: ['xls', 'xlsx'],
                    );

                    if (picked != null) {
                      // print(picked.files.first.name);
                      // print(picked.files.first);
                      print(picked.paths);
                      context.read<UserBloc>().add(UploadFileEvent(
                          filePickerResult: picked,
                          projectId: context
                              .read<UserBloc>()
                              .state
                              .createdProject!
                              .id));
                    }
                  }
                },
                child: Image.asset(
                  "assets/upload.png",
                  scale: 2,
                )),
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
