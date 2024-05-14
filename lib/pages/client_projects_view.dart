import 'package:clan_churn/churn_blocs/user/user_bloc.dart';
import 'package:clan_churn/componnents/clients_view_component.dart';
import 'package:clan_churn/componnents/nav_bar.dart';
import 'package:clan_churn/componnents/side_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClientProjectsView extends StatelessWidget {
  const ClientProjectsView({super.key});

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SideBar(
                    selectedRoute: SelectedRoute.home,
                  ),
                  ClientsViewComponent(
                    width: state.isExpanded ? w * 0.89 : w * 0.8,
                  )
                ],
              ),
            ]);
          },
        ));
  }
}
