import 'package:clan_churn/utils/input_field_strings.dart';
import 'package:clan_churn/utils/typography.dart';
import 'package:flutter/material.dart';

class GetFields extends StatelessWidget {
  const GetFields({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GetTextFormField(
            label: InputFieldLabels.customerName,
          ),
          GetTextFormField(
            label: InputFieldLabels.projectName,
          ),
        ],
      ),
      Row(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GetTextFormField(
            label: InputFieldLabels.projectOwner,
          ),
          GetTextFormField(
            label: InputFieldLabels.projectStartDate,
          ),
        ],
      ),
      Row(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GetTextFormField(
            label: InputFieldLabels.studyPeriodBeginningDate,
          ),
          GetTextFormField(
            label: InputFieldLabels.studyPeriodEndDate,
          ),
        ],
      ),
      Row(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GetTextFormField(
            label: InputFieldLabels.customerName,
          ),
          GetTextFormField(
            label: InputFieldLabels.projectName,
          ),
        ],
      ),
      Row(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GetTextFormField(
            label: InputFieldLabels.earliestDateForDateOfJoiningRelevantForStudy,
          ),
          GetTextFormField(
            label: InputFieldLabels.endDateForDateOfJoiningRelevantForStudy,
          ),
        ],
      ),
      Row(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GetTextFormField(
            label: InputFieldLabels.customerName,
          ),
          GetTextFormField(
            label: InputFieldLabels.projectName,
          ),
        ],
      ),
      Row(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GetTextFormField(
            label: InputFieldLabels.unitForValuePerformance,
          ),
          GetTextFormField(
            label: InputFieldLabels.unitForQuantityPerformance,
          ),
        ],
      ),
      Row(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GetTextFormField(
            label: InputFieldLabels.projectMaximumResidencyMonth,
          ),
          GetTextFormField(
            label: InputFieldLabels.projectTopOutlierRankForResidencyMonthofPerformanceMonth,
          ),
        ],
      ),
      Row(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GetTextFormField(
            label: InputFieldLabels.projectBottomOutlierRankForResidencyMonthOfPerformaceMonth,
          ),
          GetTextFormField(
            label: InputFieldLabels.projectMaximumPerformanceValueTarget,
          ),
        ],
      ),
      Row(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GetTextFormField(
            label: InputFieldLabels.projectTopOutlierRankForMaximumPerforamceValueTarget,
          ),
          GetTextFormField(
            label: InputFieldLabels.projectBottomOutlierRankMaximumPerformanceValueTarget,
          ),
        ],
      ),
      Row(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GetTextFormField(
            label: InputFieldLabels.projectMaximumPerformanceValueActual,
          ),
          GetTextFormField(
            label: InputFieldLabels.projectTopOutlierRankForMaximumPerformanceValueActual,
          ),
        ],
      ),
      Row(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GetTextFormField(
            label: InputFieldLabels.projectBottomOutlierRankMaximumPerformacealueActual,
          ),
          GetTextFormField(
            label: InputFieldLabels.projectMaximumPerformanceQuantityActual,
          ),
        ],
      ),
      Row(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GetTextFormField(
            label: InputFieldLabels.projectTopOutlierRankForMaximumPerformanceQuantityTarget,
          ),
          GetTextFormField(
            label: InputFieldLabels. projectBottomOutlierRankMaximumPerformanceQuatityTarget,
          ),
        ],
      ),
      Row(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GetTextFormField(
            label: InputFieldLabels.projectMaximumPerformanceQuantityActual ,
          ),
          GetTextFormField(
            label: InputFieldLabels.projectTopOutlierRankForMaximumPerformanceQuantityActual ,
          ),
        ],
      ),
      Row(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GetTextFormField(
            label: InputFieldLabels.projectBottomOutlierRankMaximumPerformanceQuantityActual ,
          ),
          GetTextFormField(
            label: InputFieldLabels.projectMaximumOverAllPerformanceAchievement ,
          ),
        ],
      ),
      Row(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GetTextFormField(
            label: InputFieldLabels.projectTopOutlierRankForMaximumOverAllPerformanceAchievent ,
          ),
          GetTextFormField(
            label: InputFieldLabels.projectBottomOutlierRankMaximumOverAllPerformanceAchievement ,
          ),
        ],
      ),
      Row(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GetTextFormField(
            label: InputFieldLabels.projectMaximumMonthlyFixedSalaryIndex  ,
          ),
          GetTextFormField(
            label: InputFieldLabels.projectTopOutlierRankForMaximumMonthlyFixedSalaryIndex  ,
          ),
        ],
      ),
      Row(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GetTextFormField(
            label: InputFieldLabels. projectBottomOutlierRankMaximumMonthlyFixedSalaryIndex ,
          ),
          GetTextFormField(
            label: InputFieldLabels. projectMaximumMonthlyIncentive ,
          ),
        ],
      ),
      Row(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GetTextFormField(
            label: InputFieldLabels.projectTopOutlierRankForMaximumMonthlyIncentive  ,
          ),
          GetTextFormField(
            label: InputFieldLabels. projectBottomOutlierRankMaximumMonthlyIncentive ,
          ),
        ],
      ),
    ]);
  }
}

class GetTextFormField extends StatelessWidget {
  const GetTextFormField({super.key, required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Column(
      // mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InputLabel(
          label: label,
        ),
        Container(
          width: w * 0.3,
          height: 40,
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.0)),
          margin: const EdgeInsets.only(top: 5, bottom: 20),
          child: TextFormField(
            // controller: clientController,
            keyboardType: TextInputType.emailAddress,
            autofocus: false,
            cursorHeight: 15,
            // readOnly: true,
            decoration: InputDecoration(
              hintText: 'Enter Client ID',
              hintStyle: ClanChurnTypography.font12500
                  .copyWith(color: Theme.of(context).colorScheme.tertiary),
              contentPadding:
                  const EdgeInsets.only(top: 10, left: 10, right: 10),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
            ),
            onChanged: (value) {},
            validator: (String? val) {},
            onSaved: (String? val) {},
            onFieldSubmitted: (String? val) {
              // print("on field submitted");
            },
          ),
        ),
      ],
    );
  }
}

class InputLabel extends StatelessWidget {
  const InputLabel({super.key, required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: ClanChurnTypography.font20600,
    );
  }
}
