import 'package:clan_churn/api_repos/models/get_pro_threshold_val_model.dart';
import 'package:clan_churn/api_repos/models/project_model.dart';
import 'package:clan_churn/api_repos/models/threshold_val_model.dart';
import 'package:clan_churn/churn_blocs/project_architect/project_architect_bloc.dart';
import 'package:clan_churn/components/pro_threshold_currency_field.dart';
import 'package:clan_churn/components/pro_threshold_date_field.dart';
import 'package:clan_churn/utils/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'project_threshold_percent_field.dart';

class TheresholdComponent extends StatelessWidget {
  const TheresholdComponent({
    super.key,
    required this.thresholdFormVal,
  });
  final GetProThresholdFormValModel thresholdFormVal;

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
                thresholdFormVal.columnDataType == ColumnDataType.date
                    ? CusThresholdDateField(
                        thresholdFormVal: thresholdFormVal,
                        value: a == null
                            ? null
                            : a.isEmpty
                                ? null
                                : a[0].minValue,
                        isMaxValue: false,
                      )
                    : thresholdFormVal.columnDataType == ColumnDataType.numericWithPercentage
                        ? CusThresholdPercentField(
                            thresholdFormVal: thresholdFormVal,
                            value: a == null
                                ? null
                                : a.isEmpty
                                    ? null
                                    : a[0].minValue,
                            isMaxValue: false,
                          )
                        : CusThresholdCurrencyField(
                            thresholdFormVal: thresholdFormVal,
                            value: a == null
                                ? null
                                : a.isEmpty
                                    ? null
                                    : a[0].minValue,
                            isMaxValue: false,
                          )
              ],
            ),
            Row(
              children: [
                Text(
                  "max: ",
                  style: ClanChurnTypography.font16700,
                ),
                thresholdFormVal.columnDataType == ColumnDataType.date
                    ? CusThresholdDateField(
                        thresholdFormVal: thresholdFormVal,
                        textInputAction: TextInputAction.next,
                        value: a == null
                            ? null
                            : a.isEmpty
                                ? null
                                : a[0].maxValue,
                        isMaxValue: true,
                      )
                    : thresholdFormVal.columnDataType == ColumnDataType.numericWithPercentage
                        ? CusThresholdPercentField(
                            thresholdFormVal: thresholdFormVal,
                            textInputAction: TextInputAction.next,
                            value: a == null
                                ? null
                                : a.isEmpty
                                    ? null
                                    : a[0].maxValue,
                            isMaxValue: true,
                          )
                        : CusThresholdCurrencyField(
                            thresholdFormVal: thresholdFormVal,
                            textInputAction: TextInputAction.next,
                            value: a == null
                                ? null
                                : a.isEmpty
                                    ? null
                                    : a[0].maxValue,
                            isMaxValue: true,
                          )
              ],
            ),
          ],
        );
      },
    );
  }
}
