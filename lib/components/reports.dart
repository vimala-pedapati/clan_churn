import 'package:clan_churn/components/nav_bar.dart';
import 'package:clan_churn/components/side_bar.dart';
import 'package:clan_churn/components/wrap_profile.dart';
import 'package:clan_churn/utils/typography.dart';
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

final sheetRawData1 = {
  "May-22": {
    "total": 15.1608140342,
    "max": 4.8262646154,
    "min": 0,
    "median": 0.3586094118,
    "average": 0.8422674463,
    "max_performance_after_removing_3_outliers": 1.722075,
    "min_performance_after_removing_3_outliers": 0.2915407143,
    "min_higher_than_0": 0.0892857143,
    "growth_of_monthly_average": 775.5152
  },
  "Jun-22": {
    "total": 11.2866930827,
    "max": 3.5718682353,
    "min": 0,
    "median": 0.1726996154,
    "average": 0.6270385046,
    "max_performance_after_removing_3_outliers": 1.4113661111,
    "min_performance_after_removing_3_outliers": 0.2530915385,
    "min_higher_than_0": 0.0923076923,
    "growth_of_monthly_average": null
  },
  "Jul-22": {
    "total": 12.9133445443,
    "max": 2.3202428571,
    "min": 0,
    "median": 0.4497617195,
    "average": 0.7174080302,
    "max_performance_after_removing_3_outliers": 1.8397584615,
    "min_performance_after_removing_3_outliers": 0.1837889286,
    "min_higher_than_0": 0.1480769231,
    "growth_of_monthly_average": -84.7674869574
  },
  "Aug-22": {
    "total": 29.833628254,
    "max": 4.3011341176,
    "min": 0,
    "median": 1.5507414286,
    "average": 1.6574237919,
    "max_performance_after_removing_3_outliers": 3.2191161538,
    "min_performance_after_removing_3_outliers": 0.3707553571,
    "min_higher_than_0": 0.1466592308,
    "growth_of_monthly_average": null
  },
  "Sep-22": {
    "total": 28.2009900215,
    "max": 4.5326138462,
    "min": 0,
    "median": 1.2855819231,
    "average": 1.5667216679,
    "max_performance_after_removing_3_outliers": 3.4797411765,
    "min_performance_after_removing_3_outliers": 0.1230769231,
    "min_higher_than_0": 0.0970588235,
    "growth_of_monthly_average": null
  },
  "Oct-22": {
    "total": 21.5813010247,
    "max": 3.2121147059,
    "min": 0,
    "median": 1.03845125,
    "average": 1.198961168,
    "max_performance_after_removing_3_outliers": 2.5235972222,
    "min_performance_after_removing_3_outliers": 0.23333,
    "min_higher_than_0": 0.0547058824,
    "growth_of_monthly_average": 33.4676199481
  },
  "Nov-22": {
    "total": 31.8002634129,
    "max": 4.7235558824,
    "min": 0,
    "median": 1.4104557692,
    "average": 1.7666813007,
    "max_performance_after_removing_3_outliers": 3.8261364706,
    "min_performance_after_removing_3_outliers": 0.8932164286,
    "min_higher_than_0": 0.7296061538,
    "growth_of_monthly_average": null
  },
  "Dec-22": {
    "total": 25.5539279229,
    "max": 4.20436,
    "min": 0.0017857143,
    "median": 1.4783887255,
    "average": 1.4196626624,
    "max_performance_after_removing_3_outliers": 2.3277653846,
    "min_performance_after_removing_3_outliers": 0.2115384615,
    "min_higher_than_0": 0.0017857143,
    "growth_of_monthly_average": -65.8762901657
  },
  "Jan-23": {
    "total": 29.6528390255,
    "max": 4.4461515385,
    "min": 0,
    "median": 1.4707960407,
    "average": 1.6473799459,
    "max_performance_after_removing_3_outliers": 3.1545076923,
    "min_performance_after_removing_3_outliers": 0.4854028571,
    "min_higher_than_0": 0.4127153571,
    "growth_of_monthly_average": -62.5304671555
  },
  "Feb-23": {
    "total": 44.1987776102,
    "max": 7.0607794118,
    "min": 0,
    "median": 1.9945753846,
    "average": 2.455487645,
    "max_performance_after_removing_3_outliers": 4.7556011765,
    "min_performance_after_removing_3_outliers": 0.5639789286,
    "min_higher_than_0": 0.3680935294,
    "growth_of_monthly_average": null
  },
  "Mar-23": {
    "total": 24.588388867,
    "max": 3.9532317647,
    "min": 0,
    "median": 0.8563479412,
    "average": 1.3660216037,
    "max_performance_after_removing_3_outliers": 2.7398825,
    "min_performance_after_removing_3_outliers": 0.3515025,
    "min_higher_than_0": 0.2961538462,
    "growth_of_monthly_average": 28.7882011223
  },
  "Apr-23": {
    "total": 6.5145278053,
    "max": 1.6400135294,
    "min": 0,
    "median": 0.1724106197,
    "average": 0.3619182114,
    "max_performance_after_removing_3_outliers": 0.8910107692,
    "min_performance_after_removing_3_outliers": 0.2115384615,
    "min_higher_than_0": 0.1332827778,
    "growth_of_monthly_average": 28.7659589741
  },
  "May-23": {
    "total": 25.9156534504,
    "max": 5.7880552941,
    "min": 0,
    "median": 0.9500089286,
    "average": 1.439758525,
    "max_performance_after_removing_3_outliers": 3.3837492308,
    "min_performance_after_removing_3_outliers": 0.2867172222,
    "min_higher_than_0": 0.2160064706,
    "growth_of_monthly_average": 162.1898165258
  },
  "Jun-23": {
    "total": 23.374540836,
    "max": 4.8552761538,
    "min": 0,
    "median": 0.8399182353,
    "average": 1.298585602,
    "max_performance_after_removing_3_outliers": 2.8539915385,
    "min_performance_after_removing_3_outliers": 0.3727653846,
    "min_higher_than_0": 0.1269230769,
    "growth_of_monthly_average": -73.4957641323
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

String transformValue(dynamic value) {
  if (value is num) {
    return double.parse(value.toString()).toStringAsFixed(2);
  } else {
    return value;
  }
}

// DataTable widget
class PerformanceDataTable extends StatelessWidget {
  final List<String> metrics;
  final List<String> months;
  final Map<String, dynamic> data;
  final int sortColumnIndex;
  final bool sortAscending;
  // final Function(int, bool) onHeaderSort;
  final Function(int, bool) onColumnsSort;

  const PerformanceDataTable(
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
  final _subTableYController = ScrollController();
  final _columnController = ScrollController();

  @override
  void initState() {
    super.initState();
    // sheetData = sheetRawData;
    // data = sheetData['MonthlyPerformance']!;
    data = sheetRawData1;
    selectedMonths = data.keys.toList();
    selectedMonthsTemp = data.keys.toList();
    metrics = (data[selectedMonths[0]] as Map<String, dynamic>).keys.toList();
    _subTableYController.addListener(() {
      _columnController.jumpTo(_subTableYController.position.pixels);
    });
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
    print(
        "................$columnIndex.......${selectedMonths[columnIndex]}.......${selectedMonths.length}....$sortAscending....");
    Map<String, dynamic> a = data[selectedMonths[columnIndex]];
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

  Widget buildFrezeedColumn({required Function(int, bool) onHeaderSort}) =>
      Theme(
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
            sortColumnIndex: 0,
            sortAscending: sortAscending,
            showBottomBorder: true,
            headingRowColor: MaterialStateProperty.resolveWith<Color>((states) {
              return Theme.of(context).colorScheme.primary.withOpacity(0.8);
            }),
            border: TableBorder(
              left: BorderSide(
                  color:
                      Theme.of(context).colorScheme.primary.withOpacity(0.5)),
              right: BorderSide(
                  color:
                      Theme.of(context).colorScheme.primary.withOpacity(0.5)),
            ),
            headingTextStyle: ClanChurnTypography.font13600.copyWith(
                color: Theme.of(context).colorScheme.background,
                fontWeight: FontWeight.w900),
            columns: [
              // DataColumn(label: Text(""))
              DataColumn(
                label: const Text(
                  'Metrics',
                  // style: ClanChurnTypography.font13600.copyWith(
                  //   color: Theme.of(context).colorScheme.secondary,
                  // ),
                ),
                onSort: (columnIndex, ascending) =>
                    onHeaderSort(columnIndex, ascending),
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
                  // for (var month in months)
                  //   DataCell(Text(
                  //     (data[month]![metric] as dynamic)?.toString() ?? 'N/A',
                  //   )),
                ],
              );
            }).toList()),
      );

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.05),
      body: WrapProfile(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const NavBar(),
              SizedBox(height: h * 0.01),
              Row(
                children: [
                  const SideBar(
                    selectedRoute: SelectedRoute.savedReports,
                  ),
                  Text("$sortColumnIndex"),
                  AnimatedContainer(
                    duration: const Duration(seconds: 1),
                    // height: h * 0.82,
                    // width: widget.width,
                    height: MediaQuery.of(context).size.height * 0.83,
                    width: MediaQuery.of(context).size.width * 0.8,
                    margin: EdgeInsets.only(
                        left: w * 0.025, right: w * 0.025, top: 20, bottom: 20),
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 20, bottom: 10),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.background,
                        borderRadius: BorderRadius.circular(30)),
                    child: SingleChildScrollView(
                      child: Row(
                        children: [
                          SingleChildScrollView(
                              controller: _columnController,
                              scrollDirection: Axis.vertical,
                              physics: const NeverScrollableScrollPhysics(),
                              child: buildFrezeedColumn(
                                onHeaderSort: onHeaderSort,
                              )),
                          SingleChildScrollView(
                            physics: const ClampingScrollPhysics(),
                            controller: _subTableYController,
                            scrollDirection: Axis.vertical,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.57,
                              child: PerformanceDataTable(
                                metrics: metrics,
                                months: selectedMonths,
                                data: data,
                                sortColumnIndex: sortColumnIndex,
                                sortAscending: sortAscending,
                                // onHeaderSort: onHeaderSort,
                                onColumnsSort: onColumnsSort,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Filter()
                ],
              ),
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
        // height: MediaQuery.of(context).size.height,
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