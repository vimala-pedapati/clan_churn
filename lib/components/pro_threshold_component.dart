import 'dart:convert';

import 'package:clan_churn/api_repos/api_repo.dart';
import 'package:clan_churn/api_repos/models/get_pro_threshold_val_model.dart';
import 'package:clan_churn/api_repos/models/project_model.dart';
import 'package:clan_churn/api_repos/models/threshold_val_model.dart';
import 'package:clan_churn/api_repos/models/update_threshold_val_model.dart';
import 'package:clan_churn/churn_blocs/project_architect/project_architect_bloc.dart';
import 'package:clan_churn/components/cus_text_editing_controller.dart';
import 'package:clan_churn/utils/spacing.dart';
import 'package:clan_churn/utils/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProjectThresholdComponent extends StatefulWidget {
  const ProjectThresholdComponent({super.key, required this.onBackTap, required this.onNextTap});
  final Function() onBackTap;
  final Function() onNextTap;

  @override
  State<ProjectThresholdComponent> createState() => _ProjectThresholdComponentState();
}

class _ProjectThresholdComponentState extends State<ProjectThresholdComponent> {
  List<String> ids = [];
  List<String> columnTypes = [];
  List<int?> minValues = [];
  List<int?> maxValues = [];

  void addId(String id, String colType) {
    Project pro = context.read<ProjectArchitectBloc>().state.createdProject!;
    ProjectDetails? proDetails = pro.projectDetails;

    List<ProThreModel> threVals = proDetails?.thresholdVals ?? [];

    // Initialize the values to add to the lists
    int? minValue;
    int? maxValue;

    if (threVals.isNotEmpty) {
      List<ProThreModel> a = threVals
          .where(
            (element) => element.columnId == id,
          )
          .toList();

      if (a.isNotEmpty) {
        minValue = a[0].minValue;
        maxValue = a[0].maxValue;
      }
    }

    ids.add(id);
    columnTypes.add(colType);
    minValues.add(minValue);
    maxValues.add(maxValue);
  }

  void addMinValue(String id, String minValue) {
    minValues[ids.indexOf(id)] = int.parse(minValue);
  }

  void addMaxValue(String id, String maxValue) {
    maxValues[ids.indexOf(id)] = int.parse(maxValue);
  }

  @override
  void initState() {
    context.read<ProjectArchitectBloc>().add(GetProThresholdValEvent(
          projectId: context.read<ProjectArchitectBloc>().state.createdProject!.id,
          onErrorCallback: (errorMessage, errorCode) {},
          onSuccessCallback: (message) {
            if (message != null) {
              List<dynamic> data = json.decode(message.body) as List<dynamic>;
              for (int i = 0; i < data.length; i++) {
                // setState(() {
                addId(data[i]['id'], data[i]['column_data_type']);
                // });
              }
            }
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
                          minValue: (minValue) {
                            addMinValue(state.projectThesholdFormfields[index].id, minValue);
                          },
                          maxValue: (maxValue) {
                            addMaxValue(state.projectThesholdFormfields[index].id, maxValue);
                          },
                        );
                      },
                    ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: state.projectThresholdFormFieldsLoading
                      ? null
                      : () {
                          if (minValues.contains(null) || maxValues.contains(null)) {
                            ApiRepository().handleWarningMessage("All fileds are mandatary to fill ", context);
                          } else {
                            List<UpdateThresholdValModel> data = [];
                            for (int i = 0; i < ids.length; i++) {
                              // print( "$i)${ids[i]}: min:${minValues[i]} max:${maxValues[i]}");
                              data.add(UpdateThresholdValModel(columnId: ids[i], columnType: columnTypes[i], minValue: minValues[i]!, maxValue: maxValues[i]!));
                            }
                            print(data);
                            context.read<ProjectArchitectBloc>().add(UpdateProThrValsEvent(
                                  projectId: state.createdProject!.id,
                                  data: data,
                                  onErrorCallback: (errorMessage, errorCode) {
                                    ApiRepository().handleWarningMessage(errorMessage, context);
                                  },
                                  onSuccessCallback: (message) {
                                    // print(message?.body);
                                    ApiRepository().handleSuccessMessage("successfully updated threshold values!.....", context);
                                    widget.onNextTap();
                                  },
                                ));
                          }
                        },
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
  const TheresholdComponent({super.key, required this.thresholdFormVal, required this.minValue, required this.maxValue});
  final GetProThresholdFormValModel thresholdFormVal;
  final Function(String) minValue;
  final Function(String) maxValue;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectArchitectBloc, ProjectArchitectState>(
      builder: (context, state) {
        Project pro = state.createdProject!;
        ProjectDetails? proDetails = pro.projectDetails;
        List<ProThreModel>? threVals = proDetails?.thresholdVals;
        List<ProThreModel>? a = (threVals)
            ?.where(
              (element) => element.columnId == thresholdFormVal.id,
            )
            .toList();

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                thresholdFormVal.clientColumnName,
                style: ClanChurnTypography.font16700,
                maxLines: 3,
              ),
            ),
            Row(
              children: [
                Text(
                  "min: ",
                  style: ClanChurnTypography.font16700,
                ),
                CusThresholdFomField(
                  thresholdFormVal: thresholdFormVal,
                  onChanged: minValue,
                  value: a == null
                      ? null
                      : a.isEmpty
                          ? null
                          : a[0].minValue,
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
                  onChanged: maxValue,
                  textInputAction: TextInputAction.next,
                  value: a == null
                      ? null
                      : a.isEmpty
                          ? null
                          : a[0].maxValue,
                )
              ],
            ),
          ],
        );
      },
    );
  }
}

class CusThresholdFomField extends StatefulWidget {
  const CusThresholdFomField({super.key, required this.thresholdFormVal, this.textInputAction, required this.onChanged, this.isEnabled, this.value});
  final GetProThresholdFormValModel thresholdFormVal;
  final TextInputAction? textInputAction;
  final Function(String) onChanged;
  final bool? isEnabled;
  final dynamic value;

  @override
  State<CusThresholdFomField> createState() => _CusThresholdFomFieldState();
}

class _CusThresholdFomFieldState extends State<CusThresholdFomField> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    setState(() {
      controller.text = (widget.value ?? '').toString();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 35,
        width: 150,
        decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary.withOpacity(0.2), borderRadius: BorderRadius.circular(08)),
        margin: const EdgeInsets.only(right: 20, top: 10, bottom: 10),
        child: TextFormField(
          controller: controller, // Use the passed controller here
          textInputAction: widget.textInputAction,
          onChanged: (value) {
            String val = value == "-" ? "0" : value;
            print("********************$val******************");
            widget.onChanged(val);
          },
          enabled: widget.isEnabled,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^-?\d*')),
            LengthLimitingTextInputFormatter(9),
          ],

          // inputFormatters: [
          //   FilteringTextInputFormatter.digitsOnly,
          //   LengthLimitingTextInputFormatter(9),
          // ],
          decoration: InputDecoration(
              hintText: "0",
              hintStyle: ClanChurnTypography.font18500.copyWith(color: Theme.of(context).colorScheme.onSecondary.withOpacity(0.8)),
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
