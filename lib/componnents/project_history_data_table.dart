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
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                // Search
                Container(
                  height: 30,
                  width: w * 0.5,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(12)),
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                        hintText: "Enter something to filter"),
                    onChanged: (value) {
                      setState(() {
                        myData = filterData!
                            .where((element) =>
                                element.projectDoneBy!.contains(value))
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
              source: RowSource(
                myData: myData,
                count: myData.length,
              ),
              rowsPerPage: 8,
              columnSpacing: 8,
              columns: [
                const DataColumn(
                  label: Text(
                    "Project ID",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                ),
                DataColumn(
                    label: const Text(
                      "Sheet Name",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                    ),
                    onSort: (columnIndex, ascending) {
                      setState(() {
                        sort = !sort;
                      });

                      onsortColum(columnIndex, ascending);
                    }),
                const DataColumn(
                  label: Text(
                    "Project Done By",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                ),
                const DataColumn(
                  label: Text(
                    "Uploaded Date",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                ),
                const DataColumn(
                  label: Text(
                    " ",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                ),
                const DataColumn(
                  label: Text(
                    "Status",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
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
  RowSource({
    required this.myData,
    required this.count,
  });

  @override
  DataRow? getRow(int index) {
    if (index < rowCount) {
      return recentFileDataRow(myData![index]);
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

DataRow recentFileDataRow(Data data) {
  return DataRow(
    cells: [
      DataCell(Text(data.projectId)),
      DataCell(Text(data.sheetName)),
      DataCell(Text(data.projectDoneBy)),
      DataCell(Text(data.uploadedDate.toString())),
      DataCell(Text(data.status)),
      DataCell(OutlinedButton(
        child: Text(
          "View",
        ),
        onPressed: () {},
      )),
    ],
  );
}
