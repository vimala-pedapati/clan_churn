import 'package:clan_churn/utils/spacing.dart';
import 'package:clan_churn/utils/typography.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class UploadedExcelSummaryReport extends StatefulWidget {
  const UploadedExcelSummaryReport({super.key, required this.onPressed});
  final Function() onPressed;

  @override
  State<UploadedExcelSummaryReport> createState() => _UploadedExcelSummaryReportState();
}

class _UploadedExcelSummaryReportState extends State<UploadedExcelSummaryReport> {
  Map<String, dynamic> jsonObject = {
    "Customer Basic Data": {
      "Employee ID": {
        "count": 1.0,
        "unique": null,
        "top": null,
        "freq": null,
        "mean": 12345.0,
        "std": null,
        "min": 12345.0,
        "25%": 12345.0,
        "50%": 12345.0,
        "75%": 12345.0,
        "max": 12345.0
      },
      "Gender": {
        "count": 1,
        "unique": 1,
        "top": "Male",
        "freq": 1,
        "mean": null,
        "std": null,
        "min": null,
        "25%": null,
        "50%": null,
        "75%": null,
        "max": null
      },
      "Date of Birth": {
        "count": 0.0,
        "unique": null,
        "top": null,
        "freq": null,
        "mean": null,
        "std": null,
        "min": null,
        "25%": null,
        "50%": null,
        "75%": null,
        "max": null
      }
    },
    "Customer Work Data": {
      "Employee ID": {
        "count": 1.0,
        "mean": 12345.0,
        "min": 12345.0,
        "25%": 12345.0,
        "50%": 12345.0,
        "75%": 12345.0,
        "max": 12345.0,
        "std": null
      },
      "Date of joining the client": {
        "count": 1,
        "mean": 1694304000000,
        "min": 1694304000000,
        "25%": 1694304000000,
        "50%": 1694304000000,
        "75%": 1694304000000,
        "max": 1694304000000,
        "std": null
      },
      "Date of Joining the Role": {
        "count": 0.0,
        "mean": null,
        "min": null,
        "25%": null,
        "50%": null,
        "75%": null,
        "max": null,
        "std": null
      },
      "On Roll /Consultant": {
        "count": 0.0,
        "mean": null,
        "min": null,
        "25%": null,
        "50%": null,
        "75%": null,
        "max": null,
        "std": null
      },
      "Last working date in Client For Attritted Employees": {
        "count": 0.0,
        "mean": null,
        "min": null,
        "25%": null,
        "50%": null,
        "75%": null,
        "max": null,
        "std": null
      },
      "Designation on the beginning of the study": {
        "count": 0.0,
        "mean": null,
        "min": null,
        "25%": null,
        "50%": null,
        "75%": null,
        "max": null,
        "std": null
      },
      "Branch name or branch code": {
        "count": 0.0,
        "mean": null,
        "min": null,
        "25%": null,
        "50%": null,
        "75%": null,
        "max": null,
        "std": null
      },
      "Current City": {
        "count": 0.0,
        "mean": null,
        "min": null,
        "25%": null,
        "50%": null,
        "75%": null,
        "max": null,
        "std": null
      },
      "State": {
        "count": 0.0,
        "mean": null,
        "min": null,
        "25%": null,
        "50%": null,
        "75%": null,
        "max": null,
        "std": null
      },
      "Region": {
        "count": 0.0,
        "mean": null,
        "min": null,
        "25%": null,
        "50%": null,
        "75%": null,
        "max": null,
        "std": null
      },
      "Zone": {
        "count": 0.0,
        "mean": null,
        "min": null,
        "25%": null,
        "50%": null,
        "75%": null,
        "max": null,
        "std": null
      },
      "Employee ID of Immediate Supervisor in the role": {
        "count": 0.0,
        "mean": null,
        "min": null,
        "25%": null,
        "50%": null,
        "75%": null,
        "max": null,
        "std": null
      }
    },
    "Customer Performance Data": {
      "Employee ID": {"count": 0, "unique": 0, "top": null, "freq": null},
      "Performance calendar Month-Year (e.g. 01-05-23)": {
        "count": 0,
        "unique": 0,
        "top": null,
        "freq": null
      },
      "Product department": {
        "count": 0,
        "unique": 0,
        "top": null,
        "freq": null
      },
      "Performance value target": {
        "count": 0,
        "unique": 0,
        "top": null,
        "freq": null
      },
      "Actual performance value": {
        "count": 0,
        "unique": 0,
        "top": null,
        "freq": null
      },
      "Peformance quantity Target": {
        "count": 0,
        "unique": 0,
        "top": null,
        "freq": null
      },
      "Actual performance quantity": {
        "count": 0,
        "unique": 0,
        "top": null,
        "freq": null
      },
      "Over all performance achievement % as per client": {
        "count": 0,
        "unique": 0,
        "top": null,
        "freq": null
      },
      "Fixed CTC salary INDEX for the month": {
        "count": 0,
        "unique": 0,
        "top": null,
        "freq": null
      },
      "Total incentive paid in Rs in the month": {
        "count": 0,
        "unique": 0,
        "top": null,
        "freq": null
      }
    }
  };
  String? selectedSheet;
  String? selectedColumn;
  List<String> sheets = [];
  List<String> columns = [];
  List<Widget> widgets = [];

  @override
  void initState() {
    updateSelectedSheet(data: jsonObject);
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
      columns = data[selectedSheetKey].keys.toList();
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
      (jsonObject[selectedSheet][selectedColumn] as Map<String, dynamic>).map(
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
    return AnimatedContainer(
      duration: const Duration(seconds: 1),
      // height: h * 0.82,
      // width: widget.width,
      height: MediaQuery.of(context).size.height * 0.85,
      width: MediaQuery.of(context).size.width,
      // margin: EdgeInsets.only( left: w * 0.025, right: w * 0.025, top: 20, bottom: 20),
      // padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
      // decoration: BoxDecoration(
      //     color: Theme.of(context).colorScheme.background,
      //     borderRadius: BorderRadius.circular(30)),

      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
              "Upload New Data",
              style: ClanChurnTypography.font18600,
            ),
          ],
        ),
        Padding(
          padding:
              const EdgeInsets.only(left: 0, right: 50, top: 10, bottom: 30),
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
                            .map((String item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: ClanChurnTypography.font18500
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
                              data: jsonObject, selectedSheet: value);
                        },
                        selectedItemBuilder: (BuildContext context) {
                          return sheets.map((String item) {
                            return Center(
                              child: Expanded(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(item,
                                        style: ClanChurnTypography.font18500
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
                            .map((String item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: ClanChurnTypography.font18500
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(item,
                                        style: ClanChurnTypography.font18500
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
                              selectedShe: selectedSheet!, selectedCol: value!);
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SummaryCard(
                    value: jsonObject[selectedSheet][selectedColumn]["count"]
                        .toString(),
                    header: "Total Rows",
                    isDisabled: jsonObject[selectedSheet][selectedColumn]
                                ["count"] ==
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
                    value: jsonObject[selectedSheet][selectedColumn]["max"]
                        .toString(),
                    header: "Maximum Value",
                    isDisabled:
                        jsonObject[selectedSheet][selectedColumn]["max"] == null
                            ? true
                            : false,
                  ),
                  SummaryCard(
                    value: jsonObject[selectedSheet][selectedColumn]["min"]
                        .toString(),
                    header: "Minimum Value",
                    isDisabled:
                        jsonObject[selectedSheet][selectedColumn]["min"] == null
                            ? true
                            : false,
                  ),
                  const SummaryCard(
                    value: "--",
                    header: "Total Negative Values",
                    isDisabled: true,
                  ),
                  SummaryCard(
                    value: jsonObject[selectedSheet][selectedColumn]["50%"]
                        .toString(),
                    header: "Median Value",
                    isDisabled:
                        jsonObject[selectedSheet][selectedColumn]["50%"] == null
                            ? true
                            : false,
                  ),
                ],
              ),
              ClanChurnSpacing.h30,
              SummaryCard(
                value: jsonObject[selectedSheet][selectedColumn]["mean"]
                    .toString(),
                header: "Average Value",
                isDisabled:
                    jsonObject[selectedSheet][selectedColumn]["mean"] == null
                        ? true
                        : false,
              ),
              ClanChurnSpacing.h50,
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButtonTemplate(
                    icon: Icons.remove_red_eye_outlined,
                    title: "Excel Summary",
                  ),
                  OutlinedButtonTemplate(
                    icon: Icons.list_alt_outlined,
                    title: "Group Categorization",
                  ),
                  OutlinedButtonTemplate(
                    icon: Icons.sim_card_download_outlined,
                    title: "View Error Report",
                  ),
                  OutlinedButtonTemplate(
                    icon: Icons.upload_file_outlined,
                    title: "Upload New Sheet",
                  ),
                ],
              ),
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
      {super.key, required this.icon, required this.title});
  final IconData icon;
  final String title;

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
          onPressed: () {
            // Define the onPressed action here
          },
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
                  value = v!;
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
