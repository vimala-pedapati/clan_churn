import 'dart:developer';

import 'package:clan_churn/api_repos/models/column_model.dart';
import 'package:clan_churn/churn_blocs/user/user_bloc.dart';
import 'package:clan_churn/components/nav_bar.dart';
import 'package:clan_churn/components/projects_view_component.dart';
import 'package:clan_churn/components/side_bar.dart';
import 'package:clan_churn/utils/spacing.dart';
import 'package:clan_churn/utils/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateNewProject extends StatelessWidget {
  const CreateNewProject({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor:
            Theme.of(context).colorScheme.primary.withOpacity(0.05),
        body: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            return Column(children: [
              // Nav bar
              const NavBar(),
              SizedBox(height: h * 0.01),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SideBar(
                    selectedRoute: SelectedRoute.home,
                  ),
                  AddNewProjectComponent()
                ],
              ),
            ]);
          },
        ));
  }
}

class AddNewProjectComponent extends StatefulWidget {
  const AddNewProjectComponent({super.key});

  @override
  State<AddNewProjectComponent> createState() => _AddNewProjectComponentState();
}

class _AddNewProjectComponentState extends State<AddNewProjectComponent> {
  TextEditingController clientController = TextEditingController();
  TextEditingController projectController = TextEditingController();
  String projectName = "";

  @override
  void initState() {
    setState(() {
      clientController.text =
          context.read<UserBloc>().state.selectedClient!.name;
    });
    context.read<UserBloc>().add(GetColumnsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return AnimatedContainer(
          width: state.isExpanded ? w * 0.89 : w * 0.8,
          height: h * 0.83,
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.circular(30)),
          margin: EdgeInsets.only(
              left: w * 0.025, right: w * 0.025, top: 10, bottom: 20),
          duration: const Duration(seconds: 1),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
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
                    ClanChurnSpacing.w10,
                    Text(
                      "Start New Project",
                      style: ClanChurnTypography.font18600,
                    ),
                  ],
                ),
                ClanChurnSpacing.h30,
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Customer Name",
                                      style: ClanChurnTypography.font15900,
                                    ),
                                    Text(
                                      "*",
                                      style: ClanChurnTypography.font10600
                                          .copyWith(color: Colors.red),
                                    )
                                  ],
                                ),
                                Container(
                                  width: w * 0.25,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary
                                          .withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(8.0)),
                                  margin:
                                      const EdgeInsets.only(top: 5, bottom: 20),
                                  child: TextFormField(
                                    controller: clientController,
                                    keyboardType: TextInputType.emailAddress,
                                    autofocus: false,
                                    cursorHeight: 15,
                                    readOnly: true,
                                    decoration: InputDecoration(
                                      hintText: 'Enter Client ID',
                                      hintStyle: ClanChurnTypography.font12500
                                          .copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .tertiary),
                                      contentPadding: const EdgeInsets.only(
                                          top: 10, left: 10, right: 10),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0)),
                                    ),
                                    onChanged: (value) {},
                                    validator: (String? val) {},
                                    onSaved: (String? val) {},
                                  ),
                                ),
                              ],
                            ),
                            ClanChurnSpacing.w20,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Project Name",
                                  style: ClanChurnTypography.font15900,
                                ),
                                Container(
                                  width: w * 0.25,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary
                                          .withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(8.0)),
                                  margin:
                                      const EdgeInsets.only(top: 5, bottom: 20),
                                  child: TextFormField(
                                    controller: projectController,
                                    keyboardType: TextInputType.emailAddress,
                                    autofocus: false,
                                    cursorHeight: 15,
                                    readOnly: false,
                                    decoration: InputDecoration(
                                      hintText: 'Enter Project Name',
                                      hintStyle: ClanChurnTypography.font15400
                                          .copyWith(
                                              color:
                                                  Colors.grey.withOpacity(0.7)),
                                      contentPadding: const EdgeInsets.only(
                                          top: 10, left: 10, right: 10),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0)),
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        projectName = value;
                                      });
                                    },
                                    validator: (String? val) {},
                                    onSaved: (String? val) {},
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: (projectName.isEmpty ||
                                  state.columnsList.isEmpty)
                              ? null
                              : () {
                                  context.read<UserBloc>().add(
                                      CreateProjectEvent(
                                          clientId: state.selectedClient!.id,
                                          projectName: projectController.text));
                                },
                          child: Text("Create Project"),
                        )
                      ],
                    ),
                    // Text("${state.columnsList}")
                  ],
                ),
                Text(
                  "Columns to choose",
                  style: ClanChurnTypography.font18600,
                ),
                // ClanChurnSpacing.h10,
                Expanded(
                  child: AbsorbPointer(
                    absorbing: projectName.isEmpty,
                    child: Opacity(
                      opacity: projectName.isEmpty ? 0.4 : 1.0,
                      child: SingleChildScrollView(
                        child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 5,
                          ),
                          itemCount: state.columnsList.length,
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                Checkbox(
                                  value:
                                      state.columnsList[index].isUserCheckedIn,
                                  onChanged: state
                                          .columnsList[index].isMandatory
                                      ? null
                                      : (value) {
                                          ColumnDetails a = state
                                              .columnsList[index]
                                              .copyWith(isUserCheckedIn: value);
                                          List<ColumnDetails> b =
                                              state.columnsList.toList();
                                          b[index] = a;
                                          log("$a");
                                          log("/");
                                          log("${b[index]}");

                                          context.read<UserBloc>().add(
                                              ReplaceColumnsEvent(
                                                  columns: b, index: index));
                                        },
                                ),
                                Expanded(
                                  // Use Expanded to allow the Text widget to take remaining space
                                  child: Column(
                                    // Wrap the Text widget in a Column
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start, // Align text to the start of the column
                                    children: [
                                      Text(
                                        state.columnsList[index].columnName,
                                        overflow: TextOverflow.visible,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      child: const Text("Next"),
                      onPressed: projectName.isEmpty
                          ? null
                          : () {
                              context
                                  .read<UserBloc>()
                                  .add(AddColumnsToProjectEvent());
                            },
                    ),
                  ],
                )
              ]),
        );
      },
    );
  }
}
