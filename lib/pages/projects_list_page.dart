import 'package:clan_churn/churn_blocs/user/user_bloc.dart';
import 'package:clan_churn/componnents/clients_component.dart';
import 'package:clan_churn/componnents/nav_bar.dart';
import 'package:clan_churn/componnents/profile.dart';
import 'package:clan_churn/componnents/project_history_data_table.dart';
import 'package:clan_churn/componnents/side_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProjectsList extends StatelessWidget {
  const ProjectsList({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(body: BlocBuilder<UserBloc, UserState>(
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
              ProjectHistory()
              // ClientsComponent(
              //   width: state.isExpanded ? w * 0.89 : w * 0.8,
              // )

             
            ],
          )
        ]);
      },
    ));
  }
}
