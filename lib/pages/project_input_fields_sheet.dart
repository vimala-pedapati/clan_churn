import 'package:clan_churn/churn_blocs/project_architect/project_architect_bloc.dart';
import 'package:clan_churn/churn_blocs/user/user_bloc.dart';
import 'package:clan_churn/components/churn_continer.dart';
import 'package:clan_churn/components/input_fields.dart';
import 'package:clan_churn/components/input_sheet_columns.dart';
import 'package:clan_churn/components/nav_bar.dart';
import 'package:clan_churn/components/side_bar.dart';
import 'package:clan_churn/components/wrap_profile.dart';
import 'package:clan_churn/pages/new_project_components.dart';
import 'package:clan_churn/utils/spacing.dart';
import 'package:clan_churn/utils/typography.dart';
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
            return const WrapProfile(
              child: Column(children: [
                // Nav bar
                NavBar(),
                SizedBox(height: 10),
                Expanded(
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SideBar(
                        selectedRoute: SelectedRoute.home,
                      ),
                      Expanded(child: GetInputFieldsComponent())
                    ],
                  ),
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
        return const ChurnContainer(
          child: Column(
            children: [
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
              //     Expanded(
              //       child: Container(),
              //     ),
              //     ElevatedButton(
              //       child: const Text(
              //         "download input sheet",
              //       ),
              //       onPressed: () {
              //         launchURL(state.createdProject!.inputSheet ?? "");
              //       },
              //     )
              //   ],
              // ),
              
                Expanded(child: GetInputFields()),
            ],
          ),
        );
      },
    );
  }
}

// class GetInitializationDropDown extends StatefulWidget {
//   const GetInitializationDropDown({super.key});

//   @override
//   State<GetInitializationDropDown> createState() =>
//       _GetInitializationDropDownState();
// }

// class _GetInitializationDropDownState extends State<GetInitializationDropDown> {
//   String dropdownvalue = 'Data cleaning initialization & reports';
//   var items = [
//     'Data cleaning initialization & reports',
//     'People Data Mart Fields',
//   ];
//   @override
//   Widget build(BuildContext context) {
//     final w = MediaQuery.of(context).size.width;
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: [
//         Container(
//             height: 30,
//             width: w * 0.27,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(5.0),
//               color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
//               border: Border.all(
//                   color: Theme.of(context).colorScheme.primary,
//                   style: BorderStyle.solid,
//                   width: 0.80),
//             ),
//             child: DropdownButtonHideUnderline(
//               child: DropdownButton2(
//                 hint: Text(
//                   'Select Item',
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: Theme.of(context).hintColor,
//                   ),
//                 ),
//                 // customButton:Container(
//                 //   color: Colors.amber,
//                 //   width: 10,
//                 //   height: 10,
//                 //   child: Icon(Icons.keyboard_arrow_down_outlined)),
//                 items: items
//                     .map((item) => DropdownMenuItem<String>(
//                           value: item,
//                           child: Text(
//                             item,
//                             style: const TextStyle(
//                               fontSize: 14,
//                             ),
//                           ),
//                         ))
//                     .toList(),
//                 value: dropdownvalue,
//                 onChanged: (String? newValue) {
//                   setState(() {
//                     dropdownvalue = newValue!;
//                   });
//                 },

//                 iconStyleData: IconStyleData(
//                   icon: Padding(
//                     padding: const EdgeInsets.only(right: 10.0),
//                     child: Icon(
//                       Icons.keyboard_arrow_down_outlined,
//                       color: Theme.of(context).colorScheme.secondary,
//                     ),
//                   ),
//                   iconSize: 18,
//                 ),
//               ),
//             )),
//       ],
//     );
//   }
// }
