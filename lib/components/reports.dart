import 'package:clan_churn/utils/typography.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

final sheetRawData = {
  "MonthlyPerformance": {
    "May-22": {
      "Month_MIN_Performance": "0%",
      "Month_MAX_Performance": "1409%",
      "Month_MEDIAN_Performance": "0%",
      "Monthly_max_performance_after_removing_3_outliers": "1172%",
      "Month_Min_Performance_(higher_than_0%)": "0%",
      "Performance_Multiplier": 1303,
      "Indexed_Month/average_Performance_(%May22Performance=100)": 100,
      "Growth_of_Monthly_avg_Performance_%_prev_month": "0%",
      "Head_count_(Entries_without_duplicates_that_month)": 2831,
      "Total_Zero_Performs": 1860,
      "Total_Non_Zero_Performs": 971,
      "Zero_performance_%_of_head_count": "66%",
      "Month_AVERAGE_Performance": "71%",
    },
    "Jun-22": {
      "Month_MIN_Performance": "0%",
      "Month_AVERAGE_Performance": "68%",
      "Month_MAX_Performance": "2451%",
      "Month_MEDIAN_Performance": "0%",
      "Monthly_max_performance_after_removing_3_outliers": "2060%",
      "Month_Min_Performance_(higher_than_0%)": "0%",
      "Performance_Multiplier": 3708,
      "Indexed_Month/average_Performance_(%May22Performance=100)": 97,
      "Growth_of_Monthly_avg_Performance_%_prev_month": "-5%",
      "Head_count_(Entries_without_duplicates_that_month)": 2982,
      "Total_Zero_Performs": 1923,
      "Total_Non_Zero_Performs": 1059,
      "Zero_performance_%_of_head_count": "64%"
    },
    "Jul-22": {
      "Month_MIN_Performance": "0%",
      "Month_AVERAGE_Performance": "78%",
      "Month_MAX_Performance": "2172%",
      "Month_MEDIAN_Performance": "0%",
      "Monthly_max_performance_after_removing_3_outliers": "1518%",
      "Month_Min_Performance_(higher_than_0%)": "0%",
      "Performance_Multiplier": 3725,
      "Indexed_Month/average_Performance_(%May22Performance=100)": 110,
      "Growth_of_Monthly_avg_Performance_%_prev_month": "14%",
      "Head_count_(Entries_without_duplicates_that_month)": 2827,
      "Total_Zero_Performs": 1589,
      "Total_Non_Zero_Performs": 1238,
      "Zero_performance_%_of_head_count": "56%"
    },
    "Aug-22": {
      "Month_MIN_Performance": "0%",
      "Month_AVERAGE_Performance": "121%",
      "Month_MAX_Performance": "2223%",
      "Month_MEDIAN_Performance": "0%",
      "Monthly_max_performance_after_removing_3_outliers": "1356%",
      "Month_Min_Performance_(higher_than_0%)": "0%",
      "Performance_Multiplier": 6143,
      "Indexed_Month/average_Performance_(%May22Performance=100)": 190,
      "Growth_of_Monthly_avg_Performance_%_prev_month": "75%",
      "Head_count_(Entries_without_duplicates_that_month)": 2882,
      "Total_Zero_Performs": 1489,
      "Total_Non_Zero_Performs": 1393,
      "Zero_performance_%_of_head_count": "52%"
    },
    "Sep-22": {
      "Month_MIN_Performance": "0%",
      "Month_AVERAGE_Performance": "134%",
      "Month_MAX_Performance": "3322%",
      "Month_MEDIAN_Performance": "0%",
      "Monthly_max_performance_after_removing_3_outliers": "2194%",
      "Month_Min_Performance_(higher_than_0%)": "0%",
      "Performance_Multiplier": 180099,
      "Indexed_Month/average_Performance_(%May22Performance=100)": 176,
      "Growth_of_Monthly_avg_Performance_%_prev_month": "45%",
      "Head_count_(Entries_without_duplicates_that_month)": 2948,
      "Total_Zero_Performs": 1488,
      "Total_Non_Zero_Performs": 1460,
      "Zero_performance_%_of_head_count": "50%"
    },
    "Oct-22": {
      "Month_MIN_Performance": "0%",
      "Month_AVERAGE_Performance": "124%",
      "Month_MAX_Performance": "2291%",
      "Month_MEDIAN_Performance": "0%",
      "Monthly_max_performance_after_removing_3_outliers": "2164%",
      "Month_Min_Performance_(higher_than_0%)": "0%",
      "Performance_Multiplier": 180809,
      "Indexed_Month/average_Performance_(%May22Performance=100)": 155,
      "Growth_of_Monthly_avg_Performance_%_prev_month": "-12%",
      "Head_count_(Entries_without_duplicates_that_month)": 3097,
      "Total_Zero_Performs": 1545,
      "Total_Non_Zero_Performs": 1552,
      "Zero_performance_%_of_head_count": "50%"
    },
    "Nov-22": {
      "Month_MIN_Performance": "0%",
      "Month_AVERAGE_Performance": "109%",
      "Month_MAX_Performance": "2466%",
      "Month_MEDIAN_Performance": "0%",
      "Monthly_max_performance_after_removing_3_outliers": "1808%",
      "Month_Min_Performance_(higher_than_0%)": "0%",
      "Performance_Multiplier": 73244,
      "Indexed_Month/average_Performance_(%May22Performance=100)": 160,
      "Growth_of_Monthly_avg_Performance_%_prev_month": "3%",
      "Head_count_(Entries_without_duplicates_that_month)": 3328,
      "Total_Zero_Performs": 1772,
      "Total_Non_Zero_Performs": 1556,
      "Zero_performance_%_of_head_count": "47%"
    },
    "Dec-22": {
      "Month_MIN_Performance": "0%",
      "Month_AVERAGE_Performance": "113%",
      "Month_MAX_Performance": "2031%",
      "Month_MEDIAN_Performance": "0%",
      "Monthly_max_performance_after_removing_3_outliers": "1534%",
      "Month_Min_Performance_(higher_than_0%)": "0%",
      "Performance_Multiplier": 10758,
      "Indexed_Month/average_Performance_(%May22Performance=100)": 137,
      "Growth_of_Monthly_avg_Performance_%_prev_month": "-14%",
      "Head_count_(Entries_without_duplicates_that_month)": 3462,
      "Total_Zero_Performs": 1853,
      "Total_Non_Zero_Performs": 1609,
      "Zero_performance_%_of_head_count": "54%"
    },
    "Jan-23": {
      "Month_MIN_Performance": "0%",
      "Month_AVERAGE_Performance": "97%",
      "Month_MAX_Performance": "2070%",
      "Month_MEDIAN_Performance": "0%",
      "Monthly_max_performance_after_removing_3_outliers": "1589%",
      "Month_Min_Performance_(higher_than_0%)": "0%",
      "Performance_Multiplier": 4448,
      "Indexed_Month/average_Performance_(%May22Performance=100)": 120,
      "Growth_of_Monthly_avg_Performance_%_prev_month": "25%",
      "Head_count_(Entries_without_duplicates_that_month)": 5283,
      "Total_Zero_Performs": 2402,
      "Total_Non_Zero_Performs": 2881,
      "Zero_performance_%_of_head_count": "45%"
    },
    "Feb-23": {
      "Month_MIN_Performance": "0%",
      "Month_AVERAGE_Performance": "121%",
      "Month_MAX_Performance": "2225%",
      "Month_MEDIAN_Performance": "0%",
      "Monthly_max_performance_after_removing_3_outliers": "1816%",
      "Month_Min_Performance_(higher_than_0%)": "0%",
      "Performance_Multiplier": 30867,
      "Indexed_Month/average_Performance_(%May22Performance=100)": 172,
      "Growth_of_Monthly_avg_Performance_%_prev_month": "0%",
      "Head_count_(Entries_without_duplicates_that_month)": 3697,
      "Total_Zero_Performs": 1745,
      "Total_Non_Zero_Performs": 1952,
      "Zero_performance_%_of_head_count": "47%"
    },
    "Mar-23": {
      "Month_MIN_Performance": "0%",
      "Month_AVERAGE_Performance": "46%",
      "Month_MAX_Performance": "2854%",
      "Month_MEDIAN_Performance": "0%",
      "Monthly_max_performance_after_removing_3_outliers": "2408%",
      "Month_Min_Performance_(higher_than_0%)": "0%",
      "Performance_Multiplier": 33718,
      "Indexed_Month/average_Performance_(%May22Performance=100)": 65,
      "Growth_of_Monthly_avg_Performance_%_prev_month": "-62%",
      "Head_count_(Entries_without_duplicates_that_month)": 3874,
      "Total_Zero_Performs": 1923,
      "Total_Non_Zero_Performs": 1951,
      "Zero_performance_%_of_head_count": "50%"
    },
    "Apr-23": {
      "Month_MIN_Performance": "0%",
      "Month_AVERAGE_Performance": "71%",
      "Month_MAX_Performance": "1787%",
      "Month_MEDIAN_Performance": "0%",
      "Monthly_max_performance_after_removing_3_outliers": "1277%",
      "Month_Min_Performance_(higher_than_0%)": "0%",
      "Performance_Multiplier": 11496,
      "Indexed_Month/average_Performance_(%May22Performance=100)": 101,
      "Growth_of_Monthly_avg_Performance_%_prev_month": "56%",
      "Head_count_(Entries_without_duplicates_that_month)": 3965,
      "Total_Zero_Performs": 1655,
      "Total_Non_Zero_Performs": 2310,
      "Zero_performance_%_of_head_count": "42%"
    },
    "May-23": {
      "Month_MIN_Performance": "0%",
      "Month_AVERAGE_Performance": "78%",
      "Month_MAX_Performance": "2233%",
      "Month_MEDIAN_Performance": "0%",
      "Monthly_max_performance_after_removing_3_outliers": "1382%",
      "Month_Min_Performance_(higher_than_0%)": "0%",
      "Performance_Multiplier": 5046,
      "Indexed_Month/average_Performance_(%May22Performance=100)": 111,
      "Growth_of_Monthly_avg_Performance_%_prev_month": "9%",
      "Head_count_(Entries_without_duplicates_that_month)": 4235,
      "Total_Zero_Performs": 1951,
      "Total_Non_Zero_Performs": 2281,
      "Zero_performance_%_of_head_count": "53%"
    },
    "Jun-23": {
      "Month_MIN_Performance": "0%",
      "Month_AVERAGE_Performance": "97%",
      "Month_MAX_Performance": "2256%",
      "Month_MEDIAN_Performance": "0%",
      "Monthly_max_performance_after_removing_3_outliers": "1494%",
      "Month_Min_Performance_(higher_than_0%)": "0%",
      "Performance_Multiplier": 5744,
      "Indexed_Month/average_Performance_(%May22Performance=100)": 111,
      "Growth_of_Monthly_avg_Performance_%_prev_month": "6%",
      "Head_count_(Entries_without_duplicates_that_month)": 4507,
      "Total_Zero_Performs": 2362,
      "Total_Non_Zero_Performs": 2145,
      "Zero_performance_%_of_head_count": "52%"
    }
  },
  "Averages": {
    "Head_count_(Entries_without_duplicates_that_month)": 3566,
    "Total_Zero_Performs": 1884,
    "Total_Non_Zero_Performs": 1682,
    "Zero_performance_%_of_head_count": "53%"
  },
  "Max_Min": {
    "max": {
      "Month_AVERAGE_Performance": "134%",
      "Indexed_Month/average_Performance_(%May22Performance=100)": 190,
      "Growth_of_Monthly_avg_Performance_%_prev_month": "56%",
      "Head_count_(Entries_without_duplicates_that_month)": 5283,
      "Total_Zero_Performs": 2402,
      "Zero_performance_%_of_head_count": "67%"
    },
    "min": {
      "Month_AVERAGE_Performance": "46%",
      "Indexed_Month/average_Performance_(%May22Performance=100)": 65,
      "Growth_of_Monthly_avg_Performance_%_prev_month": "-62%",
      "Head_count_(Entries_without_duplicates_that_month)": 2827,
      "Total_Zero_Performs": 1488,
      "Zero_performance_%_of_head_count": "42%"
    }
  },
  "Insights": {
    "average_calendar_month_performance_variation":
        "71% to 121% between May-22 and Jun-23",
    "average_calendar_month_performance_dip": "44% in Apr-23",
    "zero_performance_any_month_percentage": "53%"
  }
};

// Utility functions for data parsing and sorting
int compareValues(dynamic value1, dynamic value2) {
  double v1 = parseValue(value1);
  double v2 = parseValue(value2);
  return v1.compareTo(v2);
}

double parseValue(dynamic value) {
  if (value is String) {
    value = value.replaceAll('%', '').replaceAll(',', '');
    return double.tryParse(value) ?? 0.0;
  } else if (value is num) {
    return value.toDouble();
  } else {
    return 0.0;
  }
}

// Dropdown and Checkbox widgets
class MonthSelector extends StatelessWidget {
  final List<String> months;
  final List<String> selectedMonths;
  final Function(String) onMonthSelected;
  final Function(String) onToggleMonth;

  MonthSelector({
    required this.months,
    required this.selectedMonths,
    required this.onMonthSelected,
    required this.onToggleMonth,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          isExpanded: true,
          hint: Text(
            'Select Months',
            style: ClanChurnTypography.font18500,
            overflow: TextOverflow.ellipsis,
          ),
          items: months
              .map((String item) => DropdownMenuItem<String>(
                    value: item,
                    child: Row(
                      children: [
                        SizedBox(
                          height: 20,
                          width: 20,
                          child: Checkbox(
                            value: selectedMonths.contains(item),
                            side: BorderSide(
                              color: Theme.of(context).colorScheme.background,
                              width: 2,
                            ),
                            onChanged: (value) => onToggleMonth(item),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          item,
                          style: ClanChurnTypography.font18500.copyWith(
                            color: Theme.of(context).colorScheme.background,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ))
              .toList(),
          value: selectedMonths.isNotEmpty ? selectedMonths[0] : null,
          onChanged: (value) => onMonthSelected(value!),
          selectedItemBuilder: (BuildContext context) =>
              months.map((String item) {
            return Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item,
                    style: ClanChurnTypography.font18500.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          buttonStyleData: ButtonStyleData(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.6),
                width: 2,
              ),
              color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
            ),
            elevation: 0,
          ),
          iconStyleData: IconStyleData(
            icon: const Icon(Icons.keyboard_arrow_down),
            iconSize: 25,
            iconEnabledColor: Theme.of(context).colorScheme.secondary,
            iconDisabledColor: Colors.grey,
          ),
          dropdownStyleData: DropdownStyleData(
            elevation: 0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.6),
                width: 2,
              ),
              color: Theme.of(context).colorScheme.primary.withOpacity(1.0),
            ),
            scrollbarTheme: ScrollbarThemeData(
              radius: const Radius.circular(40),
              thickness: MaterialStateProperty.all(6),
              thumbVisibility: MaterialStateProperty.all(true),
            ),
          ),
          menuItemStyleData: const MenuItemStyleData(
            height: 40,
            padding: EdgeInsets.only(left: 14, right: 14),
          ),
        ),
      ),
    );
  }
}

// DataTable widget
class PerformanceDataTable extends StatelessWidget {
  final List<String> metrics;
  final List<String> months;
  final Map<String, dynamic> data;
  final int sortColumnIndex;
  final bool sortAscending;
  final Function(int, bool) onHeaderSort;
  final Function(int, bool) onColumnsSort;

  const PerformanceDataTable(
      {super.key,
      required this.metrics,
      required this.months,
      required this.data,
      required this.sortColumnIndex,
      required this.sortAscending,
      required this.onHeaderSort,
      required this.onColumnsSort});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerTheme: const DividerThemeData(color: Colors.transparent),
        ),
        child: DataTable(
          dividerThickness: 1.0,
          horizontalMargin: 15,
          columnSpacing: 10,
          dataRowMaxHeight: 40,
          dataRowMinHeight: 40,
          sortColumnIndex: sortColumnIndex,
          sortAscending: sortAscending,
          border: const TableBorder(
            horizontalInside: BorderSide.none,
          ),
          columns: [
            DataColumn(
              label: Text(
                'Metrics',
                style: ClanChurnTypography.font13600.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              onSort: (columnIndex, ascending) =>
                  onHeaderSort(columnIndex, ascending),
            ),
            for (var month in months)
              DataColumn(
                label: Text(
                  month,
                  style: ClanChurnTypography.font13600.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
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
                DataCell(Text(metric)),
                for (var month in months)
                  DataCell(Text(
                    (data[month]![metric] as dynamic)?.toString() ?? 'N/A',
                  )),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}

// Main widget integrating all modules
class PerformanceReport extends StatefulWidget {
  const PerformanceReport({Key? key}) : super(key: key);

  @override
  State<PerformanceReport> createState() => _PerformanceReportState();
}

class _PerformanceReportState extends State<PerformanceReport> {
  Map<String, Map<String, dynamic>> sheetData = {};
  Map<String, dynamic> data = {};
  List<String> selectedMonths = [];
  List<String> selectedMonthsTemp = [];
  List<String> metrics = [];
  int sortColumnIndex = 0;
  bool sortAscending = true;

  @override
  void initState() {
    super.initState();
    sheetData = sheetRawData;
    data = sheetData['MonthlyPerformance']!;
    selectedMonths = sheetData['MonthlyPerformance']!.keys.toList();
    selectedMonthsTemp = sheetData['MonthlyPerformance']!.keys.toList();
    metrics = (data[selectedMonths[0]] as Map<String, dynamic>).keys.toList();
  }

  void onMonthSelected(String month) {
    setState(() {
      selectedMonths = [month];
    });
  }

  void onToggleMonth(String month) {
    setState(() {
      if (selectedMonths.contains(month)) {
        selectedMonths.remove(month);
      } else {
        selectedMonths.add(month);
      }
    });
  }

  void onHeaderSort(int columnIndex, bool ascending) {
    setState(() {
      sortColumnIndex = columnIndex;
      sortAscending = ascending;
    });
    if (ascending) {
      setState(() {
        metrics.sort((a, b) => a.compareTo(b));
      });
    } else {
      setState(() {
        metrics.sort((b, a) => a.compareTo(b));
      });
    }
  }

  void onColumnsSort(int columnIndex, bool ascending) {
    setState(() {
      sortColumnIndex = columnIndex;
      sortAscending = ascending;
    });
    Map<String, dynamic> a = data[selectedMonths[columnIndex - 1]];
    if (ascending) {
      setState(() {
        metrics = Map.fromEntries(a.entries.toList()
              ..sort((a, b) => compareValues(a.value, b.value)))
            .keys
            .toList();
      });
    } else {
      setState(() {
        metrics = Map.fromEntries(a.entries.toList()
              ..sort((b, a) => compareValues(a.value, b.value)))
            .keys
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  // MonthSelector(
                  //   months: sheetData['MonthlyPerformance']!.keys.toList(),
                  //   selectedMonths: selectedMonths,
                  //   onMonthSelected: onMonthSelected,
                  //   onToggleMonth: onToggleMonth,
                  // ),
                  PerformanceDataTable(
                    metrics: metrics,
                    months: selectedMonths,
                    data: data,
                    sortColumnIndex: sortColumnIndex,
                    sortAscending: sortAscending,
                    onHeaderSort: onHeaderSort,
                    onColumnsSort: onColumnsSort,
                  ),
                ],
              ),
              const Filter()
            ],
          ),
        ),
      ),
      endDrawer: Drawer(
          width: MediaQuery.of(context).size.width * 0.21,
          child: GetDrawer(
            months: selectedMonths,
            updateMonthsData: (updatedData) {
              setState(() {
                if (updatedData.isNotEmpty) {
                  selectedMonths = updatedData;
                }
              });
            },
            monthsStore: selectedMonthsTemp,
          )),
    );
  }
}

class Filter extends StatelessWidget {
  const Filter({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Scaffold.of(context).openEndDrawer();
      },
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: 38,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            border: Border(
          left: BorderSide(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
              width: 2),
          top: BorderSide(color: Theme.of(context).colorScheme.primary),
          bottom: BorderSide(color: Theme.of(context).colorScheme.primary),
        )),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const ColoredBox(
                color: Colors.transparent,
                child: Icon(Icons.filter_alt_outlined)),
            ColoredBox(
              color: Colors.transparent,
              child: RotatedBox(
                  quarterTurns: 3,
                  child: Text(
                    "Filters",
                    style: ClanChurnTypography.font24600.copyWith(height: 1),
                  )),
            ),
          ],
        )),
      ),
    );
  }
}

class GetDrawer extends StatefulWidget {
  GetDrawer(
      {super.key,
      required this.months,
      required this.updateMonthsData,
      required this.monthsStore});
  List<String> months;
  final List<String> monthsStore;
  final Function(List<String> updatedData) updateMonthsData;

  @override
  State<GetDrawer> createState() => _GetDrawerState();
}

class _GetDrawerState extends State<GetDrawer> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Text(
            'Choose columns to filter',
            style: ClanChurnTypography.font18600,
          ),
          trailing: TextButton(
            onPressed: () {
              setState(() {
                widget.months = widget.monthsStore;
              });
            },
            child: const Text(
              "Reset",
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
                        backgroundColor: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100.0),
                          side: const BorderSide(
                              width: 0, color: Colors.transparent),
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
                        label: Text(item,
                            style: ClanChurnTypography.font14400.copyWith(
                                height: 1,
                                color: Theme.of(context).colorScheme.primary))),
                  ))
              .toList(),
        )
      ],
    );
  }
}
