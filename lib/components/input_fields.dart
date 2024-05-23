import 'package:clan_churn/utils/input_field_strings.dart';
import 'package:clan_churn/utils/spacing.dart';
import 'package:clan_churn/utils/typography.dart';
import 'package:flutter/material.dart';

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

class GetInputFields extends StatefulWidget {
  const GetInputFields({Key? key}) : super(key: key);

  @override
  State<GetInputFields> createState() => _GetInputFieldsState();
}

class _GetInputFieldsState extends State<GetInputFields> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // TextEditingControllers
  final List<TextEditingController> c =
      List.generate(34, (_) => TextEditingController());

  @override
  void dispose() {
    for (var i in c) {
      i.clear();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.65,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Column(
          children: [
            /// sign up Form
            Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomTextFormField(
                            label: InputFieldLabels.customerName,
                            controller: c[0],
                            textInputType: TextInputType.name,
                            hintText: "hint text",
                            prefixIcon: Icons.person,
                            isObscureText: false,
                            isEnabled: true,
                            textInputAction: TextInputAction.next,
                          ),
                          CustomTextFormField(
                            label: InputFieldLabels.projectName,
                            controller: c[1],
                            textInputType: TextInputType.name,
                            hintText: "hint text",
                            prefixIcon: Icons.person,
                            isObscureText: false,
                            isEnabled: true,
                            textInputAction: TextInputAction.next,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomTextFormField(
                            label: InputFieldLabels.projectOwner,
                            controller: c[2],
                            textInputType: TextInputType.name,
                            hintText: "hint text",
                            prefixIcon: Icons.person,
                            isObscureText: false,
                            isEnabled: true,
                            textInputAction: TextInputAction.next,
                          ),
                          CustomTextFormField(
                            label: InputFieldLabels.projectStartDate,
                            controller: c[3],
                            textInputType: TextInputType.name,
                            hintText: "hint text",
                            prefixIcon: Icons.person,
                            isObscureText: false,
                            isEnabled: true,
                            textInputAction: TextInputAction.next,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomTextFormField(
                            label: InputFieldLabels.studyPeriodBeginningDate,
                            controller: c[4],
                            textInputType: TextInputType.name,
                            hintText: "hint text",
                            prefixIcon: Icons.person,
                            isObscureText: false,
                            isEnabled: true,
                            textInputAction: TextInputAction.next,
                          ),
                          CustomTextFormField(
                            label: InputFieldLabels.studyPeriodEndDate,
                            controller: c[5],
                            textInputType: TextInputType.name,
                            hintText: "hint text",
                            prefixIcon: Icons.person,
                            isObscureText: false,
                            isEnabled: true,
                            textInputAction: TextInputAction.next,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomTextFormField(
                            label: InputFieldLabels
                                .earliestDateForDateOfJoiningRelevantForStudy,
                            controller: c[6],
                            textInputType: TextInputType.name,
                            hintText: "hint text",
                            prefixIcon: Icons.person,
                            isObscureText: false,
                            isEnabled: true,
                            textInputAction: TextInputAction.next,
                          ),
                          CustomTextFormField(
                            label: InputFieldLabels
                                .endDateForDateOfJoiningRelevantForStudy,
                            controller: c[7],
                            textInputType: TextInputType.name,
                            hintText: "hint text",
                            prefixIcon: Icons.person,
                            isObscureText: false,
                            isEnabled: true,
                            textInputAction: TextInputAction.next,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomTextFormField(
                            label: InputFieldLabels.unitForValuePerformance,
                            controller: c[8],
                            textInputType: TextInputType.name,
                            hintText: "hint text",
                            prefixIcon: Icons.person,
                            isObscureText: false,
                            isEnabled: true,
                            textInputAction: TextInputAction.next,
                          ),
                          CustomTextFormField(
                            label: InputFieldLabels.unitForQuantityPerformance,
                            controller: c[9],
                            textInputType: TextInputType.name,
                            hintText: "hint text",
                            prefixIcon: Icons.person,
                            isObscureText: false,
                            isEnabled: true,
                            textInputAction: TextInputAction.next,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomTextFormField(
                            label:
                                InputFieldLabels.projectMaximumResidencyMonth,
                            controller: c[10],
                            textInputType: TextInputType.name,
                            hintText: "hint text",
                            prefixIcon: Icons.person,
                            isObscureText: false,
                            isEnabled: true,
                            textInputAction: TextInputAction.next,
                          ),
                          CustomTextFormField(
                            label: InputFieldLabels
                                .projectTopOutlierRankForResidencyMonthofPerformanceMonth,
                            controller: c[11],
                            textInputType: TextInputType.name,
                            hintText: "hint text",
                            prefixIcon: Icons.person,
                            isObscureText: false,
                            isEnabled: true,
                            textInputAction: TextInputAction.next,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomTextFormField(
                            label: InputFieldLabels
                                .projectBottomOutlierRankForResidencyMonthOfPerformaceMonth,
                            controller: c[12],
                            textInputType: TextInputType.name,
                            hintText: "hint text",
                            prefixIcon: Icons.person,
                            isObscureText: false,
                            isEnabled: true,
                            textInputAction: TextInputAction.next,
                          ),
                          CustomTextFormField(
                            label: InputFieldLabels
                                .projectMaximumPerformanceValueTarget,
                            controller: c[13],
                            textInputType: TextInputType.name,
                            hintText: "hint text",
                            prefixIcon: Icons.person,
                            isObscureText: false,
                            isEnabled: true,
                            textInputAction: TextInputAction.next,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomTextFormField(
                            label: InputFieldLabels
                                .projectTopOutlierRankForMaximumPerforamceValueTarget,
                            controller: c[14],
                            textInputType: TextInputType.name,
                            hintText: "hint text",
                            prefixIcon: Icons.person,
                            isObscureText: false,
                            isEnabled: true,
                            textInputAction: TextInputAction.next,
                          ),
                          CustomTextFormField(
                            label: InputFieldLabels
                                .projectBottomOutlierRankMaximumPerformanceValueTarget,
                            controller: c[15],
                            textInputType: TextInputType.name,
                            hintText: "hint text",
                            prefixIcon: Icons.person,
                            isObscureText: false,
                            isEnabled: true,
                            textInputAction: TextInputAction.next,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomTextFormField(
                            label: InputFieldLabels
                                .projectMaximumPerformanceValueActual,
                            controller: c[16],
                            textInputType: TextInputType.name,
                            hintText: "hint text",
                            prefixIcon: Icons.person,
                            isObscureText: false,
                            isEnabled: true,
                            textInputAction: TextInputAction.next,
                          ),
                          CustomTextFormField(
                            label: InputFieldLabels
                                .projectTopOutlierRankForMaximumPerformanceValueActual,
                            controller: c[17],
                            textInputType: TextInputType.name,
                            hintText: "hint text",
                            prefixIcon: Icons.person,
                            isObscureText: false,
                            isEnabled: true,
                            textInputAction: TextInputAction.next,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomTextFormField(
                            label: InputFieldLabels
                                .projectBottomOutlierRankMaximumPerformacealueActual,
                            controller: c[18],
                            textInputType: TextInputType.name,
                            hintText: "hint text",
                            prefixIcon: Icons.person,
                            isObscureText: false,
                            isEnabled: true,
                            textInputAction: TextInputAction.next,
                          ),
                          CustomTextFormField(
                            label: InputFieldLabels
                                .projectMaximumPerformanceQuantityActual,
                            controller: c[19],
                            textInputType: TextInputType.name,
                            hintText: "hint text",
                            prefixIcon: Icons.person,
                            isObscureText: false,
                            isEnabled: true,
                            textInputAction: TextInputAction.next,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomTextFormField(
                            label: InputFieldLabels
                                .projectTopOutlierRankForMaximumPerformanceQuantityTarget,
                            controller: c[20],
                            textInputType: TextInputType.name,
                            hintText: "hint text",
                            prefixIcon: Icons.person,
                            isObscureText: false,
                            isEnabled: true,
                            textInputAction: TextInputAction.next,
                          ),
                          CustomTextFormField(
                            label: InputFieldLabels
                                .projectBottomOutlierRankMaximumPerformanceQuatityTarget,
                            controller: c[21],
                            textInputType: TextInputType.name,
                            hintText: "hint text",
                            prefixIcon: Icons.person,
                            isObscureText: false,
                            isEnabled: true,
                            textInputAction: TextInputAction.next,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomTextFormField(
                            label: InputFieldLabels
                                .projectMaximumPerformanceQuantityActual,
                            controller: c[22],
                            textInputType: TextInputType.name,
                            hintText: "hint text",
                            prefixIcon: Icons.person,
                            isObscureText: false,
                            isEnabled: true,
                            textInputAction: TextInputAction.next,
                          ),
                          CustomTextFormField(
                            label: InputFieldLabels
                                .projectTopOutlierRankForMaximumPerformanceQuantityActual,
                            controller: c[23],
                            textInputType: TextInputType.name,
                            hintText: "hint text",
                            prefixIcon: Icons.person,
                            isObscureText: false,
                            isEnabled: true,
                            textInputAction: TextInputAction.next,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomTextFormField(
                            label: InputFieldLabels
                                .projectBottomOutlierRankMaximumPerformanceQuantityActual,
                            controller: c[24],
                            textInputType: TextInputType.name,
                            hintText: "hint text",
                            prefixIcon: Icons.person,
                            isObscureText: false,
                            isEnabled: true,
                            textInputAction: TextInputAction.next,
                          ),
                          CustomTextFormField(
                            label: InputFieldLabels
                                .projectMaximumOverAllPerformanceAchievement,
                            controller: c[25],
                            textInputType: TextInputType.name,
                            hintText: "hint text",
                            prefixIcon: Icons.person,
                            isObscureText: false,
                            isEnabled: true,
                            textInputAction: TextInputAction.next,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomTextFormField(
                            label: InputFieldLabels
                                .projectTopOutlierRankForMaximumOverAllPerformanceAchievent,
                            controller: c[26],
                            textInputType: TextInputType.name,
                            hintText: "hint text",
                            prefixIcon: Icons.person,
                            isObscureText: false,
                            isEnabled: true,
                            textInputAction: TextInputAction.next,
                          ),
                          CustomTextFormField(
                            label: InputFieldLabels
                                .projectBottomOutlierRankMaximumOverAllPerformanceAchievement,
                            controller: c[27],
                            textInputType: TextInputType.name,
                            hintText: "hint text",
                            prefixIcon: Icons.person,
                            isObscureText: false,
                            isEnabled: true,
                            textInputAction: TextInputAction.next,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomTextFormField(
                            label: InputFieldLabels
                                .projectMaximumMonthlyFixedSalaryIndex,
                            controller: c[28],
                            textInputType: TextInputType.name,
                            hintText: "hint text",
                            prefixIcon: Icons.person,
                            isObscureText: false,
                            isEnabled: true,
                            textInputAction: TextInputAction.next,
                          ),
                          CustomTextFormField(
                            label: InputFieldLabels
                                .projectTopOutlierRankForMaximumMonthlyFixedSalaryIndex,
                            controller: c[29],
                            textInputType: TextInputType.name,
                            hintText: "hint text",
                            prefixIcon: Icons.person,
                            isObscureText: false,
                            isEnabled: true,
                            textInputAction: TextInputAction.next,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomTextFormField(
                            label: InputFieldLabels
                                .projectBottomOutlierRankMaximumMonthlyFixedSalaryIndex,
                            controller: c[30],
                            textInputType: TextInputType.name,
                            hintText: "hint text",
                            prefixIcon: Icons.person,
                            isObscureText: false,
                            isEnabled: true,
                            textInputAction: TextInputAction.next,
                          ),
                          CustomTextFormField(
                            label:
                                InputFieldLabels.projectMaximumMonthlyIncentive,
                            controller: c[31],
                            textInputType: TextInputType.name,
                            hintText: "hint text",
                            prefixIcon: Icons.person,
                            isObscureText: false,
                            isEnabled: true,
                            textInputAction: TextInputAction.next,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomTextFormField(
                            label: InputFieldLabels
                                .projectTopOutlierRankForMaximumMonthlyIncentive,
                            controller: c[32],
                            textInputType: TextInputType.name,
                            hintText: "hint text",
                            prefixIcon: Icons.person,
                            isObscureText: false,
                            isEnabled: true,
                            textInputAction: TextInputAction.next,
                          ),
                          CustomTextFormField(
                            label: InputFieldLabels
                                .projectBottomOutlierRankMaximumMonthlyIncentive,
                            controller: c[33],
                            textInputType: TextInputType.name,
                            hintText: "hint text",
                            prefixIcon: Icons.person,
                            isObscureText: false,
                            isEnabled: true,
                            textInputAction: TextInputAction.next,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              for (int i = 0; i < c.length; i++) {
                                print("$i : ${c[i].text} ");
                              }
                            },
                            child: Text("Next"),
                          )
                        ],
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {this.controller,
      this.textInputType,
      this.hintText,
      this.prefixIcon,
      required this.isObscureText,
      required this.isEnabled,
      this.textInputAction,
      this.label,
      Key? key})
      : super(key: key);
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final String? hintText;
  final IconData? prefixIcon;
  final bool? isObscureText;
  final bool? isEnabled;
  final TextInputAction? textInputAction;
  final String? label;
  @override
  Widget build(BuildContext context) {
    //     // final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Container(
      // padding: const EdgeInsets.fromLTRB(10, 3, 20, 0),
      margin: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InputLabel(
            label: label ?? "",
          ),
          ClanChurnSpacing.h6,
          Container(
              width: w * 0.35,
              alignment: Alignment.center,
              height: 40,
              decoration: BoxDecoration(
                  // border: Border.all(color: Colors.black),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100)),
              child: TextField(
                keyboardType: textInputType,
                cursorColor: Colors.grey,
                cursorHeight: 17,
                cursorWidth: 2.5,
                controller: controller,
                obscureText: isObscureText!,
                enabled: isEnabled,
                textInputAction: textInputAction,
                decoration: InputDecoration(
                  hintText: label,
                  hintStyle: ClanChurnTypography.font14500
                      .copyWith(color: Theme.of(context).colorScheme.tertiary),
                  contentPadding:
                      const EdgeInsets.only(top: 10, left: 10, right: 10),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                ),
              )),
        ],
      ),
    );
  }
}
