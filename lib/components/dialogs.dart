import 'package:clan_churn/churn_blocs/project_architect/project_architect_bloc.dart';
import 'package:clan_churn/churn_blocs/user/user_bloc.dart';
import 'package:clan_churn/components/input_sheet_columns.dart';
import 'package:clan_churn/pages/new_project_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetDialog {
  static Future<void> showDownloadDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return BlocBuilder<ProjectArchitectBloc, ProjectArchitectState>(
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
                            // fetching all project list once the project is created
                            context.read<ProjectArchitectBloc>().add(
                                GetProjectsListEvent(
                                    clientId: state.selectedClient!.id));

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

  void showBootomMessage(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red.withOpacity(0.9),
      ),
    );
  }
}
