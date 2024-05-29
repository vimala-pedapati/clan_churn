import 'package:clan_churn/churn_blocs/project_architect/project_architect_bloc.dart'; 
import 'package:clan_churn/components/projects_view_component.dart';
import 'package:clan_churn/components/nav_bar.dart';
import 'package:clan_churn/components/side_bar.dart';
import 'package:clan_churn/components/wrap_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClientProjectsView extends StatefulWidget {
  const ClientProjectsView({super.key});

  @override
  State<ClientProjectsView> createState() => _ClientProjectsViewState();
}

class _ClientProjectsViewState extends State<ClientProjectsView> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor:
            Theme.of(context).colorScheme.primary.withOpacity(0.05),
        body: BlocBuilder<ProjectArchitectBloc, ProjectArchitectState>(
          builder: (context, state) {
            return WrapProfile(
              child: Column(children: [
                // Nav bar
                const NavBar(),
                SizedBox(height: h * 0.01),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SideBar(
                      selectedRoute: SelectedRoute.home,
                    ),
                    ProjectsViewComponent(
                      width: state.isExpanded ? w * 0.89 : w * 0.8,
                    )
                  ],
                ),
              ]),
            );
          },
        ));
  }
}
