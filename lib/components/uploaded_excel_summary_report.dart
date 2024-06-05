import 'dart:convert';

import 'package:clan_churn/churn_blocs/project_architect/project_architect_bloc.dart';
import 'package:clan_churn/utils/spacing.dart';
import 'package:clan_churn/utils/typography.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';

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
              onErrorCallback: (errorMessage, errorCode) {},
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
                              showPopup(context, jsonObject!, selectedSheet!);
                            },
                          ),
                          OutlinedButtonTemplate(
                            icon: Icons.list_alt_outlined,
                            title: "Group Categorization",
                            onPressed: () {},
                          ),
                          OutlinedButtonTemplate(
                            icon: Icons.sim_card_download_outlined,
                            title: "View Error Report",
                            onPressed: () {},
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

class SummaryCard extends StatefulWidget {
  const SummaryCard(
      {super.key,
      required this.value,
      required this.header,
      required this.isDisabled});
  final String value;
  final String header;
  final bool isDisabled;

  @override
  State<SummaryCard> createState() => _SummaryCardState();
}

class _SummaryCardState extends State<SummaryCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 243,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(05),
          color: widget.isDisabled
              ? Theme.of(context).colorScheme.secondary.withOpacity(0.8)
              : Theme.of(context).colorScheme.primary.withOpacity(0.8)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(widget.isDisabled ? "--" : widget.value,
              style: ClanChurnTypography.font22600
                  .copyWith(color: Theme.of(context).colorScheme.background)),
          Text(widget.header,
              style: ClanChurnTypography.font18500
                  .copyWith(color: Theme.of(context).colorScheme.background))
        ],
      ),
    );
  }
}

class OutlinedButtonTemplate extends StatefulWidget {
  const OutlinedButtonTemplate(
      {super.key,
      required this.icon,
      required this.title,
      required this.onPressed});
  final IconData icon;
  final String title;
  final VoidCallback onPressed;

  @override
  State<OutlinedButtonTemplate> createState() => _OutlinedButtonTemplateState();
}

class _OutlinedButtonTemplateState extends State<OutlinedButtonTemplate> {
  bool hovered = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        setState(() {
          hovered = true;
        });
      },
      onExit: (event) {
        setState(() {
          hovered = false;
        });
      },
      child: SizedBox(
        height: 52,
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.only(left: 20, right: 20),
            backgroundColor: hovered
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.background,
            foregroundColor: hovered
                ? Theme.of(context).colorScheme.background
                : Theme.of(context).colorScheme.primary,
            side: BorderSide(
                color: Theme.of(context).colorScheme.primary,
                width: 1.5), // Adjust the border side
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(8), // Adjust the border radius
            ),
          ),
          onPressed: widget.onPressed,
          child: Row(
            children: [
              Icon(
                widget.icon,
              ),
              ClanChurnSpacing.w10,
              Text(
                widget.title,
                style: ClanChurnTypography.font18600, // Custom text style
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GetPublishButton extends StatefulWidget {
  const GetPublishButton({super.key});

  @override
  State<GetPublishButton> createState() => _GetPublishButtonState();
}

class _GetPublishButtonState extends State<GetPublishButton> {
  bool value = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Checkbox(
              value: value,
              onChanged: (bool? v) {
                setState(() {
                  if (v != null) {
                    value = v;
                  }
                });
              },
            ),
            Text(
              "I confirm the data is correct",
              style: ClanChurnTypography.font18500,
            ),
          ],
        ),
        ClanChurnSpacing.h20,
        Row(
          children: [
            SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: value ? () {} : null,
                child: Row(
                  children: [
                    Text(
                      "Publish",
                      style: ClanChurnTypography.font18600,
                    ),
                    ClanChurnSpacing.w10,
                    const Icon(Icons.arrow_circle_right_outlined),
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}

void showPopup(
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
          ],
        ),
      ),
      actions: <Widget>[
        BasicDialogAction(
          title: const Text("Close"),
          onPressed: () {
            Navigator.pop(ctx);
          },
        ),
      ],
    ),
  );
}
