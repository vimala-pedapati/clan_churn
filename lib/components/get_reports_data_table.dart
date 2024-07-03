// DataTable widget
import 'package:clan_churn/components/reports.dart';
import 'package:clan_churn/utils/typography.dart';
import 'package:flutter/material.dart';

class ReportsDataTable extends StatelessWidget {
  final List<String> metrics;
  final List<String> months;
  final Map<String, dynamic> data;
  final int sortColumnIndex;
  final bool sortAscending;
  // final Function(int, bool) onHeaderSort;
  final Function(int, bool) onColumnsSort;

  const ReportsDataTable(
      {super.key,
      required this.metrics,
      required this.months,
      required this.data,
      required this.sortColumnIndex,
      required this.sortAscending,
      // required this.onHeaderSort,
      required this.onColumnsSort});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Theme(
        data: Theme.of(context).copyWith(
            dividerTheme: DividerThemeData(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.5)),
            iconTheme:
                IconThemeData(color: Theme.of(context).colorScheme.background)),
        child: DataTable(
          dividerThickness: 1.0,
          horizontalMargin: 15,
          columnSpacing: 25,
          dataRowMaxHeight: 40,
          dataRowMinHeight: 40,
          sortColumnIndex: sortColumnIndex,
          sortAscending: sortAscending,
          showBottomBorder: true,
          headingRowColor: MaterialStateProperty.resolveWith<Color>((states) {
            return Theme.of(context).colorScheme.primary.withOpacity(0.8);
          }),
          border: TableBorder(
            verticalInside: BorderSide(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.5)),
            right: BorderSide(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.5)),
          ),
          headingTextStyle: ClanChurnTypography.font13600.copyWith(
              color: Theme.of(context).colorScheme.background,
              fontWeight: FontWeight.w900),
          columns: [
            // ------ DON"T REMOVE THE BELOW CODE -------- //
            // DataColumn(
            //   label: Text(
            //     'Metrics',
            //     style: ClanChurnTypography.font13600.copyWith(
            //       color: Theme.of(context).colorScheme.secondary,
            //     ),
            //   ),
            //   onSort: (columnIndex, ascending) =>
            //       onHeaderSort(columnIndex, ascending),
            // ),
            for (var month in months)
              DataColumn(
                label: Center(
                  child: Text(
                    "$month",
                    // style: ClanChurnTypography.font13600.copyWith(
                    //   color: Theme.of(context).colorScheme.secondary,
                    // ),
                  ),
                ),
                onSort: (columnIndex, ascending) =>
                    onColumnsSort(columnIndex, ascending),
              ),
          ],
          rows: metrics.map((metric) {
            return DataRow(
              color: MaterialStateProperty.resolveWith<Color>((states) {
                int index = metrics.indexOf(metric);
                return index % 2 == 0
                    ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
                    : Colors.transparent;
              }),
              cells: [
                // ------ DON"T REMOVE THE BELOW CODE -------- //
                // DataCell(Text(metric)),
                for (var month in months)
                  DataCell(Center(
                    child: Text(
                      transformValue((data[month]![metric] as dynamic) ?? '-'),
                    ),
                  )),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
