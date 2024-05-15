import 'package:clan_churn/churn_blocs/user/user_bloc.dart';
import 'package:clan_churn/components/nav_bar.dart';
import 'package:clan_churn/components/projects_view_component.dart';
import 'package:clan_churn/components/side_bar.dart';
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
                  GetInputFieldsComponent()
                ],
              ),
            ]);
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
          child: Column(children: [
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
                  "Project Initialization",
                  style: ClanChurnTypography.font18600,
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "Select Initialization",
                  style: ClanChurnTypography.font14500,
                ),
                ClanChurnSpacing.w15,
                // DropDown
                const GetInitializationDropDown(),
              ],
            ),
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

class GetFields extends StatelessWidget {
  const GetFields({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(children: []),
    );
  }
}

class GetTextFormField extends StatelessWidget {
  const GetTextFormField({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Container(
      width: w * 0.25,
      height: 30,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8.0)),
      margin: const EdgeInsets.only(top: 5, bottom: 20),
      child: TextFormField(
        // controller: clientController,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        cursorHeight: 15,
        readOnly: true,
        decoration: InputDecoration(
          hintText: 'Enter Client ID',
          hintStyle: ClanChurnTypography.font12500
              .copyWith(color: Theme.of(context).colorScheme.tertiary),
          contentPadding: const EdgeInsets.only(top: 10, left: 10, right: 10),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        ),
        onChanged: (value) {},
        validator: (String? val) {},
        onSaved: (String? val) {},
      ),
    );
  }
}