import 'package:clan_churn/churn_blocs/user/user_bloc.dart';
import 'package:clan_churn/pages/new_project_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetDialog {
  static Future<void> showDownloadDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            return AlertDialog(
              title: Text(state.projectCreating
                  ? "Preparing for download..."
                  : "Ready to Download "),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.download_for_offline, size: 148.0),
                  const SizedBox(height: 20.0),
                  state.projectCreating
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: () {
                            context.read<UserBloc>().add(GetProjectsListEvent(clientId: state.selectedClient!.id));
                            // String a =
                            //     "https://s3.ap-south-1.amazonaws.com/clan-profile-pictures/ppa/663f3d3e2b20003da5b870f6/6644af6c0fd060a1f4ae6c00/2024_05_15_12_49_55/Project%2023_input_sheet.xlsx?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIASHKMDVP4QE7LHSWY%2F20240515%2Fap-south-1%2Fs3%2Faws4_request&X-Amz-Date=20240515T124955Z&X-Amz-Expires=18600&X-Amz-SignedHeaders=host&X-Amz-Signature=be09559485335c919b4e3a2f14602c5143f3fa1d110e72054be510805db55fd7";
                            // downloadFile(a, context);
                            launchURL(state.createdProject!.inputSheet!);
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          child: const Text('Download'),
                        ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  static Future<void> uploadFile(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            return AlertDialog(
              content: SizedBox(
                width: 400,
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/upload.gif",
                      scale: 5,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  static Future<void> failedErrorReport(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            return AlertDialog(
              title: const Text("Something went wrong"),
              content: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Failed to prepare error report to download"),
                ],
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('ok'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
