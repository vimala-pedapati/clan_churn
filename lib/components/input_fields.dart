import 'package:clan_churn/utils/input_field_strings.dart';
import 'package:clan_churn/utils/typography.dart';
import 'package:flutter/material.dart';

class GetFields extends StatefulWidget {
  const GetFields({super.key});

  @override
  State<GetFields> createState() => _GetFieldsState();
}

class _GetFieldsState extends State<GetFields> {
  /// Form Key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController c1 = TextEditingController();
  TextEditingController c2 = TextEditingController();
  TextEditingController c3 = TextEditingController();
  TextEditingController c4 = TextEditingController();
  TextEditingController c5 = TextEditingController();
  TextEditingController c6 = TextEditingController();
  TextEditingController c7 = TextEditingController();
  TextEditingController c8 = TextEditingController();
  TextEditingController c9 = TextEditingController();
  TextEditingController c10 = TextEditingController();
  TextEditingController c11 = TextEditingController();
  TextEditingController c12 = TextEditingController();
  TextEditingController c13 = TextEditingController();
  TextEditingController c14 = TextEditingController();
  TextEditingController c15 = TextEditingController();
  TextEditingController c16 = TextEditingController();
  TextEditingController c17 = TextEditingController();
  TextEditingController c18 = TextEditingController();
  TextEditingController c19 = TextEditingController();
  TextEditingController c20 = TextEditingController();
  TextEditingController c21 = TextEditingController();
  TextEditingController c22 = TextEditingController();
  TextEditingController c23 = TextEditingController();
  TextEditingController c24 = TextEditingController();
  TextEditingController c25 = TextEditingController();
  TextEditingController c26 = TextEditingController();
  TextEditingController c27 = TextEditingController();
  TextEditingController c28 = TextEditingController();
  TextEditingController c29 = TextEditingController();
  TextEditingController c30 = TextEditingController();
  TextEditingController c31 = TextEditingController();
  TextEditingController c32 = TextEditingController();
  TextEditingController c33 = TextEditingController();
  TextEditingController c34 = TextEditingController();
  TextEditingController c35 = TextEditingController();
  TextEditingController c36 = TextEditingController();
  TextEditingController c37 = TextEditingController();
  TextEditingController c38 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.65,
      width: MediaQuery.of(context).size.width,
      // color: Colors.amber,
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GetTextFormField(
                  label: InputFieldLabels.customerName,
                  controller: c1,
                ),
                GetTextFormField(
                  label: InputFieldLabels.projectName,
                  controller: c2,
                ),
              ],
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     GetTextFormField(
            //       label: InputFieldLabels.projectOwner,
            //       controller: c3,
            //     ),
            //     GetTextFormField(
            //       label: InputFieldLabels.projectStartDate,
            //       controller: c4,
            //     ),
            //   ],
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     GetTextFormField(
            //       label: InputFieldLabels.studyPeriodBeginningDate,
            //       controller: c5,
            //     ),
            //     GetTextFormField(
            //       label: InputFieldLabels.studyPeriodEndDate,
            //       controller: c6,
            //     ),
            //   ],
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     GetTextFormField(
            //       label: InputFieldLabels.customerName,
            //       controller: c7,
            //     ),
            //     GetTextFormField(
            //       label: InputFieldLabels.projectName,
            //       controller: c8,
            //     ),
            //   ],
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     GetTextFormField(
            //       label: InputFieldLabels
            //           .earliestDateForDateOfJoiningRelevantForStudy,
            //       controller: c9,
            //     ),
            //     GetTextFormField(
            //       label:
            //           InputFieldLabels.endDateForDateOfJoiningRelevantForStudy,
            //       controller: c10,
            //     ),
            //   ],
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     GetTextFormField(
            //       label: InputFieldLabels.customerName,
            //       controller: c11,
            //     ),
            //     GetTextFormField(
            //       label: InputFieldLabels.projectName,
            //       controller: c12,
            //     ),
            //   ],
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     GetTextFormField(
            //       label: InputFieldLabels.unitForValuePerformance,
            //       controller: c13,
            //     ),
            //     GetTextFormField(
            //       label: InputFieldLabels.unitForQuantityPerformance,
            //       controller: c14,
            //     ),
            //   ],
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     GetTextFormField(
            //       label: InputFieldLabels.projectMaximumResidencyMonth,
            //       controller: c15,
            //     ),
            //     GetTextFormField(
            //       label: InputFieldLabels
            //           .projectTopOutlierRankForResidencyMonthofPerformanceMonth,
            //       controller: c16,
            //     ),
            //   ],
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     GetTextFormField(
            //       label: InputFieldLabels
            //           .projectBottomOutlierRankForResidencyMonthOfPerformaceMonth,
            //       controller: c17,
            //     ),
            //     GetTextFormField(
            //       label: InputFieldLabels.projectMaximumPerformanceValueTarget,
            //       controller: c18,
            //     ),
            //   ],
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     GetTextFormField(
            //       label: InputFieldLabels
            //           .projectTopOutlierRankForMaximumPerforamceValueTarget,
            //       controller: c19,
            //     ),
            //     GetTextFormField(
            //       label: InputFieldLabels
            //           .projectBottomOutlierRankMaximumPerformanceValueTarget,
            //       controller: c20,
            //     ),
            //   ],
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     GetTextFormField(
            //       label: InputFieldLabels.projectMaximumPerformanceValueActual,
            //       controller: c21,
            //     ),
            //     GetTextFormField(
            //       label: InputFieldLabels
            //           .projectTopOutlierRankForMaximumPerformanceValueActual,
            //       controller: c22,
            //     ),
            //   ],
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     GetTextFormField(
            //       label: InputFieldLabels
            //           .projectBottomOutlierRankMaximumPerformacealueActual,
            //       controller: c23,
            //     ),
            //     GetTextFormField(
            //       label:
            //           InputFieldLabels.projectMaximumPerformanceQuantityActual,
            //       controller: c24,
            //     ),
            //   ],
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     GetTextFormField(
            //       label: InputFieldLabels
            //           .projectTopOutlierRankForMaximumPerformanceQuantityTarget,
            //       controller: c25,
            //     ),
            //     GetTextFormField(
            //       label: InputFieldLabels
            //           .projectBottomOutlierRankMaximumPerformanceQuatityTarget,
            //       controller: c26,
            //     ),
            //   ],
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     GetTextFormField(
            //       label:
            //           InputFieldLabels.projectMaximumPerformanceQuantityActual,
            //       controller: c27,
            //     ),
            //     GetTextFormField(
            //       label: InputFieldLabels
            //           .projectTopOutlierRankForMaximumPerformanceQuantityActual,
            //       controller: c28,
            //     ),
            //   ],
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     GetTextFormField(
            //       label: InputFieldLabels
            //           .projectBottomOutlierRankMaximumPerformanceQuantityActual,
            //       controller: c29,
            //     ),
            //     GetTextFormField(
            //       label: InputFieldLabels
            //           .projectMaximumOverAllPerformanceAchievement,
            //       controller: c30,
            //     ),
            //   ],
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     GetTextFormField(
            //       label: InputFieldLabels
            //           .projectTopOutlierRankForMaximumOverAllPerformanceAchievent,
            //       controller: c31,
            //     ),
            //     GetTextFormField(
            //       label: InputFieldLabels
            //           .projectBottomOutlierRankMaximumOverAllPerformanceAchievement,
            //       controller: c32,
            //     ),
            //   ],
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     GetTextFormField(
            //       label: InputFieldLabels.projectMaximumMonthlyFixedSalaryIndex,
            //       controller: c33,
            //     ),
            //     GetTextFormField(
            //       label: InputFieldLabels
            //           .projectTopOutlierRankForMaximumMonthlyFixedSalaryIndex,
            //       controller: c34,
            //     ),
            //   ],
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     GetTextFormField(
            //       label: InputFieldLabels
            //           .projectBottomOutlierRankMaximumMonthlyFixedSalaryIndex,
            //       controller: c35,
            //     ),
            //     GetTextFormField(
            //       label: InputFieldLabels.projectMaximumMonthlyIncentive,
            //       controller: c36,
            //     ),
            //   ],
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     GetTextFormField(
            //       label: InputFieldLabels
            //           .projectTopOutlierRankForMaximumMonthlyIncentive,
            //       controller: c37,
            //     ),
            //     GetTextFormField(
            //       label: InputFieldLabels
            //           .projectBottomOutlierRankMaximumMonthlyIncentive,
            //       controller: c38,
            //     ),
            //   ],
            // ),
            // Row(
            //   children: [
            //     ElevatedButton(
            //       child: Text("Next"),
            //       onPressed: () {
            //         print("next");
            //         print("${c1.text}");
            //       },
            //     )
            //   ],
            // )
          
          ]),
        ),
      ),
    );
  }
}

class GetTextFormField extends StatelessWidget {
  const GetTextFormField({
    super.key,
    required this.label,
    this.textInputAction = TextInputAction.done,
    required this.controller,
  });
  final String label;
  final TextInputAction textInputAction;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    // final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Column(
      // mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InputLabel(
          label: label,
        ),
        Container(
          width: w * 0.35,
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
            textInputAction: textInputAction,
            // readOnly: true,
            decoration: InputDecoration(
              hintText: label,
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
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.35,
      child: Text(
        label,
        style: ClanChurnTypography.font15600,
      ),
    );
  }
}
