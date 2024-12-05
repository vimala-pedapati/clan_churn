import 'dart:convert';

import 'package:clan_churn/api_repos/api_repo.dart';
import 'package:clan_churn/churn_blocs/project_architect/project_architect_bloc.dart';
import 'package:clan_churn/components/churn_continer.dart';
import 'package:clan_churn/components/filters.dart';
import 'package:clan_churn/components/get_filters_drawer.dart';
import 'package:clan_churn/components/get_reports_data_table.dart';
import 'package:clan_churn/components/input_sheet_columns.dart';
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
  const PerformanceReport({Key? key, required this.inputId, required this.reportName}) : super(key: key);
  final String reportName;
  final String inputId;

  @override
  State<PerformanceReport> createState() => _PerformanceReportState();
}

class _PerformanceReportState extends State<PerformanceReport> {
  Map<String, Map<String, dynamic>> sheetData = {};
  Map<String, dynamic> data = {};
  List<String> xAxisData = [];
  List<String> yAxisData = [];
  List<String> zAxisData = [];
  List<String> tempData = [];
  int sortColumnIndex = 0;
  bool sortAscending = true;
  final _subTableYController = ScrollController();
  final _columnController = ScrollController();
  bool fetching = false;
  bool apiError = false;
  String selectedReport = "";
  String selectedFilterForThreeD = "";
  int getJsonDimension(Map<String, dynamic> data) {
    for (var value in data.values) {
      if (value is Map) {
        for (var innerValue in value.values) {
          if (innerValue is Map) {
            return 3;
          }
        }
      }
    }
    // If no nested map was found, it's 2D
    return 2;
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      fetching = true;
    });

    setState(() {
      selectedReport = widget.reportName;
    });

    context.read<ProjectArchitectBloc>().add(GetReportDataEvent(
        inputId: widget.inputId,
        reportName: widget.reportName,
        onErrorCallback: (errorMessage, errorCode) {
          setState(() {
            apiError = true;
            fetching = false;
          });
        },
        onSuccessCallback: (message) {
          setState(() {
            fetching = false;
          });
          if (message != null) {
            Map<String, dynamic> jsonObject = json.decode(message.body);
            if (getJsonDimension(jsonObject) == 2) {
              setState(() {
                data = jsonObject;
                yAxisData = data.keys.toList();
                tempData = data.keys.toList();
                xAxisData = (data[yAxisData[0]] as Map<String, dynamic>).keys.toList();
              });
            } else {
              setState(() {
                data = jsonObject;
                zAxisData = data.keys.toList(); // Top-level keys as x-axis
                selectedFilterForThreeD = zAxisData[0];
                yAxisData = data[zAxisData[0]].keys.toList();
                tempData = data[zAxisData[0]].keys.toList();
                xAxisData = ((data[zAxisData[0]][yAxisData[0]] as Map<String, dynamic>?)?.keys ?? []).toList(); // Combine all z-axis keys
              });
            }
          }
        }));
    _subTableYController.addListener(() {
      _columnController.jumpTo(_subTableYController.position.pixels);
    });
  }

  void onMonthSelected(String month) {
    setState(() {
      yAxisData = [month];
    });
  }

  void onToggleMonth(String month) {
    setState(() {
      if (yAxisData.contains(month)) {
        yAxisData.remove(month);
      } else {
        yAxisData.add(month);
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
        xAxisData.sort((a, b) => a.compareTo(b));
      });
    } else {
      setState(() {
        xAxisData.sort((b, a) => a.compareTo(b));
      });
    }
  }

  void onColumnsSort(int columnIndex, bool ascending) {
    setState(() {
      sortColumnIndex = columnIndex;
      sortAscending = ascending;
    });
    print("................$columnIndex.......${yAxisData[columnIndex]}.......${yAxisData.length}....$sortAscending....");
    Map<String, dynamic> a = data[yAxisData[columnIndex]];
    if (ascending) {
      setState(() {
        xAxisData = Map.fromEntries(a.entries.toList()..sort((a, b) => compareValues(a.value, b.value))).keys.toList();
      });
    } else {
      setState(() {
        xAxisData = Map.fromEntries(a.entries.toList()..sort((b, a) => compareValues(a.value, b.value))).keys.toList();
      });
    }
  }

  Widget buildFrezeedColumn({required Function(int, bool) onHeaderSort}) {
    return Theme(
      data: Theme.of(context).copyWith(dividerTheme: DividerThemeData(color: Theme.of(context).colorScheme.primary.withOpacity(0.5)), iconTheme: IconThemeData(color: Theme.of(context).colorScheme.background)),
      child: DataTable(
          dividerThickness: 1.0,
          horizontalMargin: 15,
          columnSpacing: 25,
          dataRowMaxHeight: 30,
          dataRowMinHeight: 30,
          sortColumnIndex: 0,
          sortAscending: sortAscending,
          showBottomBorder: true,
          headingRowColor: MaterialStateProperty.resolveWith<Color>((states) {
            return Theme.of(context).colorScheme.primary.withOpacity(0.8);
          }),
          border: TableBorder(
            left: BorderSide(color: Theme.of(context).colorScheme.primary.withOpacity(0.5)),
            right: BorderSide(color: Theme.of(context).colorScheme.primary.withOpacity(0.5)),
          ),
          headingTextStyle: ClanChurnTypography.font13600.copyWith(color: Theme.of(context).colorScheme.background, fontWeight: FontWeight.w900),
          columns: [
            // DataColumn(label: Text(""))
            DataColumn(
              label: const Text(
                'Metrics',
                // style: ClanChurnTypography.font13600.copyWith(
                //   color: Theme.of(context).colorScheme.secondary,
                // ),
              ),
              onSort: (columnIndex, ascending) => onHeaderSort(columnIndex, ascending),
            ),
          ],
          rows: yAxisData.map((metric) {
            return DataRow(
              color: MaterialStateProperty.resolveWith<Color>((states) {
                int index = yAxisData.indexOf(metric);
                return index % 2 == 0 ? Theme.of(context).colorScheme.primary.withOpacity(0.1) : Colors.transparent;
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
                                  child: SizedBox(
                                height: MediaQuery.of(context).size.height,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              IconButton(
                                                icon: Icon(
                                                  Icons.keyboard_backspace,
                                                  color: Theme.of(context).colorScheme.secondary,
                                                ),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  // GoRouter.of(context).go(AppRoutes.home);
                                                },
                                              ),
                                              Container()
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              if (getJsonDimension(data) == 3)
                                                SizedBox(
                                                  height: 35,
                                                  width: 300,
                                                  child: DropdownButtonHideUnderline(
                                                    child: DropdownButton2<String>(
                                                      isExpanded: true,
                                                      hint: Row(
                                                        children: [
                                                          Text(
                                                            'Select Column',
                                                            style: ClanChurnTypography.font14900,
                                                            overflow: TextOverflow.ellipsis,
                                                          ),
                                                        ],
                                                      ),
                                                      items: zAxisData
                                                          .map((String item) => DropdownMenuItem<String>(
                                                                value: item,
                                                                child: Text(
                                                                  item,
                                                                  style: ClanChurnTypography.font14900.copyWith(color: Theme.of(context).colorScheme.background),
                                                                  overflow: TextOverflow.ellipsis,
                                                                ),
                                                              ))
                                                          .toList(),
                                                      selectedItemBuilder: (BuildContext context) {
                                                        return zAxisData.map((String item) {
                                                          return Center(
                                                            child: Row(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Text(
                                                                  item,
                                                                  style: ClanChurnTypography.font14900.copyWith(color: Theme.of(context).colorScheme.secondary),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        }).toList();
                                                      },
                                                      value: selectedFilterForThreeD,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          selectedFilterForThreeD = value ?? '';
                                                        });
                                                      },
                                                      buttonStyleData: ButtonStyleData(
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(8),
                                                          border: Border.all(color: Theme.of(context).colorScheme.primary.withOpacity(0.6)),
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
                                                          border: Border.all(color: Theme.of(context).colorScheme.primary.withOpacity(0.6)),
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
                                                ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              SizedBox(
                                                height: 35,
                                                width: 300,
                                                child: DropdownButtonHideUnderline(
                                                  child: DropdownButton2<String>(
                                                    isExpanded: true,
                                                    hint: Row(
                                                      children: [
                                                        Text(
                                                          'Select Column',
                                                          style: ClanChurnTypography.font14900,
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                      ],
                                                    ),
                                                    items: state.allReports
                                                        .map((String item) => DropdownMenuItem<String>(
                                                              value: item,
                                                              child: Text(
                                                                item,
                                                                style: ClanChurnTypography.font14900.copyWith(color: Theme.of(context).colorScheme.background),
                                                                overflow: TextOverflow.ellipsis,
                                                              ),
                                                            ))
                                                        .toList(),
                                                    selectedItemBuilder: (BuildContext context) {
                                                      return state.allReports.map((String item) {
                                                        return Center(
                                                          child: Row(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Text(
                                                                item,
                                                                style: ClanChurnTypography.font14900.copyWith(color: Theme.of(context).colorScheme.secondary),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      }).toList();
                                                    },
                                                    value: selectedReport,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        fetching = true;
                                                      });
                                                      setState(() {
                                                        selectedReport = value!;
                                                      });
                                                      context.read<ProjectArchitectBloc>().add(GetReportDataEvent(
                                                          inputId: widget.inputId,
                                                          reportName: value!,
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
                                                              Map<String, dynamic> jsonObject = json.decode(message.body);
                                                              if (getJsonDimension(jsonObject) == 2) {
                                                                setState(() {
                                                                  data = jsonObject;
                                                                  yAxisData = data.keys.toList();
                                                                  tempData = data.keys.toList();
                                                                  xAxisData = (data[yAxisData[0]] as Map<String, dynamic>).keys.toList();
                                                                });
                                                              } else {
                                                                setState(() {
                                                                  data = jsonObject;
                                                                  zAxisData = data.keys.toList(); // Top-level keys as x-axis
                                                                  yAxisData = data[zAxisData[0]].keys.toList();
                                                                  tempData = data[zAxisData[0]].keys.toList();
                                                                  xAxisData = ((data[zAxisData[0]][yAxisData[0]] as Map<String, dynamic>?)?.keys ?? []).toList(); // Combine all
                                                                  selectedFilterForThreeD = zAxisData[0];
                                                                });
                                                              }
                                                            }
                                                          }));
                                                    },
                                                    buttonStyleData: ButtonStyleData(
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(8),
                                                        border: Border.all(color: Theme.of(context).colorScheme.primary.withOpacity(0.6)),
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
                                                        border: Border.all(color: Theme.of(context).colorScheme.primary.withOpacity(0.6)),
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
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      fetching
                                          ? SizedBox(
                                              height: MediaQuery.of(context).size.height * 0.6,
                                              width: MediaQuery.of(context).size.width,
                                              child: Center(
                                                child: Image.asset("assets/upload.gif", width: 100),
                                              ),
                                            )
                                          : apiError
                                              ? const Column(
                                                  children: [
                                                    Center(child: Text("Unable to fetch report data   ")),
                                                  ],
                                                )
                                              : FittedBox(
                                                  child: getJsonDimension(data) == 2
                                                      ? Row(
                                                          children: [
                                                            buildFrezeedColumn(
                                                              onHeaderSort: onHeaderSort,
                                                            ),
                                                            SizedBox(
                                                              width: MediaQuery.of(context).size.width * 0.65,
                                                              child: ReportsDataTable(
                                                                xAxisData: xAxisData,
                                                                yAxisData: yAxisData,
                                                                data: data,
                                                                sortColumnIndex: sortColumnIndex,
                                                                sortAscending: sortAscending,
                                                                // onHeaderSort: onHeaderSort,
                                                                onColumnsSort: onColumnsSort,
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      : Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            buildFrezeedColumn(
                                                              onHeaderSort: onHeaderSort,
                                                            ),

                                                            SizedBox(
                                                              width: MediaQuery.of(context).size.width * 0.65,
                                                              child: ReportsDataTable(
                                                                xAxisData: xAxisData,
                                                                yAxisData: yAxisData,
                                                                data: data[selectedFilterForThreeD] as Map<String, dynamic>,
                                                                sortColumnIndex: sortColumnIndex,
                                                                sortAscending: sortAscending,
                                                                onColumnsSort: onColumnsSort,
                                                              ),
                                                            ),
                                                            // Image.asset(
                                                            //   "assets/warning.png",
                                                            //   height: 200,
                                                            // ),
                                                            // Column(
                                                            //   children: [
                                                            //     Text(
                                                            //       "Currently, only two-dimensional (2D) data is supported for viewing the report. \nPlease provide data in 2D format to view the report.",
                                                            //       style: TextStyle(
                                                            //         color: Theme.of(context).colorScheme.primary,
                                                            //         fontSize: 12,
                                                            //         fontWeight: FontWeight.bold,
                                                            //       ),
                                                            //       textAlign: TextAlign.center,
                                                            //     ),
                                                            //     Text(
                                                            //       "Tip: You can download the data as an Excel summary report for easier review.",
                                                            //       style: TextStyle(
                                                            //         color: Theme.of(context).colorScheme.primary,
                                                            //         fontSize: 12,
                                                            //         fontWeight: FontWeight.bold,
                                                            //       ),
                                                            //       textAlign: TextAlign.center,
                                                            //     ),
                                                            //   ],
                                                            // ),
                                                          ],
                                                        )),
                                    ],
                                  ),
                                ),
                              )),
                            ),
                            Column(
                              children: [
                                const SizedBox(height: 10),
                                const Filter(),
                                const SizedBox(height: 10),
                                RotatedBox(
                                  quarterTurns: 3,
                                  child: Row(
                                    children: [
                                      ElevatedButton(
                                        child: const Text(
                                          "download report",
                                        ),
                                        onPressed: () {
                                          if (state.createdProject?.latestInput != null) {
                                            context.read<ProjectArchitectBloc>().add(
                                                  DownloadReportEvent(
                                                    inputId: state.createdProject!.latestInput!,
                                                    reportName: selectedReport,
                                                    onSuccessCallback: (response) {
                                                      Map<String, dynamic> data = json.decode(response!.body);
                                                      if (data["file_url"] != null) {
                                                        launchURL(data["file_url"]);
                                                      } else {
                                                        ApiRepository().handleWarningMessage("unable to download report", context);
                                                      }
                                                    },
                                                    onErrorCallback: (error, errorCode) {
                                                      ApiRepository().handleWarningMessage(error, context);
                                                    },
                                                  ),
                                                );
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Container(),
                                ),
                              ],
                            )
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
            months: xAxisData,
            updateMonthsData: (updatedData) {
              setState(() {
                if (updatedData.isNotEmpty) {
                  xAxisData = updatedData;
                }
              });
            },
            monthsStore: tempData,
          )),
    );
  }
}

final threeD = {
  "Residency Month R0": {
    "Performance achievement 0% - 0%": {"start_value": 0, "end_value": 0, "count": 3757, "percentage": 93.9015246188, "cumulative_percentage": 93.9015246188},
    "Performance achievement 0% - 100%": {"start_value": 0, "end_value": 100, "count": 27, "percentage": 0.6748312922, "cumulative_percentage": 94.576355911},
    "Performance achievement 100% - 200%": {"start_value": 100, "end_value": 200, "count": 62, "percentage": 1.5496125969, "cumulative_percentage": 96.1259685079},
    "Performance achievement 200% - 300%": {"start_value": 200, "end_value": 300, "count": 48, "percentage": 1.199700075, "cumulative_percentage": 97.3256685829},
    "Performance achievement 300% - 400%": {"start_value": 300, "end_value": 400, "count": 31, "percentage": 0.7748062984, "cumulative_percentage": 98.1004748813},
    "Performance achievement 400% - 500%": {"start_value": 400, "end_value": 500, "count": 25, "percentage": 0.6248437891, "cumulative_percentage": 98.7253186703},
    "Performance achievement 500% - 600%": {"start_value": 500, "end_value": 600, "count": 16, "percentage": 0.399900025, "cumulative_percentage": 99.1252186953},
    "Performance achievement 600% - 700%": {"start_value": 600, "end_value": 700, "count": 9, "percentage": 0.2249437641, "cumulative_percentage": 99.3501624594},
    "Performance achievement 700% - 800%": {"start_value": 700, "end_value": 800, "count": 2, "percentage": 0.0499875031, "cumulative_percentage": 99.4001499625},
    "Performance achievement 800% - 900%": {"start_value": 800, "end_value": 900, "count": 7, "percentage": 0.1749562609, "cumulative_percentage": 99.5751062234},
    "Performance achievement 900% - 1000%": {"start_value": 900, "end_value": 1000, "count": 5, "percentage": 0.1249687578, "cumulative_percentage": 99.7000749813},
    "Performance achievement 1000% - 1100%": {"start_value": 1000, "end_value": 1100, "count": 5, "percentage": 0.1249687578, "cumulative_percentage": 99.8250437391},
    "Performance achievement 1100% - 1200%": {"start_value": 1100, "end_value": 1200, "count": 0, "percentage": 0.0, "cumulative_percentage": 99.8250437391},
    "Performance achievement 1200% - 1300%": {"start_value": 1200, "end_value": 1300, "count": 1, "percentage": 0.0249937516, "cumulative_percentage": 99.8500374906},
    "Performance achievement 1300% - 1400%": {"start_value": 1300, "end_value": 1400, "count": 1, "percentage": 0.0249937516, "cumulative_percentage": 99.8750312422},
    "Performance achievement 1400% - 1500%": {"start_value": 1400, "end_value": 1500, "count": 0, "percentage": 0.0, "cumulative_percentage": 99.8750312422},
    "Performance achievement 1500% - 1600%": {"start_value": 1500, "end_value": 1600, "count": 1, "percentage": 0.0249937516, "cumulative_percentage": 99.9000249938},
    "Performance achievement 1600% - 1700%": {"start_value": 1600, "end_value": 1700, "count": 1, "percentage": 0.0249937516, "cumulative_percentage": 99.9250187453},
    "Performance achievement 1700% - 1800%": {"start_value": 1700, "end_value": 1800, "count": 0, "percentage": 0.0, "cumulative_percentage": 99.9250187453},
    "Performance achievement 1800% - 1900%": {"start_value": 1800, "end_value": 1900, "count": 0, "percentage": 0.0, "cumulative_percentage": 99.9250187453},
    "Performance achievement 1900% - 2000%": {"start_value": 1900, "end_value": 2000, "count": 1, "percentage": 0.0249937516, "cumulative_percentage": 99.9500124969},
    "Performance achievement 2000% - 2100%": {"start_value": 2000, "end_value": 2100, "count": 0, "percentage": 0.0, "cumulative_percentage": 99.9500124969},
    "Performance achievement 2100% - 2200%": {"start_value": 2100, "end_value": 2200, "count": 0, "percentage": 0.0, "cumulative_percentage": 99.9500124969},
    "Performance achievement 2200% - 2300%": {"start_value": 2200, "end_value": 2300, "count": 0, "percentage": 0.0, "cumulative_percentage": 99.9500124969},
    "Performance achievement 2300% - 2400%": {"start_value": 2300, "end_value": 2400, "count": 0, "percentage": 0.0, "cumulative_percentage": 99.9500124969},
    "Performance achievement 2400% - 2500%": {"start_value": 2400, "end_value": 2500, "count": 2, "percentage": 0.0499875031, "cumulative_percentage": 100.0},
    "Performance achievement 2500% - 2600%": {"start_value": 2500, "end_value": 2600, "count": 0, "percentage": 0.0, "cumulative_percentage": 100.0},
    "Performance achievement 2600% - 2700%": {"start_value": 2600, "end_value": 2700, "count": 0, "percentage": 0.0, "cumulative_percentage": 100.0},
    "Performance achievement 2700% - 2800%": {"start_value": 2700, "end_value": 2800, "count": 0, "percentage": 0.0, "cumulative_percentage": 100.0},
    "Performance achievement 2800% - 2900%": {"start_value": 2800, "end_value": 2900, "count": 0, "percentage": 0.0, "cumulative_percentage": 100.0},
    "Performance achievement 2900% - 3000%": {"start_value": 2900, "end_value": 3000, "count": 0, "percentage": 0.0, "cumulative_percentage": 100.0},
    "Performance achievement 3000% - 3100%": {"start_value": 3000, "end_value": 3100, "count": 0, "percentage": 0.0, "cumulative_percentage": 100.0},
    "Performance achievement 3100% - 3200%": {"start_value": 3100, "end_value": 3200, "count": 0, "percentage": 0.0, "cumulative_percentage": 100.0},
    "Performance achievement 3200% - 3300%": {"start_value": 3200, "end_value": 3300, "count": 0, "percentage": 0.0, "cumulative_percentage": 100.0},
    "Performance achievement 3300% - 3400%": {"start_value": 3300, "end_value": 3400, "count": 0, "percentage": 0.0, "cumulative_percentage": 100.0},
    "total count": 4001,
    "average of cohort in month": 22.3551518377
  },
  "Residency Month R1": {
    "Performance achievement 0% - 0%": {"start_value": 0, "end_value": 0, "count": 2680, "percentage": 76.5495572694, "cumulative_percentage": 76.5495572694},
    "Performance achievement 0% - 100%": {"start_value": 0, "end_value": 100, "count": 122, "percentage": 3.4847186518, "cumulative_percentage": 80.0342759212},
    "Performance achievement 100% - 200%": {"start_value": 100, "end_value": 200, "count": 165, "percentage": 4.7129391602, "cumulative_percentage": 84.7472150814},
    "Performance achievement 200% - 300%": {"start_value": 200, "end_value": 300, "count": 139, "percentage": 3.9702942017, "cumulative_percentage": 88.7175092831},
    "Performance achievement 300% - 400%": {"start_value": 300, "end_value": 400, "count": 101, "percentage": 2.8848900314, "cumulative_percentage": 91.6023993145},
    "Performance achievement 400% - 500%": {"start_value": 400, "end_value": 500, "count": 78, "percentage": 2.2279348757, "cumulative_percentage": 93.8303341902},
    "Performance achievement 500% - 600%": {"start_value": 500, "end_value": 600, "count": 53, "percentage": 1.5138531848, "cumulative_percentage": 95.344187375},
    "Performance achievement 600% - 700%": {"start_value": 600, "end_value": 700, "count": 51, "percentage": 1.4567266495, "cumulative_percentage": 96.8009140246},
    "Performance achievement 700% - 800%": {"start_value": 700, "end_value": 800, "count": 32, "percentage": 0.9140245644, "cumulative_percentage": 97.714938589},
    "Performance achievement 800% - 900%": {"start_value": 800, "end_value": 900, "count": 21, "percentage": 0.5998286204, "cumulative_percentage": 98.3147672094},
    "Performance achievement 900% - 1000%": {"start_value": 900, "end_value": 1000, "count": 8, "percentage": 0.2285061411, "cumulative_percentage": 98.5432733505},
    "Performance achievement 1000% - 1100%": {"start_value": 1000, "end_value": 1100, "count": 16, "percentage": 0.4570122822, "cumulative_percentage": 99.0002856327},
    "Performance achievement 1100% - 1200%": {"start_value": 1100, "end_value": 1200, "count": 7, "percentage": 0.1999428735, "cumulative_percentage": 99.2002285061},
    "Performance achievement 1200% - 1300%": {"start_value": 1200, "end_value": 1300, "count": 6, "percentage": 0.1713796058, "cumulative_percentage": 99.371608112},
    "Performance achievement 1300% - 1400%": {"start_value": 1300, "end_value": 1400, "count": 4, "percentage": 0.1142530706, "cumulative_percentage": 99.4858611825},
    "Performance achievement 1400% - 1500%": {"start_value": 1400, "end_value": 1500, "count": 3, "percentage": 0.0856898029, "cumulative_percentage": 99.5715509854},
    "Performance achievement 1500% - 1600%": {"start_value": 1500, "end_value": 1600, "count": 5, "percentage": 0.1428163382, "cumulative_percentage": 99.7143673236},
    "Performance achievement 1600% - 1700%": {"start_value": 1600, "end_value": 1700, "count": 0, "percentage": 0.0, "cumulative_percentage": 99.7143673236},
    "Performance achievement 1700% - 1800%": {"start_value": 1700, "end_value": 1800, "count": 3, "percentage": 0.0856898029, "cumulative_percentage": 99.8000571265},
    "Performance achievement 1800% - 1900%": {"start_value": 1800, "end_value": 1900, "count": 2, "percentage": 0.0571265353, "cumulative_percentage": 99.8571836618},
    "Performance achievement 1900% - 2000%": {"start_value": 1900, "end_value": 2000, "count": 0, "percentage": 0.0, "cumulative_percentage": 99.8571836618},
    "Performance achievement 2000% - 2100%": {"start_value": 2000, "end_value": 2100, "count": 0, "percentage": 0.0, "cumulative_percentage": 99.8571836618},
    "Performance achievement 2100% - 2200%": {"start_value": 2100, "end_value": 2200, "count": 2, "percentage": 0.0571265353, "cumulative_percentage": 99.9143101971},
    "Performance achievement 2200% - 2300%": {"start_value": 2200, "end_value": 2300, "count": 1, "percentage": 0.0285632676, "cumulative_percentage": 99.9428734647},
    "Performance achievement 2300% - 2400%": {"start_value": 2300, "end_value": 2400, "count": 0, "percentage": 0.0, "cumulative_percentage": 99.9428734647},
    "Performance achievement 2400% - 2500%": {"start_value": 2400, "end_value": 2500, "count": 1, "percentage": 0.0285632676, "cumulative_percentage": 99.9714367324},
    "Performance achievement 2500% - 2600%": {"start_value": 2500, "end_value": 2600, "count": 0, "percentage": 0.0, "cumulative_percentage": 99.9714367324},
    "Performance achievement 2600% - 2700%": {"start_value": 2600, "end_value": 2700, "count": 0, "percentage": 0.0, "cumulative_percentage": 99.9714367324},
    "Performance achievement 2700% - 2800%": {"start_value": 2700, "end_value": 2800, "count": 0, "percentage": 0.0, "cumulative_percentage": 99.9714367324},
    "Performance achievement 2800% - 2900%": {"start_value": 2800, "end_value": 2900, "count": 0, "percentage": 0.0, "cumulative_percentage": 99.9714367324},
    "Performance achievement 2900% - 3000%": {"start_value": 2900, "end_value": 3000, "count": 1, "percentage": 0.0285632676, "cumulative_percentage": 100.0},
    "Performance achievement 3000% - 3100%": {"start_value": 3000, "end_value": 3100, "count": 0, "percentage": 0.0, "cumulative_percentage": 100.0},
    "Performance achievement 3100% - 3200%": {"start_value": 3100, "end_value": 3200, "count": 0, "percentage": 0.0, "cumulative_percentage": 100.0},
    "Performance achievement 3200% - 3300%": {"start_value": 3200, "end_value": 3300, "count": 0, "percentage": 0.0, "cumulative_percentage": 100.0},
    "Performance achievement 3300% - 3400%": {"start_value": 3300, "end_value": 3400, "count": 0, "percentage": 0.0, "cumulative_percentage": 100.0},
    "total count": 3501,
    "average of cohort in month": 90.9969424699
  },
  "Residency Month R2": {
    "Performance achievement 0% - 0%": {"start_value": 0, "end_value": 0, "count": 2050, "percentage": 62.3479318735, "cumulative_percentage": 62.3479318735},
    "Performance achievement 0% - 100%": {"start_value": 0, "end_value": 100, "count": 187, "percentage": 5.6873479319, "cumulative_percentage": 68.0352798054},
    "Performance achievement 100% - 200%": {"start_value": 100, "end_value": 200, "count": 256, "percentage": 7.7858880779, "cumulative_percentage": 75.8211678832},
    "Performance achievement 200% - 300%": {"start_value": 200, "end_value": 300, "count": 208, "percentage": 6.3260340633, "cumulative_percentage": 82.1472019465},
    "Performance achievement 300% - 400%": {"start_value": 300, "end_value": 400, "count": 168, "percentage": 5.1094890511, "cumulative_percentage": 87.2566909976},
    "Performance achievement 400% - 500%": {"start_value": 400, "end_value": 500, "count": 103, "percentage": 3.1326034063, "cumulative_percentage": 90.3892944039},
    "Performance achievement 500% - 600%": {"start_value": 500, "end_value": 600, "count": 66, "percentage": 2.0072992701, "cumulative_percentage": 92.396593674},
    "Performance achievement 600% - 700%": {"start_value": 600, "end_value": 700, "count": 65, "percentage": 1.9768856448, "cumulative_percentage": 94.3734793187},
    "Performance achievement 700% - 800%": {"start_value": 700, "end_value": 800, "count": 44, "percentage": 1.3381995134, "cumulative_percentage": 95.7116788321},
    "Performance achievement 800% - 900%": {"start_value": 800, "end_value": 900, "count": 37, "percentage": 1.1253041363, "cumulative_percentage": 96.8369829684},
    "Performance achievement 900% - 1000%": {"start_value": 900, "end_value": 1000, "count": 22, "percentage": 0.6690997567, "cumulative_percentage": 97.5060827251},
    "Performance achievement 1000% - 1100%": {"start_value": 1000, "end_value": 1100, "count": 25, "percentage": 0.7603406326, "cumulative_percentage": 98.2664233577},
    "Performance achievement 1100% - 1200%": {"start_value": 1100, "end_value": 1200, "count": 14, "percentage": 0.4257907543, "cumulative_percentage": 98.6922141119},
    "Performance achievement 1200% - 1300%": {"start_value": 1200, "end_value": 1300, "count": 8, "percentage": 0.2433090024, "cumulative_percentage": 98.9355231144},
    "Performance achievement 1300% - 1400%": {"start_value": 1300, "end_value": 1400, "count": 7, "percentage": 0.2128953771, "cumulative_percentage": 99.1484184915},
    "Performance achievement 1400% - 1500%": {"start_value": 1400, "end_value": 1500, "count": 9, "percentage": 0.2737226277, "cumulative_percentage": 99.4221411192},
    "Performance achievement 1500% - 1600%": {"start_value": 1500, "end_value": 1600, "count": 3, "percentage": 0.0912408759, "cumulative_percentage": 99.5133819951},
    "Performance achievement 1600% - 1700%": {"start_value": 1600, "end_value": 1700, "count": 1, "percentage": 0.0304136253, "cumulative_percentage": 99.5437956204},
    "Performance achievement 1700% - 1800%": {"start_value": 1700, "end_value": 1800, "count": 3, "percentage": 0.0912408759, "cumulative_percentage": 99.6350364964},
    "Performance achievement 1800% - 1900%": {"start_value": 1800, "end_value": 1900, "count": 3, "percentage": 0.0912408759, "cumulative_percentage": 99.7262773723},
    "Performance achievement 1900% - 2000%": {"start_value": 1900, "end_value": 2000, "count": 1, "percentage": 0.0304136253, "cumulative_percentage": 99.7566909976},
    "Performance achievement 2000% - 2100%": {"start_value": 2000, "end_value": 2100, "count": 1, "percentage": 0.0304136253, "cumulative_percentage": 99.7871046229},
    "Performance achievement 2100% - 2200%": {"start_value": 2100, "end_value": 2200, "count": 1, "percentage": 0.0304136253, "cumulative_percentage": 99.8175182482},
    "Performance achievement 2200% - 2300%": {"start_value": 2200, "end_value": 2300, "count": 2, "percentage": 0.0608272506, "cumulative_percentage": 99.8783454988},
    "Performance achievement 2300% - 2400%": {"start_value": 2300, "end_value": 2400, "count": 2, "percentage": 0.0608272506, "cumulative_percentage": 99.9391727494},
    "Performance achievement 2400% - 2500%": {"start_value": 2400, "end_value": 2500, "count": 0, "percentage": 0.0, "cumulative_percentage": 99.9391727494},
    "Performance achievement 2500% - 2600%": {"start_value": 2500, "end_value": 2600, "count": 0, "percentage": 0.0, "cumulative_percentage": 99.9391727494},
    "Performance achievement 2600% - 2700%": {"start_value": 2600, "end_value": 2700, "count": 0, "percentage": 0.0, "cumulative_percentage": 99.9391727494},
    "Performance achievement 2700% - 2800%": {"start_value": 2700, "end_value": 2800, "count": 0, "percentage": 0.0, "cumulative_percentage": 99.9391727494},
    "Performance achievement 2800% - 2900%": {"start_value": 2800, "end_value": 2900, "count": 1, "percentage": 0.0304136253, "cumulative_percentage": 99.9695863747},
    "Performance achievement 2900% - 3000%": {"start_value": 2900, "end_value": 3000, "count": 0, "percentage": 0.0, "cumulative_percentage": 99.9695863747},
    "Performance achievement 3000% - 3100%": {"start_value": 3000, "end_value": 3100, "count": 0, "percentage": 0.0, "cumulative_percentage": 99.9695863747},
    "Performance achievement 3100% - 3200%": {"start_value": 3100, "end_value": 3200, "count": 0, "percentage": 0.0, "cumulative_percentage": 99.9695863747},
    "Performance achievement 3200% - 3300%": {"start_value": 3200, "end_value": 3300, "count": 0, "percentage": 0.0, "cumulative_percentage": 99.9695863747},
    "Performance achievement 3300% - 3400%": {"start_value": 3300, "end_value": 3400, "count": 1, "percentage": 0.0304136253, "cumulative_percentage": 100.0},
    "total count": 3288,
    "average of cohort in month": 146.6605750331
  },
  "Residency Month R3": {
    "Performance achievement 0% - 0%": {"start_value": 0, "end_value": 0, "count": 1584, "percentage": 52.3463317911, "cumulative_percentage": 52.3463317911},
    "Performance achievement 0% - 100%": {"start_value": 0, "end_value": 100, "count": 465, "percentage": 15.3668208857, "cumulative_percentage": 67.7131526768},
    "Performance achievement 100% - 200%": {"start_value": 100, "end_value": 200, "count": 410, "percentage": 13.5492399207, "cumulative_percentage": 81.2623925975},
    "Performance achievement 200% - 300%": {"start_value": 200, "end_value": 300, "count": 229, "percentage": 7.5677461996, "cumulative_percentage": 88.8301387971},
    "Performance achievement 300% - 400%": {"start_value": 300, "end_value": 400, "count": 144, "percentage": 4.7587574356, "cumulative_percentage": 93.5888962327},
    "Performance achievement 400% - 500%": {"start_value": 400, "end_value": 500, "count": 77, "percentage": 2.544613351, "cumulative_percentage": 96.1335095836},
    "Performance achievement 500% - 600%": {"start_value": 500, "end_value": 600, "count": 54, "percentage": 1.7845340383, "cumulative_percentage": 97.9180436219},
    "Performance achievement 600% - 700%": {"start_value": 600, "end_value": 700, "count": 25, "percentage": 0.8261731659, "cumulative_percentage": 98.7442167878},
    "Performance achievement 700% - 800%": {"start_value": 700, "end_value": 800, "count": 12, "percentage": 0.3965631196, "cumulative_percentage": 99.1407799075},
    "Performance achievement 800% - 900%": {"start_value": 800, "end_value": 900, "count": 8, "percentage": 0.2643754131, "cumulative_percentage": 99.4051553206},
    "Performance achievement 900% - 1000%": {"start_value": 900, "end_value": 1000, "count": 4, "percentage": 0.1321877065, "cumulative_percentage": 99.5373430271},
    "Performance achievement 1000% - 1100%": {"start_value": 1000, "end_value": 1100, "count": 3, "percentage": 0.0991407799, "cumulative_percentage": 99.636483807},
    "Performance achievement 1100% - 1200%": {"start_value": 1100, "end_value": 1200, "count": 1, "percentage": 0.0330469266, "cumulative_percentage": 99.6695307336},
    "Performance achievement 1200% - 1300%": {"start_value": 1200, "end_value": 1300, "count": 4, "percentage": 0.1321877065, "cumulative_percentage": 99.8017184402},
    "Performance achievement 1300% - 1400%": {"start_value": 1300, "end_value": 1400, "count": 1, "percentage": 0.0330469266, "cumulative_percentage": 99.8347653668},
    "Performance achievement 1400% - 1500%": {"start_value": 1400, "end_value": 1500, "count": 1, "percentage": 0.0330469266, "cumulative_percentage": 99.8678122935},
    "Performance achievement 1500% - 1600%": {"start_value": 1500, "end_value": 1600, "count": 1, "percentage": 0.0330469266, "cumulative_percentage": 99.9008592201},
    "Performance achievement 1600% - 1700%": {"start_value": 1600, "end_value": 1700, "count": 2, "percentage": 0.0660938533, "cumulative_percentage": 99.9669530734},
    "Performance achievement 1700% - 1800%": {"start_value": 1700, "end_value": 1800, "count": 0, "percentage": 0.0, "cumulative_percentage": 99.9669530734},
    "Performance achievement 1800% - 1900%": {"start_value": 1800, "end_value": 1900, "count": 1, "percentage": 0.0330469266, "cumulative_percentage": 100.0},
    "Performance achievement 1900% - 2000%": {"start_value": 1900, "end_value": 2000, "count": 0, "percentage": 0.0, "cumulative_percentage": 100.0},
    "Performance achievement 2000% - 2100%": {"start_value": 2000, "end_value": 2100, "count": 0, "percentage": 0.0, "cumulative_percentage": 100.0},
    "Performance achievement 2100% - 2200%": {"start_value": 2100, "end_value": 2200, "count": 0, "percentage": 0.0, "cumulative_percentage": 100.0},
    "Performance achievement 2200% - 2300%": {"start_value": 2200, "end_value": 2300, "count": 0, "percentage": 0.0, "cumulative_percentage": 100.0},
    "Performance achievement 2300% - 2400%": {"start_value": 2300, "end_value": 2400, "count": 0, "percentage": 0.0, "cumulative_percentage": 100.0},
    "Performance achievement 2400% - 2500%": {"start_value": 2400, "end_value": 2500, "count": 0, "percentage": 0.0, "cumulative_percentage": 100.0},
    "Performance achievement 2500% - 2600%": {"start_value": 2500, "end_value": 2600, "count": 0, "percentage": 0.0, "cumulative_percentage": 100.0},
    "Performance achievement 2600% - 2700%": {"start_value": 2600, "end_value": 2700, "count": 0, "percentage": 0.0, "cumulative_percentage": 100.0},
    "Performance achievement 2700% - 2800%": {"start_value": 2700, "end_value": 2800, "count": 0, "percentage": 0.0, "cumulative_percentage": 100.0},
    "Performance achievement 2800% - 2900%": {"start_value": 2800, "end_value": 2900, "count": 0, "percentage": 0.0, "cumulative_percentage": 100.0},
    "Performance achievement 2900% - 3000%": {"start_value": 2900, "end_value": 3000, "count": 0, "percentage": 0.0, "cumulative_percentage": 100.0},
    "Performance achievement 3000% - 3100%": {"start_value": 3000, "end_value": 3100, "count": 0, "percentage": 0.0, "cumulative_percentage": 100.0},
    "Performance achievement 3100% - 3200%": {"start_value": 3100, "end_value": 3200, "count": 0, "percentage": 0.0, "cumulative_percentage": 100.0},
    "Performance achievement 3200% - 3300%": {"start_value": 3200, "end_value": 3300, "count": 0, "percentage": 0.0, "cumulative_percentage": 100.0},
    "Performance achievement 3300% - 3400%": {"start_value": 3300, "end_value": 3400, "count": 0, "percentage": 0.0, "cumulative_percentage": 100.0},
    "total count": 3026,
    "average of cohort in month": 102.0248233391
  },
};
