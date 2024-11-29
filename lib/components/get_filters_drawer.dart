import 'package:clan_churn/utils/typography.dart';
import 'package:flutter/material.dart';

class GetFiltersDrawer extends StatefulWidget {
  GetFiltersDrawer({super.key, required this.months, required this.updateMonthsData, required this.monthsStore});
  List<String> months;
  final List<String> monthsStore;
  final Function(List<String> updatedData) updateMonthsData;

  @override
  State<GetFiltersDrawer> createState() => _GetFiltersDrawerState();
}

class _GetFiltersDrawerState extends State<GetFiltersDrawer> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Text(
            'Choose columns to filter',
            style: ClanChurnTypography.font13600,
          ),
          trailing: TextButton(
            onPressed: () {
              setState(() {
                widget.months = widget.monthsStore;
              });
            },
            child: Text(
              "Reset",
              style: ClanChurnTypography.font13600,
            ),
          ),
        ),
        Wrap(
          alignment: WrapAlignment.start,
          spacing: 8.0, // spacing between adjacent chips
          runSpacing: 8.0, // spacing between lines of chips
          children: widget.months
              .map((item) => Theme(
                    data: ThemeData(),
                    child: Chip(
                        labelPadding: EdgeInsets.zero,
                        elevation: 00,
                        backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100.0),
                          side: const BorderSide(width: 0, color: Colors.transparent),
                        ),
                        deleteIcon: Icon(
                          Icons.close,
                          size: 15,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        onDeleted: () {
                          widget.months.removeAt(widget.months.indexOf(item));
                          widget.updateMonthsData(widget.months);
                        },
                        label: Text(item, style: ClanChurnTypography.font14400.copyWith(height: 1, color: Theme.of(context).colorScheme.primary))),
                  ))
              .toList(),
        )
      ],
    );
  }
}
