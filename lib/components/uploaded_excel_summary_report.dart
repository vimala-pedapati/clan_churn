import 'dart:convert';

import 'package:clan_churn/api_repos/api_repo.dart';
import 'package:clan_churn/churn_blocs/project_architect/project_architect_bloc.dart';
import 'package:clan_churn/components/dialogs.dart';
import 'package:clan_churn/components/outlined_button_template.dart';
import 'package:clan_churn/components/project_input_history.dart';
import 'package:clan_churn/components/project_publish.dart';
import 'package:clan_churn/components/summary_card.dart';
import 'package:clan_churn/components/view_error_report.dart';
import 'package:clan_churn/pages/new_project_components.dart';
import 'package:clan_churn/utils/spacing.dart';
import 'package:clan_churn/utils/typography.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UploadedExcelSummaryReport extends StatefulWidget {
  const UploadedExcelSummaryReport(
      {super.key,
      required this.onPressed,
      required this.uploadNewSheetRequested});
  final Function() onPressed;
  final VoidCallback uploadNewSheetRequested;

  @override
  State<UploadedExcelSummaryReport> createState() =>
      _UploadedExcelSummaryReportState();
}

class _UploadedExcelSummaryReportState
    extends State<UploadedExcelSummaryReport> {
  Map<String, dynamic>? jsonObject;
  // = {
  //   "Customer Basic Data": {
  //     "Employee ID": {
  //       "count": 1.0,
  //       "unique": null,
  //       "top": null,
  //       "freq": null,
  //       "mean": 12345.0,
  //       "std": null,
  //       "min": 12345.0,
  //       "25%": 12345.0,
  //       "50%": 12345.0,
  //       "75%": 12345.0,
  //       "max": 12345.0
  //     },
  //     "Gender": {
  //       "count": 1,
  //       "unique": 1,
  //       "top": "Male",
  //       "freq": 1,
  //       "mean": null,
  //       "std": null,
  //       "min": null,
  //       "25%": null,
  //       "50%": null,
  //       "75%": null,
  //       "max": null
  //     },
  //     "Date of Birth": {
  //       "count": 0.0,
  //       "unique": null,
  //       "top": null,
  //       "freq": null,
  //       "mean": null,
  //       "std": null,
  //       "min": null,
  //       "25%": null,
  //       "50%": null,
  //       "75%": null,
  //       "max": null
  //     }
  //   },
  //   "Customer Work Data": {
  //     "Employee ID": {
  //       "count": 1.0,
  //       "mean": 12345.0,
  //       "min": 12345.0,
  //       "25%": 12345.0,
  //       "50%": 12345.0,
  //       "75%": 12345.0,
  //       "max": 12345.0,
  //       "std": null
  //     },
  //     "Date of joining the client": {
  //       "count": 1,
  //       "mean": 1694304000000,
  //       "min": 1694304000000,
  //       "25%": 1694304000000,
  //       "50%": 1694304000000,
  //       "75%": 1694304000000,
  //       "max": 1694304000000,
  //       "std": null
  //     },
  //     "Date of Joining the Role": {
  //       "count": 0.0,
  //       "mean": null,
  //       "min": null,
  //       "25%": null,
  //       "50%": null,
  //       "75%": null,
  //       "max": null,
  //       "std": null
  //     },
  //     "On Roll /Consultant": {
  //       "count": 0.0,
  //       "mean": null,
  //       "min": null,
  //       "25%": null,
  //       "50%": null,
  //       "75%": null,
  //       "max": null,
  //       "std": null
  //     },
  //     "Last working date in Client For Attritted Employees": {
  //       "count": 0.0,
  //       "mean": null,
  //       "min": null,
  //       "25%": null,
  //       "50%": null,
  //       "75%": null,
  //       "max": null,
  //       "std": null
  //     },
  //     "Designation on the beginning of the study": {
  //       "count": 0.0,
  //       "mean": null,
  //       "min": null,
  //       "25%": null,
  //       "50%": null,
  //       "75%": null,
  //       "max": null,
  //       "std": null
  //     },
  //     "Branch name or branch code": {
  //       "count": 0.0,
  //       "mean": null,
  //       "min": null,
  //       "25%": null,
  //       "50%": null,
  //       "75%": null,
  //       "max": null,
  //       "std": null
  //     },
  //     "Current City": {
  //       "count": 0.0,
  //       "mean": null,
  //       "min": null,
  //       "25%": null,
  //       "50%": null,
  //       "75%": null,
  //       "max": null,
  //       "std": null
  //     },
  //     "State": {
  //       "count": 0.0,
  //       "mean": null,
  //       "min": null,
  //       "25%": null,
  //       "50%": null,
  //       "75%": null,
  //       "max": null,
  //       "std": null
  //     },
  //     "Region": {
  //       "count": 0.0,
  //       "mean": null,
  //       "min": null,
  //       "25%": null,
  //       "50%": null,
  //       "75%": null,
  //       "max": null,
  //       "std": null
  //     },
  //     "Zone": {
  //       "count": 0.0,
  //       "mean": null,
  //       "min": null,
  //       "25%": null,
  //       "50%": null,
  //       "75%": null,
  //       "max": null,
  //       "std": null
  //     },
  //     "Employee ID of Immediate Supervisor in the role": {
  //       "count": 0.0,
  //       "mean": null,
  //       "min": null,
  //       "25%": null,
  //       "50%": null,
  //       "75%": null,
  //       "max": null,
  //       "std": null
  //     }
  //   },
  //   "Customer Performance Data": {
  //     "Employee ID": {"count": 0, "unique": 0, "top": null, "freq": null},
  //     "Performance calendar Month-Year (e.g. 01-05-23)": {
  //       "count": 0,
  //       "unique": 0,
  //       "top": null,
  //       "freq": null
  //     },
  //     "Product department": {
  //       "count": 0,
  //       "unique": 0,
  //       "top": null,
  //       "freq": null
  //     },
  //     "Performance value target": {
  //       "count": 0,
  //       "unique": 0,
  //       "top": null,
  //       "freq": null
  //     },
  //     "Actual performance value": {
  //       "count": 0,
  //       "unique": 0,
  //       "top": null,
  //       "freq": null
  //     },
  //     "Peformance quantity Target": {
  //       "count": 0,
  //       "unique": 0,
  //       "top": null,
  //       "freq": null
  //     },
  //     "Actual performance quantity": {
  //       "count": 0,
  //       "unique": 0,
  //       "top": null,
  //       "freq": null
  //     },
  //     "Over all performance achievement % as per client": {
  //       "count": 0,
  //       "unique": 0,
  //       "top": null,
  //       "freq": null
  //     },
  //     "Fixed CTC salary INDEX for the month": {
  //       "count": 0,
  //       "unique": 0,
  //       "top": null,
  //       "freq": null
  //     },
  //     "Total incentive paid in Rs in the month": {
  //       "count": 0,
  //       "unique": 0,
  //       "top": null,
  //       "freq": null
  //     }
  //   }
  // };
  String? selectedSheet;
  String? selectedColumn;
  List<String> sheets = [];
  List<String> columns = [];
  List<Widget> widgets = [];

  @override
  void initState() {
    if (context.read<ProjectArchitectBloc>().state.createdProject != null) {
      if (context
              .read<ProjectArchitectBloc>()
              .state
              .createdProject!
              .latestInput !=
          null) {
        context.read<ProjectArchitectBloc>().add(GetInputExcelSummaryEvent(
              inputId: context
                  .read<ProjectArchitectBloc>()
                  .state
                  .createdProject!
                  .latestInput!,
              onErrorCallback: (errorMessage, errorCode) {
                if (kDebugMode) {
                  print(
                      "Get Input Excel Summary Report error call back: $errorMessage $errorCode");
                }
              },
              onSuccessCallback: (message) {
                if (message != null) {
                  if (kDebugMode) {
                    print(
                        "Get Input Excel Summary Report: ${json.decode(message.body)}");
                  }
                  setState(() {
                    jsonObject = json.decode(message.body);
                  });
                  updateSelectedSheet(data: jsonObject!);
                }
              },
            ));
      }
    }
    super.initState();
  }

  void updateSelectedSheet(
      {required Map<String, dynamic> data, String? selectedSheet}) {
    if (selectedSheet == null) {
      setState(() {
        sheets = data.keys.toList();
        if (sheets.isNotEmpty) {
          selectedSheet = sheets[0];
          updatedSelectedSheetColumns(
              data: data, selectedSheetKey: selectedSheet!);
        }
      });
    } else {
      updatedSelectedSheetColumns(data: data, selectedSheetKey: selectedSheet);
    }
  }

  void updatedSelectedSheetColumns(
      {required Map<String, dynamic> data, required String selectedSheetKey}) {
    setState(() {
      selectedSheet = selectedSheetKey;
      columns = json.decode(data[selectedSheetKey]).keys.toList();
      if (columns.isNotEmpty) {
        selectedColumn = columns[0];
      }
      updatedSelectedSheetColumnWidgets(
          selectedCol: selectedColumn!, selectedShe: selectedSheetKey);
    });
  }

  void updatedSelectedSheetColumnWidgets(
      {required String selectedShe, required String selectedCol}) {
    setState(() {
      selectedColumn = selectedCol;
      widgets = [];
      ((json.decode(jsonObject![selectedSheet]))[selectedColumn]
              as Map<String, dynamic>)
          .map(
        (key, value) {
          setState(() {
            widgets.add(Row(
              children: [Text("$key : "), Text("$value")],
            ));
          });
          return MapEntry(key, value);
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // final h = MediaQuery.of(context).size.height;
    // final w = MediaQuery.of(context).size.width;
    return jsonObject == null
        ? const Center(
            child: Text("Fetching summary report!........"),
          )
        : SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              // header - upload data, history button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.keyboard_backspace,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        onPressed: widget.onPressed,
                      ),
                      ClanChurnSpacing.w10,
                      SelectableText(
                        "Upload Data",
                        style: ClanChurnTypography.font18600,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 45,
                    width: 130,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.all(0),
                        side: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                            width: 1.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              8), // Adjust the border radius
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Icon(Icons.history),
                          Text(
                            "History",
                            style: ClanChurnTypography.font18600.copyWith(
                                color: Theme.of(context).colorScheme.primary),
                          ),
                        ],
                      ),
                      onPressed: () {
                        showHistory(context);
                      },
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 0, right: 50, top: 10, bottom: 30),
                child: Row(
                  children: [
                    // Sheets Dropdown
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Select Sheet",
                          style: ClanChurnTypography.font18500,
                        ),
                        ClanChurnSpacing.h10,
                        SizedBox(
                          width: 400,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2<String>(
                              isExpanded: true,
                              hint: Row(
                                children: [
                                  Text(
                                    'Select Sheet',
                                    style: ClanChurnTypography.font18500,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              items: sheets
                                  .map(
                                      (String item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: ClanChurnTypography
                                                  .font18500
                                                  .copyWith(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .background),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ))
                                  .toList(),
                              value: selectedSheet,
                              onChanged: (value) {
                                updateSelectedSheet(
                                    data: jsonObject!, selectedSheet: value);
                              },
                              selectedItemBuilder: (BuildContext context) {
                                return sheets.map((String item) {
                                  return Center(
                                    child: Expanded(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(item,
                                              style: ClanChurnTypography
                                                  .font18500
                                                  .copyWith(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .secondary)),
                                        ],
                                      ),
                                    ),
                                  );
                                }).toList();
                              },
                              buttonStyleData: ButtonStyleData(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary
                                          .withOpacity(0.6)),
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.2),
                                ),
                                elevation: 0,
                              ),
                              iconStyleData: IconStyleData(
                                icon: const Icon(
                                  Icons.keyboard_arrow_down,
                                ),
                                iconSize: 25,
                                iconEnabledColor:
                                    Theme.of(context).colorScheme.secondary,
                                iconDisabledColor: Colors.grey,
                              ),
                              dropdownStyleData: DropdownStyleData(
                                elevation: 0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary
                                          .withOpacity(0.6)),
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(1.0),
                                ),
                                scrollbarTheme: ScrollbarThemeData(
                                  radius: const Radius.circular(40),
                                  thickness: MaterialStateProperty.all(6),
                                  thumbVisibility:
                                      MaterialStateProperty.all(true),
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

                    ClanChurnSpacing.w50,

                    // Column DropDown
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Select Column",
                          style: ClanChurnTypography.font18500,
                        ),
                        ClanChurnSpacing.h10,
                        SizedBox(
                          width: 400,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2<String>(
                              isExpanded: true,
                              hint: Row(
                                children: [
                                  Text(
                                    'Select Column',
                                    style: ClanChurnTypography.font18500,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              items: columns
                                  .map(
                                      (String item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: ClanChurnTypography
                                                  .font18500
                                                  .copyWith(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .background),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ))
                                  .toList(),
                              selectedItemBuilder: (BuildContext context) {
                                return columns.map((String item) {
                                  return Center(
                                    child: Expanded(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(item,
                                              style: ClanChurnTypography
                                                  .font18500
                                                  .copyWith(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .secondary)),
                                        ],
                                      ),
                                    ),
                                  );
                                }).toList();
                              },
                              value: selectedColumn,
                              onChanged: (value) {
                                updatedSelectedSheetColumnWidgets(
                                    selectedShe: selectedSheet!,
                                    selectedCol: value!);
                              },
                              buttonStyleData: ButtonStyleData(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary
                                          .withOpacity(0.6)),
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.2),
                                ),
                                elevation: 0,
                              ),
                              iconStyleData: IconStyleData(
                                icon: const Icon(
                                  Icons.keyboard_arrow_down,
                                ),
                                iconSize: 25,
                                iconEnabledColor:
                                    Theme.of(context).colorScheme.secondary,
                                iconDisabledColor: Colors.grey,
                              ),
                              dropdownStyleData: DropdownStyleData(
                                elevation: 0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary
                                          .withOpacity(0.6)),
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(1.0),
                                ),
                                scrollbarTheme: ScrollbarThemeData(
                                  radius: const Radius.circular(40),
                                  thickness: MaterialStateProperty.all(6),
                                  thumbVisibility:
                                      MaterialStateProperty.all(true),
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
              ),
              // (selectedSheet != null)
              //     ? (selectedColumn != null)
              //         ? Column(
              //             children: [
              //               Container(
              //                   // width: 00,
              //                   child: Text(
              //                       "${jsonObject[selectedSheet][selectedColumn]}")),
              //               Row(
              //                 children: [...widgets],
              //               ),
              //             ],
              //           )
              //         : Container()
              //     : Container(),
              ClanChurnSpacing.h20,
              Padding(
                padding: const EdgeInsets.only(left: 0, right: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text("${jsonObject.runtimeType}"),
                    // Text("${jsonObject!.keys.toList()}"),
                    // Text("\n ${jsonObject![jsonObject!.keys.toList()[0]]}"),
                    // Text("${jsonObject![jsonObject!.keys.toList()[0]].runtimeType}"),
                    // Text("\n ${json.decode(jsonObject!.values.toList()[0]).runtimeType}"),
                    // Text("${jsonObject!.values.toList()[1].runtimeType}"),
                    // Text("${jsonObject!.values.toList()[2].runtimeType}"),
                    // SelectableText("\n${jsonObject}"),
                    // Text("${ (json.decode(jsonObject![selectedSheet]))}"),
                    // Text("${selectedColumn}"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SummaryCard(
                          value: (json.decode(jsonObject![selectedSheet]))[
                                  selectedColumn]["count"]
                              .toString(),
                          header: "Total Rows",
                          isDisabled: (json.decode(jsonObject![selectedSheet]))[
                                      selectedColumn]["count"] ==
                                  null
                              ? true
                              : false,
                        ),
                        const SummaryCard(
                          value: "--",
                          header: "Total Zeros",
                          isDisabled: true,
                        ),
                        const SummaryCard(
                          value: "--",
                          header: "Total Blanks",
                          isDisabled: true,
                        ),
                        const SummaryCard(
                          value: "--",
                          header: 'Total "NA" values',
                          isDisabled: true,
                        ),
                      ],
                    ),

                    ClanChurnSpacing.h30,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SummaryCard(
                          value: (json.decode(jsonObject![selectedSheet]))[
                                  selectedColumn]["max"]
                              .toString(),
                          header: "Maximum Value",
                          isDisabled: (json.decode(jsonObject![selectedSheet]))[
                                      selectedColumn]["max"] ==
                                  null
                              ? true
                              : false,
                        ),
                        SummaryCard(
                          value: (json.decode(jsonObject![selectedSheet]))[
                                  selectedColumn]["min"]
                              .toString(),
                          header: "Minimum Value",
                          isDisabled: (json.decode(jsonObject![selectedSheet]))[
                                      selectedColumn]["min"] ==
                                  null
                              ? true
                              : false,
                        ),
                        const SummaryCard(
                          value: "--",
                          header: "Total Negative Values",
                          isDisabled: true,
                        ),
                        SummaryCard(
                          value: (json.decode(jsonObject![selectedSheet]))[
                                  selectedColumn]["50%"]
                              .toString(),
                          header: "Median Value",
                          isDisabled: (json.decode(jsonObject![selectedSheet]))[
                                      selectedColumn]["50%"] ==
                                  null
                              ? true
                              : false,
                        ),
                      ],
                    ),

                    ClanChurnSpacing.h30,
                    SummaryCard(
                      value: (json.decode(
                                  jsonObject![selectedSheet]))[selectedColumn]
                              ["mean"]
                          .toString(),
                      header: "Average Value",
                      isDisabled: (json.decode(jsonObject![selectedSheet]))[
                                  selectedColumn]["mean"] ==
                              null
                          ? true
                          : false,
                    ),
                    ClanChurnSpacing.h50,
                    Builder(builder: (ctx) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          OutlinedButtonTemplate(
                            icon: Icons.remove_red_eye_outlined,
                            title: "Excel Summary",
                            onPressed: () {
                              viewErrorReport(
                                  context, jsonObject!, selectedSheet!);
                            },
                          ),
                          OutlinedButtonTemplate(
                            icon: Icons.list_alt_outlined,
                            title: "Group Categorization",
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    backgroundColor: Theme.of(context)
                                        .colorScheme
                                        .background,
                                    surfaceTintColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(08),
                                    ),
                                    title: const Text("Coming Soon!..."),
                                  );
                                },
                              );
                            },
                          ),
                          BlocBuilder<ProjectArchitectBloc,
                              ProjectArchitectState>(
                            builder: (context, state) {
                              return OutlinedButtonTemplate(
                                icon: Icons.sim_card_download_outlined,
                                title: "View Error Report",
                                onHoverTextChange: "Download Error Report",
                                onPressed: () {
                                  context
                                      .read<ProjectArchitectBloc>()
                                      .add(DownloadErrorReportEvent(
                                        inputId: context
                                                .read<ProjectArchitectBloc>()
                                                .state
                                                .createdProject!
                                                .latestInput ??
                                            "",
                                        onSuccessCallback: (message) {
                                          
                                        },
                                        onErrorCallback:
                                            (errorMessage, errorCode) {
                                          print(
                                              "Download Error Report...${state.createdProject!.latestInput}..$errorMessage $errorCode");
                                          GetDialog.failedErrorReport(context);
                                        },
                                      ));
                                },
                              );
                            },
                          ),
                          OutlinedButtonTemplate(
                            icon: Icons.upload_file_outlined,
                            title: "Upload New Sheet",
                            onPressed: widget.uploadNewSheetRequested,
                          ),
                        ],
                      );
                    }),
                    ClanChurnSpacing.h50,
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GetPublishButton(),
                      ],
                    )
                  ],
                ),
              )
            ]),
          );
  }
}
