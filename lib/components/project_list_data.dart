// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clan_churn/churn_blocs/project_architect/project_architect_bloc.dart';
import 'package:clan_churn/components/input_fields.dart';
import 'package:clan_churn/components/project_card.dart';
import 'package:clan_churn/components/projects_view_component.dart';
import 'package:clan_churn/utils/spacing.dart';
import 'package:clan_churn/utils/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProjectsListData extends StatefulWidget {
  const ProjectsListData({
    Key? key,
  }) : super(key: key);

  @override
  State<ProjectsListData> createState() => _ProjectsListDataState();
}

class _ProjectsListDataState extends State<ProjectsListData> {
  bool sort = true;

  @override
  void initState() {
    super.initState();
  }

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return BlocBuilder<ProjectArchitectBloc, ProjectArchitectState>(
      builder: (context, state) {
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
                          // setState(() {
                          //   myData = filterData!
                          //       .where((element) =>
                          //           element.projectDoneBy.contains(value))
                          //       .toList();
                          // });
                        },
                      ),
                    ),
                  ],
                ),
                ClanChurnSpacing.h20,
                SingleChildScrollView(
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: (getCount(context: context, isExpanded: state.isExpanded)),
                        childAspectRatio: 1,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15),
                    itemCount: state.projectsList.length,
                    itemBuilder: (context, index) {
                      return ProjectCard(
                        index: index,
                      );
                    },
                  ),
                )
              ],
            ));
      },
    );
  }
}

int getCount({required BuildContext context, required bool isExpanded}) {
  double h = MediaQuery.of(context).size.height;
  if (h >= 900) {
    if (isExpanded) {
      return 7;
    } else {
      return 6;
    }
  } else if (h >= 700) {
     if (isExpanded) {
      return 6;
    } else {
      return 5;
    }
  } else {
     if (isExpanded) {
      return 5;
    } else {
      return 4;
    }
  }
}
