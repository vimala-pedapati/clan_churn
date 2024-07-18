import 'package:clan_churn/api_repos/models/get_pro_threshold_val_model.dart';
import 'package:clan_churn/churn_blocs/project_architect/project_architect_bloc.dart';
import 'package:clan_churn/components/cus_text_editing_controller.dart';
import 'package:clan_churn/utils/spacing.dart';
import 'package:clan_churn/utils/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProjectThresholdComponent extends StatefulWidget {
  const ProjectThresholdComponent(
      {super.key, required this.onBackTap, required this.onNextTap});
  final Function() onBackTap;
  final Function() onNextTap;

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
            // print("on success call back for threshold ${message?.body}");
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
                  onPressed: widget.onBackTap,
                ),
                ClanChurnSpacing.w10,
                Text(
                  "Project Thresholds",
                  style: ClanChurnTypography.font18600,
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: state.projectThesholdFormfields.length,
                itemBuilder: (context, index) {
                  return TheresholdComponent(
                      thresholdFormVal: state.projectThesholdFormfields[index]);
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: widget.onNextTap,
                  child: const Text("Next"),
                )
              ],
            )
          ],
        );
      },
    );
  }
}

class TheresholdComponent extends StatelessWidget {
  const TheresholdComponent({super.key, required this.thresholdFormVal});
  final GetProThresholdFormValModel thresholdFormVal;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          thresholdFormVal.columnName,
          style: ClanChurnTypography.font16700,
        ),
        Expanded(
          child: Container(),
        ),
        Row(
          children: [
            Text(
              "min: ",
              style: ClanChurnTypography.font16700,
            ),
            CusThresholdFomField(
              thresholdFormVal: thresholdFormVal,
            )
          ],
        ),
        Row(
          children: [
            Text(
              "max: ",
              style: ClanChurnTypography.font16700,
            ),
            CusThresholdFomField(
              thresholdFormVal: thresholdFormVal,
            )
          ],
        ),
      ],
    );
  }
}

class CusThresholdFomField extends StatelessWidget {
  CusThresholdFomField(
      {super.key,
      required this.thresholdFormVal,
      this.textInputAction,
      this.onChanged,
      this.isEnabled});
  final GetProThresholdFormValModel thresholdFormVal;
  final TextEditingController controller = TextEditingController();
  final TextInputAction? textInputAction;
  final Function(String)? onChanged;
  final bool? isEnabled;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 35,
        width: 150,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
            borderRadius: BorderRadius.circular(08)),
        margin: const EdgeInsets.only(right: 20, top: 10, bottom: 10),
        child: TextFormField(
          controller: controller, // Use the passed controller here
          textInputAction: textInputAction,
          onChanged: onChanged,
          enabled: isEnabled,
          decoration: InputDecoration(
              hintText: "0",
              hintStyle: ClanChurnTypography.font18500.copyWith(
                  color: Theme.of(context)
                      .colorScheme
                      .onSecondary
                      .withOpacity(0.8)),
              contentPadding: const EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              enabledBorder: border(context),
              focusedBorder: border(context),
              border: border(context)),
        ));
  }
}
