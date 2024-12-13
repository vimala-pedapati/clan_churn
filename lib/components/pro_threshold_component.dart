import 'package:clan_churn/api_repos/api_repo.dart';
import 'package:clan_churn/api_repos/models/get_pro_threshold_val_model.dart';
import 'package:clan_churn/churn_blocs/project_architect/project_architect_bloc.dart';
import 'package:clan_churn/components/churn_continer.dart';
import 'package:clan_churn/components/pro_threshold_template_component.dart';
import 'package:clan_churn/utils/spacing.dart';
import 'package:clan_churn/utils/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../api_repos/models/update_threshold_val_model.dart';
import '../utils/routes.dart';

class ProjectThresholdComponent extends StatefulWidget {
  const ProjectThresholdComponent({super.key, required this.clientId, required this.projectId});
  final String clientId;
  final String projectId;

  @override
  State<ProjectThresholdComponent> createState() => _ProjectThresholdComponentState();
}

class _ProjectThresholdComponentState extends State<ProjectThresholdComponent> {
  @override
  void initState() {
    context.read<ProjectArchitectBloc>().add(GetProThresholdValEvent(
          projectId: context.read<ProjectArchitectBloc>().state.createdProject!.id,
          onErrorCallback: (errorMessage, errorCode) {},
          onSuccessCallback: (message) {},
        ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectArchitectBloc, ProjectArchitectState>(
      builder: (context, state) {
        return ChurnContainer(
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.keyboard_backspace,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    onPressed: () {
                      context.pop();
                    },
                  ),
                  ClanChurnSpacing.w10,
                  BlocBuilder<ProjectArchitectBloc, ProjectArchitectState>(
                    builder: (context, state) {
                      return Text(
                        "Project Thresholds",
                        style: ClanChurnTypography.font18600,
                      );
                    },
                  ),
                ],
              ),
              Expanded(
                child: state.projectThresholdFormFieldsLoading
                    ? const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                        ],
                      )
                    : ListView.builder(
                        itemCount: state.projectThesholdFormfields.length,
                        itemBuilder: (context, index) {
                          return TheresholdComponent(
                            thresholdFormVal: state.projectThesholdFormfields[index],
                          );
                        },
                      ),
              ),
              // Text("${state.projectThesholdFormfields}"),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: state.projectThresholdFormFieldsLoading || state.projectThesholdFormfields.any((field) => field.minValue == null || field.maxValue == null)
                        ? null
                        : () {
                            List<UpdateThresholdValModel> data = [];
                            for (var i in state.projectThesholdFormfields) {
                              if (i.maxValue != null && i.minValue != null && columnDataTypeValues.reverse[i.columnDataType] != null) {
                                data.add(UpdateThresholdValModel(
                                  columnId: i.id,
                                  columnType: columnDataTypeValues.reverse[i.columnDataType]!,
                                  minValue: i.minValue,
                                  maxValue: i.maxValue,
                                ));
                              }
                            }
                            context.read<ProjectArchitectBloc>().add(UpdateProThrValsEvent(
                                  projectId: state.createdProject!.id,
                                  data: data,
                                  onErrorCallback: (errorMessage, errorCode) {
                                    ApiRepository().handleWarningMessage(errorMessage, context);
                                  },
                                  onSuccessCallback: (message) {
                                    // ApiRepository().handleSuccessMessage("successfully updated threshold values!.....", context);

                                    if (state.createdProject?.latestInput == null || state.uploadNewSheetRequested) {
                                      context.push("${AppRoutes.client}/${state.selectedClient?.name}/${widget.clientId}/${state.createdProject?.name}/${widget.projectId}/${AppRoutes.uploadNewSheet}");
                                    } else {
                                      context.push("${AppRoutes.client}/${state.selectedClient?.name}/${widget.clientId}/${state.createdProject?.name}/${widget.projectId}/${AppRoutes.projectSummaryReport}");
                                    }
                                  },
                                ));
                          },
                    child: const Text("Next"),
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
