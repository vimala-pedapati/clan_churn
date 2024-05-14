// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clan_churn/componnents/clients_view_component.dart';
import 'package:clan_churn/utils/spacing.dart';
import 'package:clan_churn/utils/typography.dart';
import 'package:flutter/material.dart';

class Data {
  String projectId;
  String sheetName;
  String projectDoneBy;
  DateTime uploadedDate;
  String status;

  Data({
    required this.projectId,
    required this.sheetName,
    required this.projectDoneBy,
    required this.uploadedDate,
    required this.status,
  });
}

List<Data> myData = [
  Data(
      projectDoneBy: "Vimala",
      projectId: '#\$123',
      sheetName: "Piramal_Emp_Data_Oct...",
      uploadedDate: DateTime.now(),
      status: "complete"),
  Data(
      projectDoneBy: "Vishal Sharma",
      projectId: '#\$123',
      sheetName: "Piramal_Emp_Data_Oct...",
      uploadedDate: DateTime.now(),
      status: "complete"),
  Data(
      projectDoneBy: "Vishal Sharma",
      projectId: '#\$123',
      sheetName: "Piramal_Emp_Data_Oct...",
      uploadedDate: DateTime.now(),
      status: "complete"),
  Data(
      projectDoneBy: "Vishal Sharma",
      projectId: '#\$123',
      sheetName: "Piramal_Emp_Data_Oct...",
      uploadedDate: DateTime.now(),
      status: "complete"),
  Data(
      projectDoneBy: "Vishal Sharma",
      projectId: '#\$123',
      sheetName: "Piramal_Emp_Data_Oct...",
      uploadedDate: DateTime.now(),
      status: "complete"),
  Data(
      projectDoneBy: "Vishal Sharma",
      projectId: '#\$123',
      sheetName: "Piramal_Emp_Data_Oct...",
      uploadedDate: DateTime.now(),
      status: "complete"),
  Data(
      projectDoneBy: "Vishal Sharma",
      projectId: '#\$123',
      sheetName: "Piramal_Emp_Data_Oct...",
      uploadedDate: DateTime.now(),
      status: "complete"),
  Data(
      projectDoneBy: "Vishal Sharma",
      projectId: '#\$123',
      sheetName: "Piramal_Emp_Data_Oct...",
      uploadedDate: DateTime.now(),
      status: "complete"),
  Data(
      projectDoneBy: "Vishal Sharma",
      projectId: '#\$123',
      sheetName: "Piramal_Emp_Data_Oct...",
      uploadedDate: DateTime.now(),
      status: "complete"),
  Data(
      projectDoneBy: "Vishal Sharma",
      projectId: '#\$123',
      sheetName: "Piramal_Emp_Data_Oct...",
      uploadedDate: DateTime.now(),
      status: "complete"),
];

class ProjectHistory extends StatefulWidget {
  const ProjectHistory({
    Key? key,
  }) : super(key: key);

  @override
  State<ProjectHistory> createState() => _ProjectHistoryState();
}

class _ProjectHistoryState extends State<ProjectHistory> {
  bool sort = true;
  List<Data>? filterData;

  onsortColum(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      if (ascending) {
        filterData!.sort((a, b) => a.projectDoneBy.compareTo(b.projectDoneBy));
      } else {
        filterData!.sort((a, b) => b.projectDoneBy.compareTo(a.projectDoneBy));
      }
    }
  }

  @override
  void initState() {
    filterData = myData;
    super.initState();
  }

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.filter_alt_outlined,
                      color: Theme.of(context).colorScheme.secondary,
                      size: 18,
                    ),
                    Text(
                      " Filters:",
                      style: ClanChurnTypography.font14500,
                    ),
                    ClanChurnSpacing.w15,
                    // DropDown
                    const GetFiltersDropDown(),
                  ],
                ),
                // Search
                SizedBox(
                  height: 30,
                  width: w * 0.2,
                  // padding: const EdgeInsets.all(5),
                  // decoration: BoxDecoration(
                  //     border: Border.all(
                  //       color: Theme.of(context).colorScheme.secondary.withOpacity(0.6),
                  //     ),
                  //     borderRadius: BorderRadius.circular(12)),
                  child: TextField(
                    controller: controller,
                    cursorHeight: 17,
                    decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.only(left: 10, right: 10),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondary
                                  .withOpacity(0.6),
                              width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondary
                                  .withOpacity(0.6),
                              width: 1.0),
                        ),
                        hintText: "Enter something to filter"),
                    onChanged: (value) {
                      setState(() {
                        myData = filterData!
                            .where((element) =>
                                element.projectDoneBy.contains(value))
                            .toList();
                      });
                    },
                  ),
                ),
              ],
            ),
            PaginatedDataTable(
              sortColumnIndex: 0,
              sortAscending: sort,
              headingRowHeight: 30,
              dataRowMaxHeight: 50,
              dataRowMinHeight: 30,
               availableRowsPerPage: const [2, 8, 10, 25, 50],
              source: RowSource(
                  myData: myData, count: myData.length, context: context),
              rowsPerPage: 8,
              // rowsPerPage: filterData!.length > 8 ? 8 :  filterData!.length,
              columnSpacing: 8,
              
              columns: [
                
                DataColumn(
                  label: SizedBox(
                    width: w * 0.06,
                    child: const Text(
                      "Project ID",
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 14),
                    ),
                  ),
                ),
                DataColumn(
                    label: SizedBox(
                      width: w * 0.12,
                      child: const Text(
                        "Sheet Name",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 14),
                      ),
                    ),
                    onSort: (columnIndex, ascending) {
                      setState(() {
                        sort = !sort;
                      });

                      onsortColum(columnIndex, ascending);
                    }),
                DataColumn(
                  label: SizedBox(
                    width: w * 0.2,
                    child: const Text(
                      "Project Done By",
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 14),
                    ),
                  ),
                ),
                DataColumn(
                  label: SizedBox(
                    width: w * 0.1,
                    child: const Text(
                      "Uploaded Date",
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 14),
                    ),
                  ),
                ),
                DataColumn(
                  label: SizedBox(
                    width: w * 0.1,
                    child: const Text(
                      "Status",
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 14),
                    ),
                  ),
                ),
                DataColumn(
                  label: SizedBox(
                    width: w * 0.1,
                    child: const Text(
                      "",
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 14),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}

class RowSource extends DataTableSource {
  var myData;
  final count;
  final BuildContext context;
  RowSource({required this.myData, required this.count, required this.context});

  @override
  DataRow? getRow(int index) {
    if (index < rowCount) {
      return recentFileDataRow(myData![index], context);
    } else
      return null;
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => count;

  @override
  int get selectedRowCount => 0;
}

DataRow recentFileDataRow(Data data, BuildContext context) {
  return DataRow(
    // color: MaterialStateProperty.all( Theme.of(context).colorScheme.primary.withOpacity(0.1)),
    cells: [
      DataCell(Container(
        margin: const EdgeInsets.only(top: 10, bottom: 10),
        child: Text(data.projectId),
      )),
      DataCell(Text(data.sheetName)),
      DataCell(Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 5),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              child: Icon(Icons.person, size: 20,),
              backgroundColor: Theme.of(context).colorScheme.background,
            ),
            Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data.projectDoneBy),
                Text("Project Head - Piramal"),
              ],
            ),
          ],
        ),
      )),
      DataCell(Text(data.uploadedDate.toString().split(" ")[0])),
      DataCell(Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.check_circle_outlined,
            size: 18,
            color: Colors.green,
          ),
          ClanChurnSpacing.w7,
          Text(data.status),
        ],
      )),
      DataCell(SizedBox(
        height: 25,
        width: 100,
        child: OutlinedButton(
          style: ButtonStyle(
            padding: MaterialStateProperty.all(
                const EdgeInsets.only(top: 0, bottom: 0)),
            side: MaterialStateProperty.all(
                BorderSide(color: Theme.of(context).colorScheme.primary)),
            backgroundColor: MaterialStateProperty.all(
                Theme.of(context).colorScheme.background),
          ),
          child: Text(
            "View",
            style: ClanChurnTypography.font13600,
          ),
          onPressed: () {},
        ),
      )),
    ],
  );
}
