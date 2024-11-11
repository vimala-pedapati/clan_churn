// import 'dart:convert';

// import 'package:clan_churn/churn_blocs/project_architect/project_architect_bloc.dart';
// import 'package:clan_churn/components/dialogs.dart';
// import 'package:clan_churn/components/outlined_button_template.dart';
// import 'package:clan_churn/components/project_input_history.dart';
// import 'package:clan_churn/components/project_publish.dart';
// import 'package:clan_churn/components/summary_card.dart';
// import 'package:clan_churn/components/view_error_report.dart';
// import 'package:clan_churn/utils/spacing.dart';
// import 'package:clan_churn/utils/typography.dart';
// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class UploadedExcelSummaryReport extends StatefulWidget {
//   const UploadedExcelSummaryReport(  {super.key, required this.onPressed,  required this.uploadNewSheetRequested});
//   final Function() onPressed;  final VoidCallback uploadNewSheetRequested;
//   @override
//   State<UploadedExcelSummaryReport> createState() =>  _UploadedExcelSummaryReportState();}

// class _UploadedExcelSummaryReportState extends State<UploadedExcelSummaryReport> {
//   Map<String, dynamic>? jsonObject;
//   String? selectedSheet; String? selectedColumn; List<String> sheets = []; List<String> columns = []; List<Widget> widgets = [];
//   @override
//   void initState() {
//     if (context.read<ProjectArchitectBloc>().state.createdProject != null) {
//       if (context .read<ProjectArchitectBloc>().state.createdProject!.latestInput != null) {
//         context.read<ProjectArchitectBloc>().add(GetInputExcelSummaryEvent(inputId: context.read<ProjectArchitectBloc>().state.createdProject!.latestInput!,
//               onErrorCallback: (errorMessage, errorCode) { if (kDebugMode) {  print( "Get Input Excel Summary Report error call back: $errorMessage $errorCode");}},
//               onSuccessCallback: (message) {
//                 if (message != null) {
//                   if (kDebugMode) { print( "Get Input Excel Summary Report: ${json.decode(message.body)}"); }
//                   setState(() {  jsonObject = json.decode(message.body); });
//                   updateSelectedSheet(data: jsonObject!);
//                 }
//               },
//             ));
//       }
//     }
//     super.initState();
//   }
//   void updateSelectedSheet({required Map<String, dynamic> data, String? selectedSheet}) {
//     if (selectedSheet == null) {
//       setState(() {
//         sheets = data.keys.toList();
//         if (sheets.isNotEmpty) { selectedSheet = sheets[0]; updatedSelectedSheetColumns(data: data, selectedSheetKey: selectedSheet!); }
//       });
//     } else {
//       updatedSelectedSheetColumns(data: data, selectedSheetKey: selectedSheet);
//     }
//   }
//   void updatedSelectedSheetColumns( {required Map<String, dynamic> data, required String selectedSheetKey}) {
//     setState(() {
//       selectedSheet = selectedSheetKey;
//       columns = json.decode(data[selectedSheetKey]).keys.toList();
//       if (columns.isNotEmpty) { selectedColumn = columns[0];}
//       updatedSelectedSheetColumnWidgets(selectedCol: selectedColumn!, selectedShe: selectedSheetKey);
//     });
//   }
//   void updatedSelectedSheetColumnWidgets(
//       {required String selectedShe, required String selectedCol}) {
//     setState(() {
//       selectedColumn = selectedCol;
//       widgets = [];
//       ((json.decode(jsonObject![selectedSheet]))[selectedColumn] as Map<String, dynamic>).map(
//         (key, value) {
//           setState(() { widgets.add(Row(children: [Text("$key : "), Text("$value")],));});
//           return MapEntry(key, value);
//         },
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//       // header - upload data, history button
//       Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Row(
//             children: [
//               IconButton(
//                 icon: Icon(
//                   Icons.keyboard_backspace,
//                   color: Theme.of(context).colorScheme.secondary,
//                 ),
//                 onPressed: widget.onPressed,
//               ),
//               ClanChurnSpacing.w10,
//               SelectableText(
//                 "Upload Data",
//                 style: ClanChurnTypography.font18600,
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 45,
//             width: 130,
//             child: OutlinedButton(
//               style: OutlinedButton.styleFrom(
//                 padding: const EdgeInsets.all(0),
//                 side: BorderSide(
//                     color: Theme.of(context).colorScheme.primary, width: 1.5),
//                 shape: RoundedRectangleBorder(
//                   borderRadius:
//                       BorderRadius.circular(8), // Adjust the border radius
//                 ),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   const Icon(Icons.history),
//                   Text(
//                     "History",
//                     style: ClanChurnTypography.font18600
//                         .copyWith(color: Theme.of(context).colorScheme.primary),
//                   ),
//                 ],
//               ),
//               onPressed: () {
//                 showHistory(context);
//               },
//             ),
//           ),
//         ],
//       ),
//       jsonObject == null
//           ? Expanded( child: Center( child: Image.asset( "assets/loading.gif", width: 30) ))
//           : SingleChildScrollView(
//               child: Container(
//                 color: Colors.amber,
//                 child: Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(left: 0, right: 50, top: 10, bottom: 30),
//                       child: Row(
//                         children: [
//                           // Sheets Dropdown
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Text(  "Select Sheet", style: ClanChurnTypography.font18500,),
//                               ClanChurnSpacing.h10,
//                               SizedBox(
//                                 width: 400,
//                                 child: DropdownButtonHideUnderline(
//                                   child: DropdownButton2<String>(
//                                     isExpanded: true,
//                                     hint: Row(children: [Text('Select Sheet',style: ClanChurnTypography.font18500,overflow: TextOverflow.ellipsis)]),
//                                     items: sheets.map((String item) =>  DropdownMenuItem<String>( value: item, child: Text( item,style: ClanChurnTypography .font18500 .copyWith(color: Theme.of(context).colorScheme.background),overflow: TextOverflow.ellipsis, ),)).toList(),
//                                     value: selectedSheet,
//                                     onChanged: (value) { updateSelectedSheet( data: jsonObject!, selectedSheet: value);},
//                                     selectedItemBuilder: (BuildContext context) { return sheets.map((String item) { return Center( child: Row( crossAxisAlignment:  CrossAxisAlignment.start, children: [Text(item, style: ClanChurnTypography.font18500.copyWith( color:  Theme.of(context) .colorScheme.secondary)),],),); }).toList();},
//                                     buttonStyleData: ButtonStyleData(
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(8),
//                                         border: Border.all(color: Theme.of(context).colorScheme.primary.withOpacity(0.6)),
//                                         color: Theme.of(context).colorScheme.primary.withOpacity(0.2)),
//                                       elevation: 0,
//                                     ),
//                                     iconStyleData: IconStyleData(
//                                       icon: const Icon(Icons.keyboard_arrow_down),
//                                       iconSize: 25,
//                                       iconEnabledColor: Theme.of(context).colorScheme.secondary,
//                                       iconDisabledColor: Colors.grey,
//                                     ),
//                                     dropdownStyleData: DropdownStyleData(
//                                       elevation: 0,
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(8),
//                                         border: Border.all(color: Theme.of(context).colorScheme.primary.withOpacity(0.6)),
//                                         color: Theme.of(context).colorScheme.primary.withOpacity(1.0),
//                                       ),
//                                       scrollbarTheme: ScrollbarThemeData(
//                                         radius: const Radius.circular(40),
//                                         thickness: MaterialStateProperty.all(6),
//                                         thumbVisibility: MaterialStateProperty.all(true),
//                                       ),
//                                     ),
//                                     menuItemStyleData: const MenuItemStyleData(height: 40, padding:  EdgeInsets.only(left: 14, right: 14),),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           ClanChurnSpacing.w50,
//                           // Column DropDown
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Text(  "Select Column",  style: ClanChurnTypography.font18500, ),
//                               ClanChurnSpacing.h10,
//                               SizedBox(
//                                 width: 400,
//                                 child: DropdownButtonHideUnderline(
//                                   child: DropdownButton2<String>(
//                                     isExpanded: true,
//                                     hint: Row(
//                                       children: [
//                                         Text('Select Column', style: ClanChurnTypography.font18500, overflow: TextOverflow.ellipsis, ),
//                                       ],
//                                     ),
//                                     items: columns .map((String item) =>  DropdownMenuItem<String>(  value: item, child: Text(item,style: ClanChurnTypography.font18500.copyWith( color: Theme.of(context).colorScheme.background),overflow: TextOverflow.ellipsis),)).toList(),
//                                     selectedItemBuilder: (BuildContext context) {return columns.map((String item) {return Center( child: Row(crossAxisAlignment:  CrossAxisAlignment.start, children: [ Text(item, style: ClanChurnTypography .font18500 .copyWith(  color:  Theme.of(context) .colorScheme .secondary)),],),);}).toList(); },
//                                     value: selectedColumn,
//                                     onChanged: (value) {updatedSelectedSheetColumnWidgets(selectedShe: selectedSheet!, selectedCol: value!);},
//                                     buttonStyleData: ButtonStyleData(
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(8),
//                                         border: Border.all(color: Theme.of(context).colorScheme.primary.withOpacity(0.6)),
//                                         color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
//                                       ),
//                                       elevation: 0,
//                                     ),
//                                     iconStyleData: IconStyleData(
//                                       icon: const Icon(Icons.keyboard_arrow_down ),
//                                       iconSize: 25,
//                                       iconEnabledColor: Theme.of(context).colorScheme.secondary,
//                                       iconDisabledColor: Colors.grey,
//                                     ),
//                                     dropdownStyleData: DropdownStyleData(
//                                       elevation: 0,
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(8),
//                                         border: Border.all(color: Theme.of(context).colorScheme.primary.withOpacity(0.6)),
//                                         color: Theme.of(context).colorScheme.primary.withOpacity(1.0),
//                                       ),
//                                       scrollbarTheme: ScrollbarThemeData(
//                                         radius: const Radius.circular(40),
//                                         thickness: MaterialStateProperty.all(6),
//                                         thumbVisibility: MaterialStateProperty.all(true),
//                                       ),
//                                     ),
//                                     menuItemStyleData: const MenuItemStyleData( height: 40,  padding: EdgeInsets.only(left: 14, right: 14)),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                     // (selectedSheet != null)
//                     //     ? (selectedColumn != null)
//                     //         ? Column(
//                     //             children: [
//                     //               Container(
//                     //                   // width: 00,
//                     //                   child: Text(
//                     //                       "${jsonObject[selectedSheet][selectedColumn]}")),
//                     //               Row(
//                     //                 children: [...widgets],
//                     //               ),
//                     //             ],
//                     //           )
//                     //         : Container()
//                     //     : Container(),
//                     ClanChurnSpacing.h20,
//                     // summary details
//                     Padding(
//                       padding: const EdgeInsets.only(left: 0, right: 0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               SummaryCard(
//                                 value:  (json.decode(jsonObject![selectedSheet]))[  selectedColumn]["count"].toString(),
//                                 header: "Total Rows",
//                                 isDisabled: (json.decode(jsonObject![selectedSheet]))[selectedColumn]["count"] == null ? true : false,
//                               ),
//                               const SummaryCard( value: "--", header: "Total Zeros", isDisabled: true,),
//                               const SummaryCard( value: "--", header: "Total Blanks",isDisabled: true,),
//                               const SummaryCard( value: "--", header: 'Total "NA" values',  isDisabled: true,),
//                             ],
//                           ),
//                           ClanChurnSpacing.h30,
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               SummaryCard(
//                                 value: (json.decode(jsonObject![selectedSheet]))[ selectedColumn]["max"].toString(),
//                                 header: "Maximum Value",
//                                 isDisabled: (json.decode(jsonObject![selectedSheet]))[  selectedColumn]["max"] ==  null  ? true : false,
//                               ),
//                               SummaryCard(
//                                 value: (json.decode(jsonObject![selectedSheet]))[selectedColumn]["min"].toString(),
//                                 header: "Minimum Value",
//                                 isDisabled: (json.decode(jsonObject![selectedSheet]))[ selectedColumn]["min"] == null ? true : false,
//                               ),
//                               const SummaryCard(  value: "--", header: "Total Negative Values",  isDisabled: true,),
//                               SummaryCard(
//                                 value: (json.decode(jsonObject![selectedSheet]))[ selectedColumn]["50%"].toString(),
//                                 header: "Median Value",
//                                 isDisabled: (json.decode(jsonObject![selectedSheet]))[  selectedColumn]["50%"] ==  null ? true : false,
//                               ),
//                             ],
//                           ),
//                           ClanChurnSpacing.h30,
//                           SummaryCard(
//                             value: (json.decode(jsonObject![selectedSheet]))[selectedColumn]["mean"].toString(),
//                             header: "Average Value",
//                             isDisabled:  (json.decode(jsonObject![selectedSheet]))[selectedColumn]["mean"] ==  null  ? true : false,
//                           ),
//                           ClanChurnSpacing.h50,
//                           Builder(builder: (ctx) {
//                             return Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 OutlinedButtonTemplate(
//                                   icon: Icons.remove_red_eye_outlined,
//                                   title: "Excel Summary",
//                                   onPressed: () {viewErrorReport( context, jsonObject!, selectedSheet!); },
//                                 ),
//                                 OutlinedButtonTemplate(
//                                   icon: Icons.list_alt_outlined,
//                                   title: "Group Categorization",
//                                   onPressed: () {
//                                     showDialog(
//                                       context: context,
//                                       builder: (context) {
//                                         return AlertDialog(
//                                           backgroundColor: Theme.of(context).colorScheme.background,
//                                           surfaceTintColor: Colors.transparent,
//                                           shape: RoundedRectangleBorder(  borderRadius: BorderRadius.circular(08),),
//                                           title: const Text("Coming Soon!..."),
//                                         );
//                                       },
//                                     );
//                                   },
//                                 ),
//                                 BlocBuilder<ProjectArchitectBloc,
//                                     ProjectArchitectState>(
//                                   builder: (context, state) {
//                                     return OutlinedButtonTemplate(
//                                       icon: Icons.sim_card_download_outlined,
//                                       title: "View Error Report",
//                                       onHoverTextChange: "Download Error Report",
//                                       onPressed: () {
//                                         context .read<ProjectArchitectBloc>()
//                                             .add(DownloadErrorReportEvent(
//                                               context: context,
//                                               inputId: context .read<ProjectArchitectBloc>().state.createdProject!.latestInput ?? "",
//                                               onSuccessCallback: (message) {},
//                                               onErrorCallback:  (errorMessage, errorCode) {
//                                                 print(  "Download Error Report...${state.createdProject!.latestInput}..$errorMessage $errorCode");
//                                                 GetDialog.failedErrorReport( context);
//                                               },
//                                             ));
//                                       },
//                                     );
//                                   },
//                                 ),
//                                 OutlinedButtonTemplate(
//                                   icon: Icons.upload_file_outlined,
//                                   title: "Upload New Sheet",
//                                   onPressed: widget.uploadNewSheetRequested,
//                                 ),
//                               ],
//                             );
//                           }),
//                           ClanChurnSpacing.h50,
//                           const Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               GetPublishButton(),
//                             ],
//                           )
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             )
//     ]);
//   }
// }

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

import 'dart:convert';

import 'package:clan_churn/api_repos/models/project_model.dart';
import 'package:clan_churn/churn_blocs/project_architect/project_architect_bloc.dart';
import 'package:clan_churn/components/dialogs.dart';
import 'package:clan_churn/components/outlined_button_template.dart';
import 'package:clan_churn/components/project_input_history.dart';
import 'package:clan_churn/components/project_publish.dart';
import 'package:clan_churn/components/summary_card.dart';
import 'package:clan_churn/components/view_error_report.dart';
import 'package:clan_churn/utils/spacing.dart';
import 'package:clan_churn/utils/typography.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Define the UploadedExcelSummaryReport widget
class UploadedExcelSummaryReport extends StatefulWidget {
  const UploadedExcelSummaryReport({
    Key? key,
    required this.onPressed,
    required this.uploadNewSheetRequested,
  }) : super(key: key);

  final Function() onPressed;
  final VoidCallback uploadNewSheetRequested;

  @override
  State<UploadedExcelSummaryReport> createState() => _UploadedExcelSummaryReportState();
}

// State class for UploadedExcelSummaryReport widget
class _UploadedExcelSummaryReportState extends State<UploadedExcelSummaryReport> {
  // Properties
  Map<String, dynamic>? jsonObject;
  bool isDataLoading = true;
  String? selectedSheet;
  String? selectedColumn;
  List<String> sheets = [];
  List<String> columns = [];
  List<Widget> widgets = [];
  final PageController pageController = PageController();
  int currentPage = 0;

  // Initialization logic
  @override
  void initState() {
    super.initState();
    initializeData();
    context.read<ProjectArchitectBloc>().add(GetAllReportsEvent(
          onErrorCallback: (errorMessage, errorCode) {},
          onSuccessCallback: (message) {},
        ));
  }

  // void goToNextPage() {
  //   if (currentPage < 3) {
  //     currentPage++;
  //     pageController.animateToPage(
  //       currentPage,
  //       duration: const Duration(milliseconds: 300),
  //       curve: Curves.easeInOut,
  //     );
  //   }
  // }

  // void goToPreviousPage() {
  //   if (currentPage > 0) {
  //     currentPage--;
  //     pageController.animateToPage(
  //       currentPage,
  //       duration: const Duration(milliseconds: 300),
  //       curve: Curves.easeInOut,
  //     );
  //   }
  // }

  // Method to initialize data
  void initializeData() {
    setState(() {
      isDataLoading = true;
    });
    if (context.read<ProjectArchitectBloc>().state.createdProject != null) {
      if (context.read<ProjectArchitectBloc>().state.createdProject!.latestInput != null) {
        context.read<ProjectArchitectBloc>().add(GetInputExcelSummaryEvent(
              inputId: context.read<ProjectArchitectBloc>().state.createdProject!.latestInput!,
              onErrorCallback: (errorMessage, errorCode) {
                setState(() {
                  isDataLoading = false;
                });
                if (kDebugMode) {
                  print("Get Input Excel Summary Report error call back: $errorMessage $errorCode");
                }
              },
              onSuccessCallback: (message) {
                if (message != null) {
                  if (kDebugMode) {
                    print("Get Input Excel Summary Report: ${json.decode(message.body)}");
                  }
                  setState(() {
                    jsonObject = json.decode(message.body);
                    isDataLoading = false;
                  });
                  updateSelectedSheet(data: jsonObject!);
                }
              },
            ));
      }
    }
  }

  // Method to update selected sheet
  void updateSelectedSheet({required Map<String, dynamic> data, String? selectedSheet}) {
    if (selectedSheet == null) {
      setState(() {
        sheets = data.keys.toList();
        if (sheets.isNotEmpty) {
          selectedSheet = sheets[0];
          updatedSelectedSheetColumns(data: data, selectedSheetKey: selectedSheet!);
        }
      });
    } else {
      updatedSelectedSheetColumns(data: data, selectedSheetKey: selectedSheet);
    }
  }

  // Method to update selected sheet columns
  void updatedSelectedSheetColumns({required Map<String, dynamic> data, required String selectedSheetKey}) {
    setState(() {
      selectedSheet = selectedSheetKey;
      columns = data[selectedSheetKey].keys.toList();
      if (columns.isNotEmpty) {
        selectedColumn = columns[0];
      }
      updatedSelectedSheetColumnWidgets(selectedShe: selectedSheetKey, selectedCol: selectedColumn!);
    });
  }

  // Method to update selected sheet column widgets
  void updatedSelectedSheetColumnWidgets({required String selectedShe, required String selectedCol}) {
    setState(() {
      selectedColumn = selectedCol;
      widgets = [];
      ((jsonObject![selectedSheet])[selectedColumn] as Map<String, dynamic>).forEach((key, value) {
        setState(() {
          widgets.add(Row(
            children: [
              Text("$key : "),
              Text("$value"),
            ],
          ));
        });
      });
    });
  }

  // Build method for the widget
  @override
  Widget build(BuildContext context) {
    return PageView(
      // physics : const NeverScrollableScrollPhysics(),
      //  controller: pageController,
      //       onPageChanged: (int page) {
      //         setState(() {
      //           currentPage = page;
      //         });
      //       },
      children: [
        BlocBuilder<ProjectArchitectBloc, ProjectArchitectState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // BlocBuilder<ProjectArchitectBloc, ProjectArchitectState>(
                //   builder: (context, state) {
                //     return Text("${state.createdProject?.latestInputModel?.inputStatus}");
                //   },
                // ),
                // Header section
                buildHeader(),

                if (isDataLoading)
                  buildLoadingIndicator()
                else if (state.createdProject?.latestInputModel?.inputStatus != null)
                  if (state.createdProject?.latestInputModel?.inputStatus == InputStatus.uploadedDataUnsuccessful)
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: Expanded(
                        flex: 3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          // mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              "⚠️ Oops! We couldn’t fetch your project summary.\n\n"
                              "📄 It looks like there might be an issue with the uploaded data.\n\n"
                              "🔍 Please double-check your sheet to ensure everything was uploaded correctly.\n\n"
                              "✅ Once confirmed, try accessing the summary again!",
                              textAlign: TextAlign.center,
                            ),
                            buildActionButtons(
                              disableCategorization: true,
                              disableExcelSummary: true,
                              disableViewErrorReport: true,
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                IgnorePointer(
                                    child: Opacity(
                                  opacity: 0.5,
                                  child: GetPublishButton(),
                                )),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  else if (state.createdProject?.latestInputModel?.inputStatus == InputStatus.uploadedDataSuccessful && jsonObject != null)
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            buildSheetsAndColumnsDropdowns(),
                            buildSummaryDetails(),
                            buildActionButtons(
                              disableUploadNewSheet: true,
                              disableCategorization: true,
                            ),
                            ClanChurnSpacing.h20,
                            const Text(
                              "✅ Note: Your data upload was successful.\n"
                              "📥 To proceed, click 'View Error Report' to generate any error reports.\n"
                              "✏️ If an error sheet is downloaded, review and correct the issues. After uploading the corrected sheet, the 'Publish' button will be enabled, allowing you to generate marts.",
                              textAlign: TextAlign.center,
                            ),
                            ClanChurnSpacing.h20,
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                IgnorePointer(
                                    child: Opacity(
                                  opacity: 0.5,
                                  child: GetPublishButton(),
                                )),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  else if (state.createdProject?.latestInputModel?.inputStatus == InputStatus.uploadedDataHasErrors && jsonObject != null)
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            buildSheetsAndColumnsDropdowns(),
                            buildSummaryDetails(),
                            buildActionButtons(
                              disableCategorization: true,
                            ),
                            ClanChurnSpacing.h20,
                            const Text(
                              "⚠️ Note: The uploaded data has errors.\n📥 Please download the error sheet.\n✏️ Correct the errors and re-upload the data.",
                              textAlign: TextAlign.center,
                            ),
                            ClanChurnSpacing.h20,
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                IgnorePointer(
                                    child: Opacity(
                                  opacity: 0.5,
                                  child: GetPublishButton(),
                                )),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  else if (state.createdProject?.latestInputModel?.inputStatus == InputStatus.uploadedDataHasNoErrors && jsonObject != null)
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            buildSheetsAndColumnsDropdowns(),
                            buildSummaryDetails(),
                            buildActionButtons(
                              disableCategorization: true,
                              disableUploadNewSheet: true,
                              disableViewErrorReport: true,
                            ),
                            ClanChurnSpacing.h20,
                            const Text(
                              "✅ Note: The uploaded data has no errors.\n"
                              "📊 You can now proceed to generate the data marts by clicking 'Publish'.",
                              textAlign: TextAlign.center,
                            ),
                            ClanChurnSpacing.h20,
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                GetPublishButton(),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  else if (state.createdProject?.latestInputModel?.inputStatus == InputStatus.uploadedDataDataMartsGenerated && jsonObject != null)
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            buildSheetsAndColumnsDropdowns(),
                            buildSummaryDetails(),
                            buildActionButtons(
                              disableCategorization: true,
                              disableUploadNewSheet: true,
                              disableViewErrorReport: true,
                            ),
                            ClanChurnSpacing.h20,
                            const Text(
                              "✅ Note: Data marts have been successfully generated for the uploaded data.\n"
                              "📊 You can now view the reports by clicking on 'Reports'.",
                              textAlign: TextAlign.center,
                            ),
                            ClanChurnSpacing.h20,
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                GetPublishButton(),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  else if (state.createdProject?.latestInputModel?.inputStatus == InputStatus.uploadedDataDataMartsCannotBeGenerated && jsonObject != null)
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            buildSheetsAndColumnsDropdowns(),
                            buildSummaryDetails(),
                            buildActionButtons(
                              disableCategorization: true,
                              disableViewErrorReport: true,
                            ),
                            ClanChurnSpacing.h20,
                            const Text(
                              "⚠️ Note: Data marts cannot be generated with the current data.\n\n"
                              "📥 Please try uploading data that can be used to generate marts.",
                              textAlign: TextAlign.center,
                            ),
                            ClanChurnSpacing.h20,
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                IgnorePointer(
                                  child: Opacity(
                                    opacity: 0.5,
                                    child: GetPublishButton(),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  else
                    const Center(
                      child: Text(
                        "⚠️ Unable to retrieve the status of your input sheet or summary of your input sheet. Please contact the admin for assistance.",
                        textAlign: TextAlign.center,
                      ),
                    )
              ],
            );
          },
        ),
      ],
    );
  }

  // Header section UI
  Widget buildHeader() {
    return Row(
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
              style: ClanChurnTypography.font16600,
            ),
          ],
        ),
        buildHistoryButton(),
      ],
    );
  }

  // Widget for history button
  Widget buildHistoryButton() {
    return SizedBox(
      height: 30,
      width: 120,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.all(0),
          side: BorderSide(color: Theme.of(context).colorScheme.primary, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Icon(
              Icons.history,
              size: 20,
            ),
            Text(
              "History",
              style: ClanChurnTypography.font14900.copyWith(color: Theme.of(context).colorScheme.primary),
            ),
          ],
        ),
        onPressed: () {
          showHistory(context);
        },
      ),
    );
  }

  // Loading indicator UI
  Widget buildLoadingIndicator() {
    return Expanded(
      child: Center(
        child: Image.asset("assets/upload.gif", width: 100),
      ),
    );
  }

  // Data view UI
  Widget buildDataView() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            buildSheetsAndColumnsDropdowns(),
            buildSummaryDetails(),
            buildActionButtons(),
            ClanChurnSpacing.h20,
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GetPublishButton(),
              ],
            )
          ],
        ),
      ),
    );
  }

  // Widgets for sheets and columns dropdowns
  Widget buildSheetsAndColumnsDropdowns() {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0, top: 10, bottom: 20),
      child: Row(
        children: [
          // Sheets Dropdown
          buildSheetsDropdown(),
          ClanChurnSpacing.w50,
          // Columns Dropdown
          buildColumnsDropdown(),
        ],
      ),
    );
  }

  // Widget for sheets dropdown
  Widget buildSheetsDropdown() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "Select Sheet",
          style: ClanChurnTypography.font14900,
        ),
        ClanChurnSpacing.w10,
        SizedBox(
          width: 300,
          height: 30,
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              isExpanded: true,
              hint: Row(children: [
                Text(
                  'Select Sheet',
                  style: ClanChurnTypography.font14900,
                  overflow: TextOverflow.ellipsis,
                )
              ]),
              items: sheets
                  .map((String item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: ClanChurnTypography.font14900.copyWith(color: Theme.of(context).colorScheme.background),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ))
                  .toList(),
              value: selectedSheet,
              onChanged: (value) {
                updateSelectedSheet(data: jsonObject!, selectedSheet: value);
              },
              selectedItemBuilder: (BuildContext context) {
                return sheets.map((String item) {
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
    );
  }

  // Widget for columns dropdown
  Widget buildColumnsDropdown() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "Select Column",
          style: ClanChurnTypography.font14900,
        ),
        ClanChurnSpacing.w10,
        SizedBox(
          height: 30,
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
              // items: columns
              //     .map((String item) => DropdownMenuItem<String>(
              //           value: item,
              //           child: Text(
              //             item,
              //             style: ClanChurnTypography.font14900.copyWith(color: Theme.of(context).colorScheme.background),
              //             overflow: TextOverflow.ellipsis,
              //           ),
              //         ))
              //     .toList(),
              items: columns
                  .map((String item) => DropdownMenuItem<String>(
                        value: item,
                        child: SizedBox(
                          width: 260, // Set a fixed width to constrain the text
                          child: Text(
                            item,
                            style: ClanChurnTypography.font14900.copyWith(
                              color: Theme.of(context).colorScheme.background,
                            ),
                            overflow: TextOverflow.ellipsis, // Ellipsis to handle overflow
                            maxLines: 1,
                          ),
                        ),
                      ))
                  .toList(),
              selectedItemBuilder: (BuildContext context) {
                return columns.map((String item) {
                  return Center(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 240,
                          child: Text(
                            item,
                            style: ClanChurnTypography.font14900.copyWith(color: Theme.of(context).colorScheme.secondary),
                            overflow: TextOverflow.ellipsis, // Ellipsis to handle overflow
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList();
              },
              value: selectedColumn,
              onChanged: (value) {
                updatedSelectedSheetColumnWidgets(selectedShe: selectedSheet!, selectedCol: value!);
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
    );
  }

  // Widget for summary details
  Widget buildSummaryDetails() {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0, bottom: 20),
      child: Wrap(
        runSpacing: 10,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildSummaryCard(
                value: (jsonObject![selectedSheet])[selectedColumn]["count"].toString(),
                header: "Total Rows",
                isDisabled: (jsonObject![selectedSheet])[selectedColumn]["count"] == null ? true : false,
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
                value: '--',
                header: 'Total "NA" values',
                isDisabled: true,
              ),
            ],
          ),
          ClanChurnSpacing.h30,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildSummaryCard(
                value: (jsonObject![selectedSheet])[selectedColumn]["max"].toString(),
                header: "Maximum Value",
                isDisabled: (jsonObject![selectedSheet])[selectedColumn]["max"] == null ? true : false,
              ),
              buildSummaryCard(
                value: jsonObject![selectedSheet][selectedColumn]["min"].toString(),
                header: "Minimum Value",
                isDisabled: (jsonObject![selectedSheet])[selectedColumn]["min"] == null ? true : false,
              ),
              const SummaryCard(
                value: "--",
                header: "Total Negative Values",
                isDisabled: true,
              ),
              buildSummaryCard(
                value: (jsonObject![selectedSheet])[selectedColumn]["50%"].toString(),
                header: "Median Value",
                isDisabled: (jsonObject![selectedSheet])[selectedColumn]["50%"] == null ? true : false,
              ),
            ],
          ),
          ClanChurnSpacing.h30,
          buildSummaryCard(
            value: (jsonObject![selectedSheet])[selectedColumn]["mean"].toString(),
            header: "Average Value",
            isDisabled: (jsonObject![selectedSheet])[selectedColumn]["mean"] == null ? true : false,
          ),
          ClanChurnSpacing.h50,
        ],
      ),
    );
  }

  // Widget for summary card
  Widget buildSummaryCard({
    required String value,
    required String header,
    required bool isDisabled,
  }) {
    return SummaryCard(
      value: value,
      header: header,
      isDisabled: isDisabled,
    );
  }

  // Widget for action buttons
  Widget buildActionButtons({
    bool disableCategorization = false,
    bool disableExcelSummary = false,
    bool disableViewErrorReport = false,
    bool disableUploadNewSheet = false,
  }) {
    return Builder(builder: (ctx) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          OutlinedButtonTemplate(
            icon: Icons.remove_red_eye_outlined,
            title: "Excel Summary",
            onPressed: disableExcelSummary
                ? null
                : () {
                    viewErrorReport(context, jsonObject!, selectedSheet!);
                  },
          ),
          OutlinedButtonTemplate(
            icon: Icons.list_alt_outlined,
            title: "Group Categorization",
            onPressed: disableCategorization
                ? null
                : () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: Theme.of(context).colorScheme.background,
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
          BlocBuilder<ProjectArchitectBloc, ProjectArchitectState>(
            builder: (context, state) {
              return OutlinedButtonTemplate(
                icon: Icons.sim_card_download_outlined,
                title: "View Error Report",
                onHoverTextChange: "Download Error Report",
                onPressed: disableViewErrorReport
                    ? null
                    : () {
                        GetDialog.uploadFile(context);
                        context.read<ProjectArchitectBloc>().add(DownloadErrorReportEvent(
                              context: context,
                              inputId: context.read<ProjectArchitectBloc>().state.createdProject!.latestInput ?? "",
                              onSuccessCallback: (message) {
                                Navigator.pop(context);
                              },
                              onErrorCallback: (errorMessage, errorCode) {
                                Navigator.pop(context);
                                print("Download Error Report...${state.createdProject!.latestInput}..$errorMessage $errorCode");
                                GetDialog.failedErrorReport(context, errorMessage);
                              },
                            ));
                      },
              );
            },
          ),
          OutlinedButtonTemplate(
            icon: Icons.upload_file_outlined,
            title: "Upload New Sheet",
            onPressed: disableUploadNewSheet ? null : widget.uploadNewSheetRequested,
          ),
        ],
      );
    });
  }
}
