import 'package:clan_churn/components/nav_bar.dart';
import 'package:clan_churn/components/side_bar.dart';
import 'package:clan_churn/components/wrap_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../churn_blocs/project_architect/project_architect_bloc.dart';
import '../components/pro_threshold_component.dart';

class GetProjectThresholdsPage extends StatefulWidget {
  const GetProjectThresholdsPage({super.key, required this.clientId, required this.projectId});
  final String clientId;
  final String projectId;

  @override
  State<GetProjectThresholdsPage> createState() => _GetProjectThresholdsPageState();
}

class _GetProjectThresholdsPageState extends State<GetProjectThresholdsPage> {
  @override
  void initState() {
    // context.read<ProjectArchitectBloc>().add(GetClientDetailsEvent(clientId: widget.clientId, onErrorCallback: (a, b) {}, onSuccessCallback: (response) {}));
    context.read<ProjectArchitectBloc>().add(GetProjectDetailsEvent(projectId: widget.projectId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.05),
      body: BlocBuilder<ProjectArchitectBloc, ProjectArchitectState>(
        builder: (context, state) {
          return WrapProfile(
              child: Column(
            children: [
              // Nav bar
              const NavBar(),

              const SizedBox(height: 10),
              if (!state.loadingClientDetails && !state.projectDetailsLoading)
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SideBar(
                        selectedRoute: SelectedRoute.home,
                      ),
                      if (!state.loadingClientDetails && state.selectedClient != null)
                        Expanded(
                            child: ProjectThresholdComponent(
                          clientId: widget.clientId,
                          projectId: widget.projectId,
                        ))
                    ],
                  ),
                ),
            ],
          ));
        },
      ),
    );
  }
}