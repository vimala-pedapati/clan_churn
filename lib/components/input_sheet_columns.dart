
import 'package:clan_churn/api_repos/models/column_model.dart';
import 'package:clan_churn/churn_blocs/project_architect/project_architect_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InputSheetColumns extends StatelessWidget {
  final List<ColumnDetails> columnsList;
  final List<TextEditingController> customerColumnNames;

  const InputSheetColumns({
    Key? key,
    required this.columnsList,
    required this.customerColumnNames,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Grouping the columns by sheetName
    Map<String, List<ColumnDetails>> groupedColumns =
        groupBySheetName(columnsList);

    return SingleChildScrollView(
      child: Column(
        children: groupedColumns.entries.map((entry) {
          String sheetName = entry.key;
          List<ColumnDetails> columns = entry.value;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "\n $sheetName",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Wrap(
                spacing: 0,
                runSpacing: 0,
                children: List.generate(columns.length, (index) {
                  ColumnDetails column = columns[index];
                  int globalIndex = columnsList.indexOf(column);
                  return Row(
                    children: [
                      Checkbox(
                        value: column.isUserCheckedIn,
                        onChanged: column.isMandatory
                            ? null
                            : (value) {
                                ColumnDetails updatedColumn =
                                    column.copyWith(isUserCheckedIn: value);
                                List<ColumnDetails> updatedList =
                                    columnsList.toList();
                                updatedList[globalIndex] = updatedColumn;
                                context.read<ProjectArchitectBloc>().add(
                                    ReplaceColumnsEvent(
                                        columns: updatedList,
                                        index: globalIndex));
                              },
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              column.columnName,
                              overflow: TextOverflow.visible,
                            ),
                            SizedBox(
                              height: 30,
                              width: 300,
                              child: TextFormField(
                                controller: customerColumnNames[globalIndex],
                                enabled: column.isUserCheckedIn,
                                cursorHeight: 15,
                                onChanged: (value) {
                                  // Update the text of the controller
                                  // customerColumnNames[globalIndex].text = value;

                                  // Get the current cursor position
                                  // int cursorPosition = value.length;

                                  // Update the selection of the controller
                                  // customerColumnNames[globalIndex].selection =
                                  //     TextSelection.collapsed(
                                  //         offset: cursorPosition);

                                  // Dispatch an event to update the state with the modified list of controllers
                                  customerColumnNames.replaceRange(
                                      globalIndex,
                                      globalIndex + 1,
                                      [TextEditingController(text: value)]);
                                  for (var i in customerColumnNames) {
                                    print(i);
                                  }

                                  // context.read<ProjectArchitectBloc>().add(
                                  //       CustomerColumnNamesEvent(
                                  //           customerColumnNames:
                                  //               customerColumnNames),
                                  //     );
                                },
                                onEditingComplete: () {
                                  for (var i in customerColumnNames) {
                                    print(i);
                                  }
                                },
                                decoration: InputDecoration(
                                    hintText: "$globalIndex ${column.id}",
                                    contentPadding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    border: const OutlineInputBorder()),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  // Function to group ColumnDetails by sheetName
  Map<String, List<ColumnDetails>> groupBySheetName(
      List<ColumnDetails> columns) {
    Map<String, List<ColumnDetails>> groupedColumns = {};
    for (var column in columns) {
      if (!groupedColumns.containsKey(column.sheetName)) {
        groupedColumns[column.sheetName] = [];
      }
      groupedColumns[column.sheetName]?.add(column);
    }
    return groupedColumns;
  }
}
