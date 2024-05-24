import 'dart:io';

import 'package:clan_churn/churn_blocs/user/user_bloc.dart';
import 'package:clan_churn/components/dialogs.dart';
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
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
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
                SelectableText(
                  "Upload New Data ${state.createdProject!.latestInput}",
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
                          // ignore: use_build_context_synchronously
                          context.read<UserBloc>().add(UploadFileEvent(
                              filePickerResult: picked,
                              context: context,
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
      },
    );
  }
}
