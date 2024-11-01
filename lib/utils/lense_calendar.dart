import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:clan_churn/utils/typography.dart';
import 'package:flutter/material.dart';

class GetCalendar {
  Future<String> selectDate(BuildContext context) async {
    var results = await showCalendarDatePicker2Dialog(
      context: context,
      config: CalendarDatePicker2WithActionButtonsConfig(
        firstDate: null,
        lastDate: null,
        currentDate: DateTime.now(),
        // weekdayLabelBuilder: customWeekdayBuilder,
        calendarType: CalendarDatePicker2Type.single,
        calendarViewMode: CalendarDatePicker2Mode.year,
        dayTextStyle: ClanChurnTypography.font14500,
        yearTextStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
        selectedDayHighlightColor: Theme.of(context).colorScheme.primary,
        yearBorderRadius: BorderRadius.circular(100),
        modePickersGap: 0,
        animateToDisplayedMonthDate: true,
        controlsTextStyle: ClanChurnTypography.font18500.copyWith(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
      dialogSize: const Size(400, 450),
      dialogBackgroundColor: Theme.of(context).colorScheme.background,
      value: [],
      borderRadius: BorderRadius.circular(08),
    );

    // final DateTime? picked = await showDatePicker(
    //   context: context,
    //   initialDate: DateTime.now(),
    //   firstDate: DateTime(1900),
    //   lastDate: DateTime.now(),
    // );
    if (results != null) {
      if (results.isNotEmpty) {
        return results[0].toString().split(" ").first;
      }
      return '';
      // return results[0].toString().split(" ").first;
    } else {
      return '';
    }
  }
}
