import 'package:clan_churn/churn_blocs/user/user_bloc.dart';
import 'package:clan_churn/components/clients_component.dart';
import 'package:clan_churn/components/nav_bar.dart';
import 'package:clan_churn/components/profile.dart';
import 'package:clan_churn/components/side_bar.dart';
import 'package:clan_churn/components/wrap_profile.dart';
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
    context.read<UserBloc>().add(GetClientsEvent());
    context.read<UserBloc>().add(const SideBarExpandedEvent(isExpanded: false));
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
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: WrapProfile(
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
                    ClientsComponent(
                      width: state.isExpanded ? w * 0.89 : w * 0.8,
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
