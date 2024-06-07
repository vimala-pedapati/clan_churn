import 'dart:convert';
import 'package:clan_churn/utils/spacing.dart';
import 'package:clan_churn/utils/typography.dart';
import 'package:flutter/material.dart';

void viewErrorReport(
    BuildContext ctx, Map<String, dynamic> jsonData, String selectedSheet) {
  final sheetData =
      json.decode(jsonData[selectedSheet]) as Map<String, dynamic>;
  showDialog(
    context: ctx,
    builder: (_) => AlertDialog(
      backgroundColor: Theme.of(ctx).colorScheme.background,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(08),
      ),
      content: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
          Radius.circular(0.0),
        )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 10, bottom: 10),
                decoration: BoxDecoration(
                    border: Border(
                  top: BorderSide(
                      color: Theme.of(ctx).colorScheme.tertiary, width: 1.5),
                  left: BorderSide(
                      color: Theme.of(ctx).colorScheme.tertiary, width: 1.5),
                  right: BorderSide(
                      color: Theme.of(ctx).colorScheme.tertiary, width: 1.5),
                )),
                child: Text(
                  "Data Summary Report",
                  style: ClanChurnTypography.font16600
                      .copyWith(color: Theme.of(ctx).colorScheme.primary),
                )),
            Theme(
              data: Theme.of(ctx).copyWith(
                  dividerTheme:
                      const DividerThemeData(color: Colors.transparent)),
              child: SingleChildScrollView(
                child: DataTable(
                  dividerThickness: 1.0,
                  horizontalMargin: 15,
                  columnSpacing: 10,
                  dataRowMaxHeight: 40,
                  dataRowMinHeight: 40,
                  border: TableBorder(
                    horizontalInside: BorderSide.none,
                    verticalInside: BorderSide(
                        color: Theme.of(ctx).colorScheme.tertiary, width: 1.5),
                    bottom: BorderSide(
                        color: Theme.of(ctx).colorScheme.tertiary,
                        width: 1.5), // Remove the bottom border
                    top: BorderSide(
                        color: Theme.of(ctx).colorScheme.tertiary, width: 1.5),
                    left: BorderSide(
                        color: Theme.of(ctx).colorScheme.tertiary, width: 1.5),
                    right: BorderSide(
                        color: Theme.of(ctx).colorScheme.tertiary, width: 1.5),
                  ),
                  columns: [
                    DataColumn(
                        label: Text(
                      '',
                      style: ClanChurnTypography.font16500
                          .copyWith(color: Theme.of(ctx).colorScheme.secondary),
                    )),
                    DataColumn(
                        label: Text(
                      'Count',
                      style: ClanChurnTypography.font16600
                          .copyWith(color: Theme.of(ctx).colorScheme.secondary),
                    )),
                    DataColumn(
                        label: Text(
                      'Unique',
                      style: ClanChurnTypography.font16600
                          .copyWith(color: Theme.of(ctx).colorScheme.secondary),
                    )),
                    DataColumn(
                        label: Text(
                      'Freq.',
                      style: ClanChurnTypography.font16600
                          .copyWith(color: Theme.of(ctx).colorScheme.secondary),
                    )),
                    DataColumn(
                        label: Text(
                      'Mean',
                      style: ClanChurnTypography.font16600
                          .copyWith(color: Theme.of(ctx).colorScheme.secondary),
                    )),
                    DataColumn(
                        label: Text(
                      'Min',
                      style: ClanChurnTypography.font16600
                          .copyWith(color: Theme.of(ctx).colorScheme.secondary),
                    )),
                    DataColumn(
                        label: Text(
                      '25%',
                      style: ClanChurnTypography.font16600
                          .copyWith(color: Theme.of(ctx).colorScheme.secondary),
                    )),
                    DataColumn(
                        label: Text(
                      '50%',
                      style: ClanChurnTypography.font16600
                          .copyWith(color: Theme.of(ctx).colorScheme.secondary),
                    )),
                    DataColumn(
                        label: Text(
                      '75%',
                      style: ClanChurnTypography.font16600
                          .copyWith(color: Theme.of(ctx).colorScheme.secondary),
                    )),
                    DataColumn(
                        label: Text(
                      'Max',
                      style: ClanChurnTypography.font16600
                          .copyWith(color: Theme.of(ctx).colorScheme.secondary),
                    )),
                    DataColumn(
                        label: Text(
                      'STD',
                      style: ClanChurnTypography.font16600
                          .copyWith(color: Theme.of(ctx).colorScheme.secondary),
                    )),
                    DataColumn(
                        label: Text(
                      'Blank Count',
                      style: ClanChurnTypography.font16600
                          .copyWith(color: Theme.of(ctx).colorScheme.secondary),
                    )),
                  ],
                  rows: sheetData.entries.toList().asMap().entries.map((entry) {
                    int index = entry.key;
                    String key = entry.value.key;
                    Map<String, dynamic> value =
                        entry.value.value as Map<String, dynamic>;
                    return DataRow(
                        color: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                          if (index % 2 == 0) {
                            return Theme.of(ctx)
                                .colorScheme
                                .primary
                                .withOpacity(0.1);
                          }
                          return Colors.transparent;
                        }),
                        cells: [
                          DataCell(ConstrainedBox(
                            constraints: const BoxConstraints(
                              minWidth: 60,
                              maxWidth: 500,
                            ),
                            child: Text(
                              key,
                              style: ClanChurnTypography.font16500.copyWith(
                                  color: Theme.of(ctx).colorScheme.secondary),
                              textAlign: TextAlign.center,
                            ),
                          )),
                          DataCell(ConstrainedBox(
                            constraints: const BoxConstraints(
                              minWidth: 60,
                              maxWidth: 80,
                            ),
                            child: Text(
                              (value["count"] ?? "-").toString(),
                              style: ClanChurnTypography.font14600.copyWith(
                                  color: Theme.of(ctx).colorScheme.onSecondary),
                              textAlign: TextAlign.center,
                            ),
                          )),
                          DataCell(ConstrainedBox(
                            constraints: const BoxConstraints(
                              minWidth: 60,
                              maxWidth: 80,
                            ),
                            child: Text(
                              (value["unique"] ?? "-").toString(),
                              style: ClanChurnTypography.font14600.copyWith(
                                  color: Theme.of(ctx).colorScheme.onSecondary),
                              textAlign: TextAlign.center,
                            ),
                          )),
                          DataCell(ConstrainedBox(
                            constraints: const BoxConstraints(
                              minWidth: 60,
                              maxWidth: 80,
                            ),
                            child: Text(
                              (value["freq"] ?? "-").toString(),
                              style: ClanChurnTypography.font14600.copyWith(
                                  color: Theme.of(ctx).colorScheme.onSecondary),
                              textAlign: TextAlign.center,
                            ),
                          )),
                          DataCell(ConstrainedBox(
                            constraints: const BoxConstraints(
                              minWidth: 60,
                              maxWidth: 80,
                            ),
                            child: Text(
                              (value["mean"] ?? "-").toString(),
                              style: ClanChurnTypography.font14600.copyWith(
                                  color: Theme.of(ctx).colorScheme.onSecondary),
                              textAlign: TextAlign.center,
                            ),
                          )),
                          DataCell(ConstrainedBox(
                            constraints: const BoxConstraints(
                              minWidth: 60,
                              maxWidth: 80,
                            ),
                            child: Text(
                              (value["min"] ?? "-").toString(),
                              style: ClanChurnTypography.font14600.copyWith(
                                  color: Theme.of(ctx).colorScheme.onSecondary),
                              textAlign: TextAlign.center,
                            ),
                          )),
                          DataCell(ConstrainedBox(
                            constraints: const BoxConstraints(
                              minWidth: 60,
                              maxWidth: 80,
                            ),
                            child: Text(
                              (value["25%"] ?? "-").toString(),
                              style: ClanChurnTypography.font14600.copyWith(
                                  color: Theme.of(ctx).colorScheme.onSecondary),
                              textAlign: TextAlign.center,
                            ),
                          )),
                          DataCell(ConstrainedBox(
                            constraints: const BoxConstraints(
                              minWidth: 60,
                              maxWidth: 80,
                            ),
                            child: Text(
                              (value["50%"] ?? "-").toString(),
                              style: ClanChurnTypography.font14600.copyWith(
                                  color: Theme.of(ctx).colorScheme.onSecondary),
                              textAlign: TextAlign.center,
                            ),
                          )),
                          DataCell(ConstrainedBox(
                            constraints: const BoxConstraints(
                              minWidth: 60,
                              maxWidth: 80,
                            ),
                            child: Text(
                              (value["75%"] ?? "-").toString(),
                              style: ClanChurnTypography.font14600.copyWith(
                                  color: Theme.of(ctx).colorScheme.onSecondary),
                              textAlign: TextAlign.center,
                            ),
                          )),
                          DataCell(ConstrainedBox(
                            constraints: const BoxConstraints(
                              minWidth: 60,
                              maxWidth: 80,
                            ),
                            child: Text(
                              (value["max"] ?? "-").toString(),
                              style: ClanChurnTypography.font14600.copyWith(
                                  color: Theme.of(ctx).colorScheme.onSecondary),
                              textAlign: TextAlign.center,
                            ),
                          )),
                          DataCell(ConstrainedBox(
                            constraints: const BoxConstraints(
                              minWidth: 60,
                              maxWidth: 80,
                            ),
                            child: Text(
                              (value["std"] ?? "-").toString(),
                              style: ClanChurnTypography.font14600.copyWith(
                                  color: Theme.of(ctx).colorScheme.onSecondary),
                              textAlign: TextAlign.center,
                            ),
                          )),
                          DataCell(ConstrainedBox(
                            constraints: const BoxConstraints(
                              minWidth: 60,
                              maxWidth: 80,
                            ),
                            child: Text(
                              (value["blankCount"] ?? "-").toString(),
                              style: ClanChurnTypography.font14600.copyWith(
                                  color: Theme.of(ctx).colorScheme.onSecondary),
                              textAlign: TextAlign.center,
                            ),
                          )),
                        ]);
                  }).toList(),
                ),
              ),
            ),
            ClanChurnSpacing.h20,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                  width: 130,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.all(0),
                      side: BorderSide(
                          color: Theme.of(ctx).colorScheme.primary, width: 1.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            8), // Adjust the border radius
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Icon(Icons.cancel_outlined),
                        Text(
                          "Close",
                          style: ClanChurnTypography.font18600.copyWith(
                              color: Theme.of(ctx).colorScheme.primary),
                        ),
                      ],
                    ),
                    onPressed: () {
                      Navigator.pop(ctx);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

