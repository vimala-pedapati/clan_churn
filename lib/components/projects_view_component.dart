import 'package:clan_churn/churn_blocs/user/user_bloc.dart';
import 'package:clan_churn/components/new_project_components.dart';
import 'package:clan_churn/components/project_history_data_table.dart';
import 'package:clan_churn/components/search.dart';
import 'package:clan_churn/utils/routes.dart';
import 'package:clan_churn/utils/spacing.dart';
import 'package:clan_churn/utils/typography.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProjectsViewComponent extends StatefulWidget {
  final double width;
  const ProjectsViewComponent({super.key, required this.width});

  @override
  State<ProjectsViewComponent> createState() => _ProjectsViewComponentState();
}

class _ProjectsViewComponentState extends State<ProjectsViewComponent> {
  @override
  void initState() {
    if (context.read<UserBloc>().state.selectedClient != null) {
      context.read<UserBloc>().add(GetProjectsListEvent(
          clientId: context.read<UserBloc>().state.selectedClient!.id));
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return AnimatedContainer(
      duration: const Duration(seconds: 1),
      width: widget.width,
      height: h * 0.83,
      margin: EdgeInsets.only(
          left: w * 0.025, right: w * 0.025, top: 10, bottom: 20),
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          return state.selectedClient == null
              ? Container()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        ClanChurnSpacing.w20,
                        Text.rich(
                          TextSpan(
                            text: 'Home >  ',
                            style: ClanChurnTypography.font12500,
                            children: [
                              TextSpan(
                                text: state.selectedClient!.name,
                                style: ClanChurnTypography.font12600.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    ClanChurnSpacing.h10,
                    // Text("${state.projectsList}"),
                    Container(
                      height: h * 0.785,
                      width: w * 0.8,
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 20, bottom: 10),
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.background,
                          borderRadius: BorderRadius.circular(30)),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        Icons.keyboard_backspace,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                        // GoRouter.of(context).go(AppRoutes.home);
                                      },
                                    ),
                                    ClanChurnSpacing.w10,
                                    Text(
                                      state.selectedClient!.name,
                                      style: ClanChurnTypography.font18600,
                                    ),
                                  ],
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        customPageRouteForNavigation(
                                            const CreateNewProject()));
                                  },
                                  child: Row(children: [
                                    const Icon(
                                      Icons.add_box_outlined,
                                      size: 18,
                                    ),
                                    ClanChurnSpacing.w5,
                                    Text(
                                      "Start New Project",
                                      style: ClanChurnTypography.font14600,
                                    )
                                  ]),
                                )
                              ],
                            ),
                            ClanChurnSpacing.h20,
                            Text(
                              "Project History",
                              style: ClanChurnTypography.font15600,
                            ),
                            ClanChurnSpacing.h10,
                            const ProjectsList()
                          ]),
                    ),
                  ],
                );
        },
      ),
    );
  }
}

class GetFiltersDropDown extends StatefulWidget {
  const GetFiltersDropDown({super.key});

  @override
  State<GetFiltersDropDown> createState() => _GetFiltersDropDownState();
}

class _GetFiltersDropDownState extends State<GetFiltersDropDown> {
  String dropdownvalue = 'All Status';
  var items = ['All Status', 'Complete', 'In Progress'];
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
            height: 30,
            width: w * 0.15,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              border: Border.all(
                  color: Theme.of(context).colorScheme.primary,
                  style: BorderStyle.solid,
                  width: 0.80),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton2(
                hint: Text(
                  'Select Item',
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).hintColor,
                  ),
                ),
                // customButton:Container(
                //   color: Colors.amber,
                //   width: 10,
                //   height: 10,
                //   child: Icon(Icons.keyboard_arrow_down_outlined)),
                items: items
                    .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ))
                    .toList(),
                value: dropdownvalue,
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownvalue = newValue!;
                  });
                },

                iconStyleData: IconStyleData(
                  icon: Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Icon(
                      Icons.keyboard_arrow_down_outlined,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  iconSize: 18,
                ),
              ),
            )),
      ],
    );
  }
}

class GetSearchWidget extends StatefulWidget {
  const GetSearchWidget({super.key});

  @override
  State<GetSearchWidget> createState() => _GetSearchWidgetState();
}

class _GetSearchWidgetState extends State<GetSearchWidget> {
  TextEditingController controller = TextEditingController();
  List list = [
    "Flutter",
    "Angular",
    "Node js",
    "Flutter",
    "Angular",
    "Node js",
    "Flutter",
    "Angular",
    "Node js",
    "Flutter",
    "Angular",
    "Node js",
    "Flutter",
    "Angular",
    "Node js",
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.2,
      child: GFSearchBar(
          searchList: list,
          padding: EdgeInsets.zero,
          margin: EdgeInsets.zero,
          controller: controller,
          searchQueryBuilder: (query, list) => list.where((item) {
                return item!
                    .toString()
                    .toLowerCase()
                    .contains(query.toLowerCase());
              }).toList(),
          overlaySearchListItemBuilder: (dynamic item) {
            // print('$item');
            return Container(
              padding: EdgeInsets.zero,
              child: Text(
                item,
                style: const TextStyle(fontSize: 18),
              ),
            );
          },
          onItemSelected: (dynamic item) {
            print('$item');
            setState(() {
              controller.text = item;
            });
          }),
    );
  }
}