// import 'package:clan_churn/components/nav_bar.dart';
// import 'package:clan_churn/components/side_bar.dart';
// import 'package:clan_churn/components/wrap_profile.dart';
// import 'package:flutter/material.dart';
import 'dart:math';

import 'package:clan_churn/components/reports.dart';
import 'package:clan_churn/utils/typography.dart';
import 'package:flutter/material.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
// class SavedProjects extends StatelessWidget {
//   const SavedProjects({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final h = MediaQuery.of(context).size.height;
//     // final w = MediaQuery.of(context).size.width;
//     return Scaffold(
//       backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.05),
//       body: WrapProfile(
//         child: Column(children: [
//           const NavBar(),
//           SizedBox(height: h * 0.01),
//           const Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SideBar(
//                 selectedRoute: SelectedRoute.savedReports,
//               )
//             ],
//           )
//         ]),
//       ),
//     );
//   }
// }
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



class DataTablePage extends StatefulWidget {
  const DataTablePage({Key? key}) : super(key: key);

  @override
  State<DataTablePage> createState() => _DataTablePageState();
}

class _DataTablePageState extends State<DataTablePage> {
  Map<String, Map<String, dynamic>> sheetData = {};
  Map<String, dynamic> data = {};
  List<String> selectedMonths = [];
  List<String> selectedMonthsTemp = [];
  List<String> metrics = [];
  int sortColumnIndex = 0;
  bool sortAscending = true;
  List<List> rowsCells = [
    [7, 8, 10, 8, 7],
    [10, 10, 9, 6, 6],
    [5, 4, 5, 7, 5],
    [9, 4, 1, 7, 8],
    [7, 8, 10, 8, 7],
    [10, 10, 9, 6, 6],
    [5, 4, 5, 7, 5],
    [9, 4, 1, 7, 8],
    [7, 8, 10, 8, 7],
    [10, 10, 9, 6, 6],
    [5, 4, 5, 7, 5],
    [9, 4, 1, 7, 8],
    [7, 8, 10, 8, 7],
    [10, 10, 9, 6, 6],
    [5, 4, 5, 7, 5],
    [9, 4, 1, 7, 8]
  ];
  List<String> fixedColCells = [
    "Pablo",
    "Gustavo",
    "John",
    "Jack",
    "Pablo",
    "Gustavo",
    "John",
    "Jack",
    "Pablo",
    "Gustavo",
    "John",
    "Jack",
    "Pablo",
    "Gustavo",
    "John",
    "Jack",
  ];
  List<String> fixedRowCells = [
    "Math",
    "Informatics",
    "Geography",
    "Physics",
    "Biology"
  ];

  @override
  void initState() {
    super.initState();
    sheetData = sheetRawData;
    data = sheetData['MonthlyPerformance']!;
    selectedMonths = sheetData['MonthlyPerformance']!.keys.toList();
    selectedMonthsTemp = sheetData['MonthlyPerformance']!.keys.toList();
    metrics = (data[selectedMonths[0]] as Map<String, dynamic>).keys.toList();
    fixedRowCells = selectedMonthsTemp;
    fixedColCells = metrics;
    rowsCells = [];
    for (var i in metrics) {
      rowsCells.add([]);
      for (var j in selectedMonths) {
        rowsCells[metrics.indexOf(i)].add(data[j][i]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomDataTable(
              fixedCornerCell: findLongestString(metrics),
              borderColor: Colors.grey.shade300,
              rowsCells: rowsCells,
              fixedColCells: fixedColCells,
              fixedRowCells: fixedRowCells,
            ),
          ),
        ),
      ),
    );
  }
}

class CustomDataTable<T> extends StatefulWidget {
  final T fixedCornerCell;
  final List<T> fixedColCells;
  final List<T> fixedRowCells;
  final List<List<T>> rowsCells;
  final double fixedColWidth;
  final double cellWidth;
  final double cellHeight;
  final double cellMargin;
  final double cellSpacing;
  final Color borderColor;

  const CustomDataTable({
    super.key,
    required this.fixedCornerCell,
    required this.fixedColCells,
    required this.fixedRowCells,
    required this.rowsCells,
    this.fixedColWidth = 60.0,
    this.cellHeight = 56.0,
    this.cellWidth = 120.0,
    this.cellMargin = 10.0,
    this.cellSpacing = 10.0,
    required this.borderColor,
  });

  @override
  State<StatefulWidget> createState() => CustomDataTableState();
}

class CustomDataTableState<T> extends State<CustomDataTable<T>> {
  final _columnController = ScrollController();
  final _rowController = ScrollController();
  final _subTableYController = ScrollController();
  final _subTableXController = ScrollController();

  Widget _buildChild(T data) => Row(
        children: [
          SizedBox(
            child: Text(
              '$data',
              textAlign: TextAlign.center,
            ),
          ),
        ],
      );

  TableBorder _buildBorder({
    bool top = false,
    bool left = false,
    bool right = false,
    bool bottom = false,
    bool verticalInside = false,
  }) {
    return TableBorder(
      top: top ? BorderSide(color: widget.borderColor) : BorderSide.none,
      left: left ? BorderSide(color: widget.borderColor) : BorderSide.none,
      right: right ? BorderSide(color: widget.borderColor) : BorderSide.none,
      bottom: bottom ? BorderSide(color: widget.borderColor) : BorderSide.none,
      verticalInside: verticalInside
          ? BorderSide(color: widget.borderColor)
          : BorderSide.none,
    );
  }

  Widget _buildFixedCol() => DataTable(
      border: _buildBorder(right: true, left: true, bottom: true),
      columns: [
        DataColumn(label: Text(""))
        ],
      rows: widget.fixedColCells
          .map((c) => DataRow(cells: [DataCell(_buildChild(c))]))
          .toList());

  Widget _buildFixedRow() => DataTable(
        border: _buildBorder(
            verticalInside: true,
            bottom: true,
            right: true,
            left: true,
            top: true),
        columns: widget.fixedRowCells
            .map(
              (c) => DataColumn(
                label: _buildChild(
                  c,
                ),
              ),
            )
            .toList(),
        rows: const [],
      );

  Widget _buildSubTable() => DataTable(
      border: _buildBorder(verticalInside: true, bottom: true, right: true),
  columns: [
            DataColumn(
              label: Text(
                'Metrics',
                style: ClanChurnTypography.font13600.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              // onSort: (columnIndex, ascending) =>  onHeaderSort(columnIndex, ascending),
            ),
            for (var month in widget.fixedRowCells)
              DataColumn(
                label: Text(
                  "$month",
                  style: ClanChurnTypography.font13600.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                // onSort: (columnIndex, ascending) =>  onColumnsSort(columnIndex, ascending),
              ),
          ],


      rows: widget.fixedColCells.map((metric) {
        Map<String, Map<String, dynamic>> sheetData = {};
        Map<String, dynamic> data = {};
        sheetData = sheetRawData;
        data = sheetData['MonthlyPerformance']!;
        return DataRow(
          color: MaterialStateProperty.resolveWith<Color>((states) {
            int index = widget.fixedColCells.indexOf(metric);
            return index % 2 == 0
                ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
                : Colors.transparent;
          }),
          cells: [
            DataCell(Text("$metric")),
            for (var month in widget.fixedRowCells)
              DataCell(Text(
                    (data[month]![metric] as dynamic)?.toString() ?? 'N/A',
                  )),
          ],
        );
      }).toList());

  Widget _buildCornerCell() => DataTable(
        border: _buildBorder(bottom: true, right: true, top: true, left: true),
        columns: [
          DataColumn(
            label: _buildChild(
              widget.fixedCornerCell,
            ),
          )
        ],
        rows: const [],
      );
  final User _user = User();
  @override
  void initState() {
    super.initState();
    _user.initData(100);
    _subTableXController.addListener(() {
      _rowController.jumpTo(_subTableXController.position.pixels);
    });
    _subTableYController.addListener(() {
      _columnController.jumpTo(_subTableYController.position.pixels);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text("${widget.fixedColCells}"),
          Text("${widget.fixedColCells.length}"),
          Row(
            children: [
              // _buildCornerCell(),
              // SingleChildScrollView(
              //   controller: _rowController,
              //   scrollDirection: Axis.horizontal,
              //   physics: const NeverScrollableScrollPhysics(),
              //   child: _buildFixedRow(),
              // ),
            ],
          ),
          Row(
            children: [
              /// frezed table
              SingleChildScrollView(
                controller: _columnController,
                scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
                child: _buildFixedCol(),
              ),
              /// scrollable data table
              Flexible(
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  controller: _subTableXController,
                  scrollDirection: Axis.horizontal,
                  child: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    controller: _subTableYController,
                    scrollDirection: Axis.vertical,
                    child: _buildSubTable(),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Widget build(BuildContext context) {
  //   return SimpleTableSortPage(
  //     user: _user,
  //   );
  // }
}

String findLongestString(List<String> strings) {
  if (strings.isEmpty) {
    return '';
  }

  String longest = strings[0];

  for (String s in strings) {
    if (s.length > longest.length) {
      longest = s;
    }
  }

  return "$longest  ";
}

class SimpleTableSortPage extends StatefulWidget {
  const SimpleTableSortPage({
    Key? key,
    required this.user,
  }) : super(key: key);
  final User user;

  @override
  State<SimpleTableSortPage> createState() => _SimpleTableSortPageState();
}

class _SimpleTableSortPageState extends State<SimpleTableSortPage> {
  static const int sortName = 0;
  static const int sortStatus = 1;
  bool isAscending = true;
  int sortType = sortName;

  @override
  void initState() {
    widget.user.initData(100);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sortable Table')),
      body: HorizontalDataTable(
        leftHandSideColumnWidth: 100,
        rightHandSideColumnWidth: 600,
        isFixedHeader: true,
        headerWidgets: _getTitleWidget(),
        leftSideItemBuilder: _generateFirstColumnRow,
        rightSideItemBuilder: _generateRightHandSideColumnRow,
        itemCount: widget.user.userInfo.length,
        rowSeparatorWidget: const Divider(
          color: Colors.black54,
          height: 1.0,
          thickness: 0.0,
        ),
        leftHandSideColBackgroundColor: const Color(0xFFFFFFFF),
        rightHandSideColBackgroundColor: const Color(0xFFFFFFFF),
      ),
    );
  }

  List<Widget> _getTitleWidget() {
    return [
      TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        child: _getTitleItemWidget(
            'Name${sortType == sortName ? (isAscending ? '↓' : '↑') : ''}',
            100),
        onPressed: () {
          sortType = sortName;
          isAscending = !isAscending;
          widget.user.sortName(isAscending);
          setState(() {});
        },
      ),
      TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        child: _getTitleItemWidget(
            'Status${sortType == sortStatus ? (isAscending ? '↓' : '↑') : ''}',
            100),
        onPressed: () {
          sortType = sortStatus;
          isAscending = !isAscending;
          widget.user.sortStatus(isAscending);
          setState(() {});
        },
      ),
      _getTitleItemWidget('Phone', 200),
      _getTitleItemWidget('Register', 100),
      _getTitleItemWidget('Termination', 200),
    ];
  }

  Widget _getTitleItemWidget(String label, double width) {
    return Container(
      width: width,
      height: 56,
      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
      child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  Widget _generateFirstColumnRow(BuildContext context, int index) {
    return Container(
      width: 100,
      height: 52,
      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
      child: Text(widget.user.userInfo[index].name),
    );
  }

  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    return Row(
      children: <Widget>[
        Container(
          width: 100,
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
          child: Row(
            children: <Widget>[
              Icon(
                  widget.user.userInfo[index].status
                      ? Icons.notifications_off
                      : Icons.notifications_active,
                  color: widget.user.userInfo[index].status
                      ? Colors.red
                      : Colors.green),
              Text(widget.user.userInfo[index].status ? 'Disabled' : 'Active')
            ],
          ),
        ),
        Container(
          width: 200,
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
          child: Text(widget.user.userInfo[index].phone),
        ),
        Container(
          width: 100,
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
          child: Text(widget.user.userInfo[index].registerDate),
        ),
        Container(
          width: 200,
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
          child: Text(widget.user.userInfo[index].terminationDate),
        ),
      ],
    );
  }
}

class User {
  List<UserInfo> userInfo = [];

  void initData(int size) {
    userInfo.clear();
    Random random = Random();
    for (int i = 0; i < size; i++) {
      userInfo.add(UserInfo(
          "User_$i", random.nextBool(), '+001 9999 9999', '2019-01-01', 'N/A'));
    }
  }

  ///
  /// Single sort, sort Name's id
  void sortName(bool isAscending) {
    userInfo.sort((a, b) {
      int aId = int.tryParse(a.name.replaceFirst('User_', '')) ?? 0;
      int bId = int.tryParse(b.name.replaceFirst('User_', '')) ?? 0;
      return (aId - bId) * (isAscending ? 1 : -1);
    });
  }

  ///
  /// sort with Status and Name as the 2nd Sort
  void sortStatus(bool isAscending) {
    userInfo.sort((a, b) {
      if (a.status == b.status) {
        int aId = int.tryParse(a.name.replaceFirst('User_', '')) ?? 0;
        int bId = int.tryParse(b.name.replaceFirst('User_', '')) ?? 0;
        return (aId - bId);
      } else if (a.status) {
        return isAscending ? 1 : -1;
      } else {
        return isAscending ? -1 : 1;
      }
    });
  }
}

class UserInfo {
  String name;
  bool status;
  String phone;
  String registerDate;
  String terminationDate;

  UserInfo(this.name, this.status, this.phone, this.registerDate,
      this.terminationDate);

  dynamic get(String fieldName) {
    if (fieldName == 'Name') {
      return name;
    } else if (fieldName == 'Status') {
      return status;
    } else if (fieldName == 'Phone') {
      return phone;
    } else if (fieldName == 'Register') {
      return registerDate;
    } else if (fieldName == 'Termination') {
      return terminationDate;
    }
    throw Exception('Invalid field name');
  }
}

class UserColumnInfo {
  final String name;
  final double width;
  const UserColumnInfo(this.name, this.width);
}
