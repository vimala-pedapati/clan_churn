import 'package:clan_churn/utils/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../api_repos/models/get_pro_threshold_val_model.dart';
import '../churn_blocs/project_architect/project_architect_bloc.dart';
import '../utils/lense_calendar.dart';
import 'cus_text_editing_controller.dart';

class CusThresholdDateField extends StatefulWidget {
  const CusThresholdDateField({
    super.key,
    required this.thresholdFormVal,
    this.textInputAction,
    this.isEnabled,
    this.value,
    required this.isMaxValue,
  });

  final GetProThresholdFormValModel thresholdFormVal;
  final TextInputAction? textInputAction;

  final bool? isEnabled;
  final dynamic value;
  final bool isMaxValue;

  @override
  State<CusThresholdDateField> createState() => _CusThresholdDateFieldState();
}

class _CusThresholdDateFieldState extends State<CusThresholdDateField> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    // controller.text = (widget.value ?? '').toString();
    controller.text = widget.value == null ? "" : DateFormat('dd-MM-yy').format(DateTime.parse(widget.value));
    if (widget.value != null) {
      if (widget.isMaxValue) {
        context.read<ProjectArchitectBloc>().add(
              UpdateProjectThresholdMaxValue(
                maxValue: widget.value,
                thresholdId: widget.thresholdFormVal.id,
              ),
            );
      } else {
        context.read<ProjectArchitectBloc>().add(
              UpdateProjectThresholdMinValue(
                minValue: widget.value,
                thresholdId: widget.thresholdFormVal.id,
              ),
            );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: 150,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.only(right: 20, top: 10, bottom: 10),
      child: TextFormField(
        controller: controller,
        textInputAction: widget.textInputAction,
        readOnly: true,
        enabled: widget.isEnabled != false
            ? widget.isMaxValue == false
                ? true
                : (widget.value != null)
                    ? true
                    : (widget.isMaxValue == true && widget.thresholdFormVal.minValue != null)
                        ? true
                        : false
            : false,
        onTap: null,
        decoration: InputDecoration(
          hintText: "dd-mm-yy",
          hintStyle: ClanChurnTypography.font18500.copyWith(
            color: Theme.of(context).colorScheme.onSecondary.withOpacity(0.8),
          ),
          suffixIcon: MouseRegion(
            cursor: SystemMouseCursors.click, // Changes cursor to a click pointer
            child: IconButton(
              onPressed: (widget.isEnabled != false)
                  ? () async {
                      print("calling..");
                      // Await the selected date from the calendar
                      String selectedDate = await GetCalendar().selectDate(
                        context,
                        firstDate: widget.isMaxValue ? DateTime.tryParse(widget.thresholdFormVal.minValue.toString()) : null,
                      );

                      // Update the controller text
                      controller.text = selectedDate;
                      if (widget.isMaxValue) {
                        context.read<ProjectArchitectBloc>().add(
                              UpdateProjectThresholdMaxValue(
                                maxValue: selectedDate,
                                thresholdId: widget.thresholdFormVal.id,
                              ),
                            );
                      } else {
                        context.read<ProjectArchitectBloc>().add(
                              UpdateProjectThresholdMinValue(
                                minValue: selectedDate,
                                thresholdId: widget.thresholdFormVal.id,
                              ),
                            );
                      }
                    }
                  : null,
              icon: Icon(
                Icons.calendar_month_outlined,
                size: 20,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          contentPadding: const EdgeInsets.only(
            left: 10,
            right: 10,
          ),
          enabledBorder: border(context),
          focusedBorder: border(context),
          border: border(context),
        ),
      ),
    );
  }
}
