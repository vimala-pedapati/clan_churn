import 'dart:collection';
import 'dart:convert';

import 'package:clan_churn/churn_blocs/project_architect/project_architect_bloc.dart';
import 'package:clan_churn/churn_blocs/user/user_bloc.dart';
import 'package:clan_churn/components/clients_component.dart';
import 'package:clan_churn/components/input_fields.dart';
import 'package:clan_churn/components/nav_bar.dart';
import 'package:clan_churn/components/side_bar.dart';
import 'package:clan_churn/components/upload_summary_report.dart';
import 'package:clan_churn/components/wrap_profile.dart';
import 'package:clan_churn/utils/spacing.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<UserBloc>().add(GetUserDetailsEvent());
    context.read<ProjectArchitectBloc>().add(GetClientsEvent());
    context .read<ProjectArchitectBloc>().add(const SideBarExpandedEvent(isExpanded: false));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      // appBar: const ClanChurnAppBar(),
      backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.05),
      // endDrawer:  const MyDrawer(),
      body: BlocBuilder<ProjectArchitectBloc, ProjectArchitectState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: WrapProfile(
              child: Column(children: [
                // Nav bar
                const NavBar(),
                SizedBox(height: h * 0.01),

                 const  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SideBar(
                      selectedRoute: SelectedRoute.home,
                    ),
                    Expanded(
                      child: ClientsComponent(),
                    )
                   
                  ],
                )
              ]),
            ),
          );
        },
      ),
    );
  }
}
