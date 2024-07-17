import 'package:clan_churn/churn_blocs/project_architect/project_architect_bloc.dart';
import 'package:clan_churn/utils/spacing.dart';
import 'package:clan_churn/utils/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProjectThresholdComponent extends StatefulWidget {
  const ProjectThresholdComponent({super.key, required this.onTap});
  final Function() onTap;

  @override
  State<ProjectThresholdComponent> createState() =>
      _ProjectThresholdComponentState();
}

class _ProjectThresholdComponentState extends State<ProjectThresholdComponent> {
  @override
  void initState() {
    context.read<ProjectArchitectBloc>().add(GetProThresholdValEvent(
          projectId:
              context.read<ProjectArchitectBloc>().state.createdProject!.id,
          onErrorCallback: (errorMessage, errorCode) {},
          onSuccessCallback: (message) {
            print("on success call back for threshold ${message?.body}");
          },
        ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectArchitectBloc, ProjectArchitectState>(
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
                  onPressed: widget.onTap,
                ),
                ClanChurnSpacing.w10,
                Text(
                  "Project Thresholds",
                  style: ClanChurnTypography.font18600,
                ),
              ],
            ),
            Text("${state.projectThesholdFormfields}")
          ],
        );
      },
    );
  }
}
