import 'dart:convert';

import 'package:clan_churn/churn_blocs/project_architect/project_architect_bloc.dart';
import 'package:clan_churn/components/nav_bar.dart';
import 'package:clan_churn/components/side_bar.dart';
import 'package:clan_churn/components/wrap_profile.dart';
import 'package:clan_churn/utils/typography.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  const PerformanceReport(
      {Key? key, required this.inputId, required this.reportName})
      : super(key: key);
  final String reportName;
  final String inputId;

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
  bool fetching = false;
  bool apiError = false;
  List<String> reportNames = ["BPP-1", "BPP-2"];
  String selectedItem = "";

  @override
  void initState() {
    super.initState();
    setState(() {
      fetching = true;
      selectedItem = reportNames[0];
    });
    context.read<ProjectArchitectBloc>().add(GetReportDataEvent(
        inputId: widget.inputId,
        reportName: reportNames[0],
        onErrorCallback: (errorMessage, errorCode) {
          print(" on error $errorCode, $errorMessage");
          setState(() {
            apiError = true;
          });
        },
        onSuccessCallback: (message) {
          setState(() {
            fetching = false;
          });
          if (message != null) {
            // print("get report data: ${json.decode(message!.body)}");
            // print("get report data: ${json.decode(message.body).runtimeType}");
            // var a = json.decode(message.body);
            Map<String, dynamic> jsonObject = json.decode(message.body);
            // print(jsonObject.runtimeType);
            setState(() {
              data = jsonObject;
              selectedMonths = data.keys.toList();
              selectedMonthsTemp = data.keys.toList();
              metrics = (data[selectedMonths[0]] as Map<String, dynamic>)
                  .keys
                  .toList();
            });
            // print(".......metrics.....$metrics");
          }
        }));

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

  Widget buildFrezeedColumn({required Function(int, bool) onHeaderSort}) {
    return Theme(
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
                color: Theme.of(context).colorScheme.primary.withOpacity(0.5)),
            right: BorderSide(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.5)),
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
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return AnimatedContainer(
        duration: const Duration(seconds: 1),
        // height: h * 0.82,
        // width: widget.width,
        height: MediaQuery.of(context).size.height * 0.83,
        // width: MediaQuery.of(context).size.width * 0.7,
        // margin: EdgeInsets.only(  left: w * 0.025, right: w * 0.025, top: 20, bottom: 20),
        // padding:const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(30)),
        //   child: SingleChildScrollView(
        //     child: Row(
        //       children: [
        //         SingleChildScrollView(
        //             controller: _columnController,
        //             scrollDirection: Axis.vertical,
        //             physics: const NeverScrollableScrollPhysics(),
        //             child: buildFrezeedColumn(
        //               onHeaderSort: onHeaderSort,
        //             )),
        //         SingleChildScrollView(
        //           physics: const ClampingScrollPhysics(),
        //           controller: _subTableYController,
        //           scrollDirection: Axis.vertical,
        //           child: SizedBox(
        //             width: MediaQuery.of(context).size.width * 0.57,
        //             child: PerformanceDataTable(
        //               metrics: metrics,
        //               months: selectedMonths,
        //               data: data,
        //               sortColumnIndex: sortColumnIndex,
        //               sortAscending: sortAscending,
        //               // onHeaderSort: onHeaderSort,
        //               onColumnsSort: onColumnsSort,
        //             ),
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // );

        child: Scaffold(
          backgroundColor:
              Theme.of(context).colorScheme.primary.withOpacity(0.05),
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
                      // Text("$sortColumnIndex"),

                      Row(
                        children: [
                          AnimatedContainer(
                            duration: const Duration(seconds: 1),
                            // height: h * 0.82,
                            // width: widget.width,
                            height: MediaQuery.of(context).size.height * 0.83,
                            width: MediaQuery.of(context).size.width * 0.8,
                            margin: EdgeInsets.only(
                                left: w * 0.025,
                                right: w * 0.025,
                                top: 20,
                                bottom: 20),
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 20, bottom: 10),
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.background,
                                borderRadius: BorderRadius.circular(30)),
                            child: fetching
                                ? Center(
                                    child: Image.asset(
                                      "assets/loading.gif",
                                      width: 40,
                                      height: 40,
                                    ),
                                  )
                                : apiError
                                    ? const Center(
                                        child: Text(
                                            "Unable to fetch report data "))
                                    : SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                SizedBox(
                                                  width: 400,
                                                  child:
                                                      DropdownButtonHideUnderline(
                                                    child: DropdownButton2<String>(
                                                      isExpanded: true,
                                                      hint: Row(
                                                        children: [
                                                          Text(
                                                            'Select Column',
                                                            style:
                                                                ClanChurnTypography
                                                                    .font18500,
                                                            overflow: TextOverflow
                                                                .ellipsis,
                                                          ),
                                                        ],
                                                      ),
                                                      items: reportNames
                                                          .map(
                                                              (String item) =>
                                                                  DropdownMenuItem<
                                                                      String>(
                                                                    value: item,
                                                                    child: Text(
                                                                      item,
                                                                      style: ClanChurnTypography
                                                                          .font18500
                                                                          .copyWith(
                                                                              color: Theme.of(context)
                                                                                  .colorScheme
                                                                                  .background),
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                    ),
                                                                  ))
                                                          .toList(),
                                                      selectedItemBuilder:
                                                          (BuildContext context) {
                                                        return reportNames
                                                            .map((String item) {
                                                          return Center(
                                                            child: Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  item,
                                                                  style: ClanChurnTypography
                                                                      .font18500
                                                                      .copyWith(
                                                                          color: Theme.of(
                                                                                  context)
                                                                              .colorScheme
                                                                              .secondary),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        }).toList();
                                                      },
                                                      value: selectedItem,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          selectedItem = value!;
                                                        });
                                                        context
                                                            .read<
                                                                ProjectArchitectBloc>()
                                                            .add(GetReportDataEvent(
                                                                inputId:
                                                                    widget.inputId,
                                                                reportName: value!,
                                                                onErrorCallback:
                                                                    (errorMessage,
                                                                        errorCode) {
                                                                  print(
                                                                      " on error $errorCode, $errorMessage");
                                                                  setState(() {
                                                                    apiError = true;
                                                                  });
                                                                },
                                                                onSuccessCallback:
                                                                    (message) {
                                                                  setState(() {
                                                                    fetching =
                                                                        false;
                                                                  });
                                                                  if (message !=
                                                                      null) {
                                                                    // print("get report data: ${json.decode(message!.body)}");
                                                                    // print("get report data: ${json.decode(message.body).runtimeType}");
                                                                    // var a = json.decode(message.body);
                                                                    Map<String,
                                                                            dynamic>
                                                                        jsonObject =
                                                                        json.decode(
                                                                            message
                                                                                .body);
                                                                    // print(jsonObject.runtimeType);
                                                                    setState(() {
                                                                      data =
                                                                          jsonObject;
                                                                      selectedMonths =
                                                                          data.keys
                                                                              .toList();
                                                                      selectedMonthsTemp =
                                                                          data.keys
                                                                              .toList();
                                                                      metrics = (data[
                                                                              selectedMonths[
                                                                                  0]] as Map<
                                                                              String,
                                                                              dynamic>)
                                                                          .keys
                                                                          .toList();
                                                                    });
                                                                    // print(".......metrics.....$metrics");
                                                                  }
                                                                }));
                                                      },
                                                      buttonStyleData:
                                                          ButtonStyleData(
                                                        decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  8),
                                                          border: Border.all(
                                                              color:
                                                                  Theme.of(context)
                                                                      .colorScheme
                                                                      .primary
                                                                      .withOpacity(
                                                                          0.6)),
                                                          color: Theme.of(context)
                                                              .colorScheme
                                                              .primary
                                                              .withOpacity(0.2),
                                                        ),
                                                        elevation: 0,
                                                      ),
                                                      iconStyleData: IconStyleData(
                                                        icon: const Icon(Icons
                                                            .keyboard_arrow_down),
                                                        iconSize: 25,
                                                        iconEnabledColor:
                                                            Theme.of(context)
                                                                .colorScheme
                                                                .secondary,
                                                        iconDisabledColor:
                                                            Colors.grey,
                                                      ),
                                                      dropdownStyleData:
                                                          DropdownStyleData(
                                                        elevation: 0,
                                                        decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  8),
                                                          border: Border.all(
                                                              color:
                                                                  Theme.of(context)
                                                                      .colorScheme
                                                                      .primary
                                                                      .withOpacity(
                                                                          0.6)),
                                                          color: Theme.of(context)
                                                              .colorScheme
                                                              .primary
                                                              .withOpacity(1.0),
                                                        ),
                                                        scrollbarTheme:
                                                            ScrollbarThemeData(
                                                          radius:
                                                              const Radius.circular(
                                                                  40),
                                                          thickness:
                                                              MaterialStateProperty
                                                                  .all(6),
                                                          thumbVisibility:
                                                              MaterialStateProperty
                                                                  .all(true),
                                                        ),
                                                      ),
                                                      menuItemStyleData:
                                                          const MenuItemStyleData(
                                                        height: 40,
                                                        padding: EdgeInsets.only(
                                                            left: 14, right: 14),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 10,),
                                            Row(
                                              children: [
                                                buildFrezeedColumn(
                                                  onHeaderSort: onHeaderSort,
                                                ),
                                                Expanded(
                                                  child: PerformanceDataTable(
                                                    metrics: metrics,
                                                    months: selectedMonths,
                                                    data: data,
                                                    sortColumnIndex:
                                                        sortColumnIndex,
                                                    sortAscending:
                                                        sortAscending,
                                                    // onHeaderSort: onHeaderSort,
                                                    onColumnsSort:
                                                        onColumnsSort,
                                                  ),
                                                ),
                                              ],
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
        ));
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
