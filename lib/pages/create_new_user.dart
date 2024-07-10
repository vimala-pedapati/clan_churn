import 'package:clan_churn/churn_blocs/user/user_bloc.dart';
import 'package:clan_churn/components/churn_continer.dart';
import 'package:clan_churn/components/nav_bar.dart';
import 'package:clan_churn/components/side_bar.dart';
import 'package:clan_churn/components/wrap_profile.dart';
import 'package:clan_churn/pages/create_new_client.dart';
import 'package:clan_churn/utils/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateNewUser extends StatefulWidget {
  const CreateNewUser({super.key});

  @override
  State<CreateNewUser> createState() => _CreateNewUserState();
}

class _CreateNewUserState extends State<CreateNewUser> {
  @override
  void initState() {
    context.read<UserBloc>().add(GetUserTypesEvent(
          onErrorCallback: (errorMessage, errorCode) {
            print(
                'on error call back for getting user types: $errorMessage, $errorCode');
          },
          onSuccessCallback: (message) {
            print(
                'on success call back for get user data types ${message?.body}');
          },
        ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.05),
      body: WrapProfile(
          child: Column(
        children: [
          const NavBar(),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: Row(children: [
              const SideBar(
                selectedRoute: SelectedRoute.createClient,
              ),
              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 50),
                      child: Row(
                        children: [
                          Text(
                            "Create > Users > ",
                            style: ClanChurnTypography.font16500,
                          ),
                          Text(
                            "Create New User",
                            style: ClanChurnTypography.font16500.copyWith(
                                color: Theme.of(context).colorScheme.primary),
                          ),
                        ],
                      ),
                    ),
                    const Expanded(
                        child: ChurnContainer(child: NewClientForm())),
                  ],
                ),
              )
            ]),
          )
        ],
      )),
    );
  }
}

