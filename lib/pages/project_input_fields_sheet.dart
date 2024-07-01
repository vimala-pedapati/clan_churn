import 'package:clan_churn/churn_blocs/project_architect/project_architect_bloc.dart';
import 'package:clan_churn/churn_blocs/user/user_bloc.dart';
import 'package:clan_churn/components/input_fields.dart';
import 'package:clan_churn/components/nav_bar.dart';
import 'package:clan_churn/components/side_bar.dart';
import 'package:clan_churn/components/wrap_profile.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProjectInputFieldsPage extends StatelessWidget {
  const ProjectInputFieldsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    // final w = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor:
            Theme.of(context).colorScheme.primary.withOpacity(0.05),
        body: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            return WrapProfile(
              child: Column(children: [
                // Nav bar
                const NavBar(),
                SizedBox(height: h * 0.01),
                const Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SideBar(
                      selectedRoute: SelectedRoute.home,
                    ),
                    GetInputFieldsComponent()
                  ],
                ),
              ]),
            );
          },
        ));
  }
}

class GetInputFieldsComponent extends StatelessWidget {
  const GetInputFieldsComponent({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return BlocBuilder<ProjectArchitectBloc, ProjectArchitectState>(
      builder: (context, state) {
        return AnimatedContainer(
          width: state.isNotExpanded ? w * 0.89 : w * 0.8,
          height: h * 0.83,
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.circular(30)),
          margin: EdgeInsets.only(left: w * 0.01, top: 10, bottom: 20),
          duration: const Duration(seconds: 1),
          child: const Column(children: [
            // Row(
            //   children: [
            //     IconButton(
            //       icon: Icon(
            //         Icons.keyboard_backspace,
            //         color: Theme.of(context).colorScheme.secondary,
            //       ),
            //       onPressed: () {
            //         Navigator.pop(context);
            //         // GoRouter.of(context).go(AppRoutes.home);
            //       },
            //     ),
            //     ClanChurnSpacing.w10,
            //     Text(
            //       "Project Initialization",
            //       style: ClanChurnTypography.font18600,
            //     ),
            //   ],
            // ),
            // Row(
            //   children: [
            //     Text(
            //       "Select Initialization",
            //       style: ClanChurnTypography.font14500,
            //     ),
            //     ClanChurnSpacing.w15,
            //     // DropDown
            //     const GetInitializationDropDown(),
            //   ],
            // ),
            // ClanChurnSpacing.h10,

            GetInputFields()
            // Container(height: 200, child: const ProjectInitialization())
          ]),
        );
      },
    );
  }
}

class GetInitializationDropDown extends StatefulWidget {
  const GetInitializationDropDown({super.key});

  @override
  State<GetInitializationDropDown> createState() =>
      _GetInitializationDropDownState();
}

class _GetInitializationDropDownState extends State<GetInitializationDropDown> {
  String dropdownvalue = 'Data cleaning initialization & reports';
  var items = [
    'Data cleaning initialization & reports',
    'People Data Mart Fields',
  ];
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
            height: 30,
            width: w * 0.27,
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
