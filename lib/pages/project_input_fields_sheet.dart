import 'package:clan_churn/churn_blocs/project_architect/project_architect_bloc.dart';
import 'package:clan_churn/churn_blocs/user/user_bloc.dart';
import 'package:clan_churn/components/churn_continer.dart';
import 'package:clan_churn/components/input_fields.dart';
import 'package:clan_churn/components/nav_bar.dart';
import 'package:clan_churn/components/side_bar.dart';
import 'package:clan_churn/components/wrap_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProjectInputFieldsPage extends StatefulWidget {
  const ProjectInputFieldsPage({super.key, required this.projectId});
  final String projectId;

  @override
  State<ProjectInputFieldsPage> createState() => _ProjectInputFieldsPageState();
}

class _ProjectInputFieldsPageState extends State<ProjectInputFieldsPage> {
  @override
  void initState() {
    context.read<ProjectArchitectBloc>().add(GetProjectDetailsEvent(projectId: widget.projectId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    // final w = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.05),
        body: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            return const WrapProfile(
              child: Column(children: [
                NavBar(),
                SizedBox(height: 10),
                Expanded(
                  child: Row(
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
        return ChurnContainer(
          child: Column(
            children: [
              if (!state.projectDetailsLoading) const Expanded(child: GetInputFields()),
            ],
          ),
        );
      },
    );
  }
}

 
