import 'dart:convert';

import 'package:clan_churn/churn_blocs/project_architect/project_architect_bloc.dart';
import 'package:clan_churn/components/churn_continer.dart';
import 'package:clan_churn/components/filters.dart';
import 'package:clan_churn/components/get_filters_drawer.dart';
import 'package:clan_churn/components/get_reports_data_table.dart';
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
  String selectedItem = "";

  @override
  void initState() {
    super.initState();
    setState(() {
      fetching = true;
    });
    
    setState(() {
      selectedItem = widget.reportName;
    });

    context.read<ProjectArchitectBloc>().add(GetReportDataEvent(
        inputId: widget.inputId,
        reportName: widget.reportName,
        onErrorCallback: (errorMessage, errorCode) {
          setState(() {
            apiError = true;
          });
        },
        onSuccessCallback: (message) {
          setState(() {
            fetching = false;
          });
          if (message != null) {
            Map<String, dynamic> jsonObject = json.decode(message.body);
            setState(() {
              data = jsonObject;
              selectedMonths = data.keys.toList();
              selectedMonthsTemp = data.keys.toList();
              metrics = (data[selectedMonths[0]] as Map<String, dynamic>)
                  .keys
                  .toList();
            });
          }
        }));


    // context.read<ProjectArchitectBloc>().add(GetAllReportsEvent(
    //       onErrorCallback: (errorMessage, errorCode) {},
    //       onSuccessCallback: (message) {
    //         selectedItem = (json.decode(message!.body) as Iterable)
    //             .map((e) => e.toString())
    //             .toList()[0];
    //         context.read<ProjectArchitectBloc>().add(GetReportDataEvent(
    //             inputId: widget.inputId,
    //             reportName: selectedItem,
    //             onErrorCallback: (errorMessage, errorCode) {
    //               setState(() {
    //                 apiError = true;
    //               });
    //             },
    //             onSuccessCallback: (message) {
    //               setState(() {
    //                 fetching = false;
    //               });
    //               if (message != null) {
    //                 Map<String, dynamic> jsonObject = json.decode(message.body);
    //                 setState(() {
    //                   data = jsonObject;
    //                   selectedMonths = data.keys.toList();
    //                   selectedMonthsTemp = data.keys.toList();
    //                   metrics =
    //                       (data[selectedMonths[0]] as Map<String, dynamic>)
    //                           .keys
    //                           .toList();
    //                 });
    //               }
    //             }));
    //       },
    //     ));

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
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.05),
      body: BlocBuilder<ProjectArchitectBloc, ProjectArchitectState>(
        builder: (context, state) {
          return WrapProfile(
            child: Column(
              children: [
                const NavBar(),
                const SizedBox(height: 10),
                Expanded(
                  child: Row(
                    children: [
                      const SideBar(
                        selectedRoute: SelectedRoute.home,
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: ChurnContainer(
                                  child: fetching
                                      ? Center(
                                          child: Image.asset(
                                              "assets/upload.gif",
                                              width: 100),
                                        )
                                      : Container(
                                          child: apiError
                                              ? Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        IconButton(
                                                          icon: Icon(
                                                            Icons
                                                                .keyboard_backspace,
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .secondary,
                                                          ),
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                            // GoRouter.of(context).go(AppRoutes.home);
                                                          },
                                                        ),
                                                        Container()
                                                      ],
                                                    ),
                                                    Center(
                                                        child: Text(
                                                            "Unable to fetch report data $apiError  ")),
                                                  ],
                                                )
                                              : Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            IconButton(
                                                              icon: Icon(
                                                                Icons
                                                                    .keyboard_backspace,
                                                                color: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .secondary,
                                                              ),
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                                // GoRouter.of(context).go(AppRoutes.home);
                                                              },
                                                            ),
                                                            Container()
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 35,
                                                          width: 300,
                                                          child:
                                                              DropdownButtonHideUnderline(
                                                            child:
                                                                DropdownButton2<
                                                                    String>(
                                                              isExpanded: true,
                                                              hint: Row(
                                                                children: [
                                                                  Text(
                                                                    'Select Column',
                                                                    style: ClanChurnTypography
                                                                        .font14900,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                  ),
                                                                ],
                                                              ),
                                                              items: state
                                                                  .allReports
                                                                  .map((String
                                                                          item) =>
                                                                      DropdownMenuItem<
                                                                          String>(
                                                                        value:
                                                                            item,
                                                                        child:
                                                                            Text(
                                                                          item,
                                                                          style: ClanChurnTypography
                                                                              .font14900
                                                                              .copyWith(color: Theme.of(context).colorScheme.background),
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                        ),
                                                                      ))
                                                                  .toList(),
                                                              selectedItemBuilder:
                                                                  (BuildContext
                                                                      context) {
                                                                return state
                                                                    .allReports
                                                                    .map((String
                                                                        item) {
                                                                  return Center(
                                                                    child: Row(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                          item,
                                                                          style: ClanChurnTypography
                                                                              .font14900
                                                                              .copyWith(color: Theme.of(context).colorScheme.secondary),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  );
                                                                }).toList();
                                                              },
                                                              value:
                                                                  selectedItem,
                                                              onChanged:
                                                                  (value) {
                                                                setState(() {
                                                                  selectedItem =
                                                                      value!;
                                                                });
                                                                context.read<ProjectArchitectBloc>().add(
                                                                    GetReportDataEvent(
                                                                        inputId:
                                                                            widget
                                                                                .inputId,
                                                                        reportName:
                                                                            value!,
                                                                        onErrorCallback:
                                                                            (errorMessage,
                                                                                errorCode) {
                                                                          print(
                                                                              " on error $errorCode, $errorMessage");
                                                                          setState(
                                                                              () {
                                                                            apiError =
                                                                                true;
                                                                          });
                                                                        },
                                                                        onSuccessCallback:
                                                                            (message) {
                                                                          setState(
                                                                              () {
                                                                            fetching =
                                                                                false;
                                                                          });
                                                                          if (message !=
                                                                              null) {
                                                                            // print("get report data: ${json.decode(message!.body)}");
                                                                            // print("get report data: ${json.decode(message.body).runtimeType}");
                                                                            // var a = json.decode(message.body);
                                                                            Map<String, dynamic>
                                                                                jsonObject =
                                                                                json.decode(message.body);
                                                                            // print(jsonObject.runtimeType);
                                                                            setState(() {
                                                                              data = jsonObject;
                                                                              selectedMonths = data.keys.toList();
                                                                              selectedMonthsTemp = data.keys.toList();
                                                                              metrics = (data[selectedMonths[0]] as Map<String, dynamic>).keys.toList();
                                                                            });
                                                                            // print(".......metrics.....$metrics");
                                                                          }
                                                                        }));
                                                              },
                                                              buttonStyleData:
                                                                  ButtonStyleData(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8),
                                                                  border: Border.all(
                                                                      color: Theme.of(
                                                                              context)
                                                                          .colorScheme
                                                                          .primary
                                                                          .withOpacity(
                                                                              0.6)),
                                                                  color: Theme.of(
                                                                          context)
                                                                      .colorScheme
                                                                      .primary
                                                                      .withOpacity(
                                                                          0.2),
                                                                ),
                                                                elevation: 0,
                                                              ),
                                                              iconStyleData:
                                                                  IconStyleData(
                                                                icon: const Icon(
                                                                    Icons
                                                                        .keyboard_arrow_down),
                                                                iconSize: 25,
                                                                iconEnabledColor: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .secondary,
                                                                iconDisabledColor:
                                                                    Colors.grey,
                                                              ),
                                                              dropdownStyleData:
                                                                  DropdownStyleData(
                                                                elevation: 0,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8),
                                                                  border: Border.all(
                                                                      color: Theme.of(
                                                                              context)
                                                                          .colorScheme
                                                                          .primary
                                                                          .withOpacity(
                                                                              0.6)),
                                                                  color: Theme.of(
                                                                          context)
                                                                      .colorScheme
                                                                      .primary
                                                                      .withOpacity(
                                                                          1.0),
                                                                ),
                                                                scrollbarTheme:
                                                                    ScrollbarThemeData(
                                                                  radius: const Radius
                                                                      .circular(
                                                                      40),
                                                                  thickness:
                                                                      MaterialStateProperty
                                                                          .all(
                                                                              6),
                                                                  thumbVisibility:
                                                                      MaterialStateProperty
                                                                          .all(
                                                                              true),
                                                                ),
                                                              ),
                                                              menuItemStyleData:
                                                                  const MenuItemStyleData(
                                                                height: 40,
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            14,
                                                                        right:
                                                                            14),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    FittedBox(
                                                      child: Row(
                                                        children: [
                                                          buildFrezeedColumn(
                                                            onHeaderSort:
                                                                onHeaderSort,
                                                          ),
                                                          Container(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.65,
                                                            child:
                                                                ReportsDataTable(
                                                              metrics: metrics,
                                                              months:
                                                                  selectedMonths,
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
                                                    ),
                                                  ],
                                                ),
                                        )),
                            ),
                            const Filter()
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      endDrawer: Drawer(
          width: MediaQuery.of(context).size.width * 0.21,
          child: GetFiltersDrawer(
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
