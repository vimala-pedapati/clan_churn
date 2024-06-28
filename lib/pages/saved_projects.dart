// import 'package:clan_churn/components/nav_bar.dart';
// import 'package:clan_churn/components/side_bar.dart';
// import 'package:clan_churn/components/wrap_profile.dart';
// import 'package:flutter/material.dart';

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

import 'dart:math';

import 'package:clan_churn/components/reports.dart';
import 'package:clan_churn/utils/typography.dart';
import 'package:flutter/material.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';

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
