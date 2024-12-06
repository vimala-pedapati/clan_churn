import 'dart:convert';

import 'package:clan_churn/churn_blocs/client/client_bloc.dart';
import 'package:clan_churn/churn_blocs/project_architect/project_architect_bloc.dart';
import 'package:clan_churn/components/admin/admin_client_card.dart';
import 'package:clan_churn/components/admin/admin_user_section.dart';
import 'package:clan_churn/pages/create_new_client.dart';
import 'package:clan_churn/utils/routes.dart';
import 'package:clan_churn/utils/typography.dart';
import 'package:file_picker/_internal/file_picker_web.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../api_repos/api_repo.dart';

class CreateClientBody extends StatefulWidget {
  const CreateClientBody({super.key});

  @override
  State<CreateClientBody> createState() => _CreateClientBodyState();
}

class _CreateClientBodyState extends State<CreateClientBody> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  void _goToNextPage() {
    if (_currentPage < 2) {
      _currentPage++;
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goToPreviousPage() {
    if (_currentPage > 0) {
      _currentPage--;
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Create",
            style: ClanChurnTypography.font24600,
          ),
          ElevatedButton(
            onPressed: () async {
              if (kIsWeb) {
                FilePickerResult? picked = await FilePickerWeb.platform.pickFiles(
                  type: FileType.custom,
                  allowedExtensions: ['xls', 'xlsx'],
                );

                if (picked != null) {
                  // ignore: use_build_context_synchronously
                  context.read<ClientBloc>().add(
                        // ignore: use_build_context_synchronously
                        UploadErrorGlossary(
                          filePickerResult: picked,
                          onErrorCallback: (message, errorCode) {
                            ApiRepository().handleWarningMessage(
                              "$message unable to upload file, something went wrong ",
                              context,
                            );
                          },
                          onSuccessCallBack: (message) {
                            ApiRepository().handleSuccessMessage("${json.decode(message!.body)["message"]}", context);
                          },
                        ),
                      );
                }
              }
            },
            child: const Text("Upload error glosarry"),
          )
        ],
      ),
      const SizedBox(
        height: 20,
      ),
      Container(
        child: Row(children: [
          InkWell(
            onTap: () {
              _goToPreviousPage();
            },
            child: Container(
                color: Theme.of(context).colorScheme.primary.withOpacity(_currentPage == 0 ? 1 : 0.5),
                padding: const EdgeInsets.all(8),
                child: Text(
                  "Clients",
                  style: ClanChurnTypography.font16600.copyWith(color: Theme.of(context).colorScheme.background),
                )),
          ),
          const SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () {
              _goToNextPage();
            },
            child: Container(
                color: Theme.of(context).colorScheme.primary.withOpacity(_currentPage == 1 ? 1 : 0.5),
                padding: const EdgeInsets.all(8),
                child: Text(
                  "Users",
                  style: ClanChurnTypography.font16600.copyWith(color: Theme.of(context).colorScheme.background),
                )),
          ),
        ]),
      ),
      Expanded(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(border: Border.all(color: Theme.of(context).colorScheme.primary)),
          child: PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            children: [
              SingleChildScrollView(
                child: BlocBuilder<ProjectArchitectBloc, ProjectArchitectState>(
                  builder: (context, state) {
                    return Wrap(
                      runSpacing: 15,
                      spacing: 15,
                      children: [
                        ...state.clientList.map((c) {
                          return AdminClientCard(
                            client: c,
                          );
                        }).toList(),
                        const CreateNewClientCard()
                      ],
                    );
                  },
                ),
              ),
              const UsersCard()
            ],
          ),
        ),
      )
    ]);
  }
}

class CreateNewClientCard extends StatelessWidget {
  const CreateNewClientCard({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, customPageRouteForNavigation(const CreateNewClient()));
      },
      child: Container(
        height: 230,
        width: 180,
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
        decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary.withOpacity(0.1), border: Border.all(color: Theme.of(context).colorScheme.primary), borderRadius: BorderRadius.circular(10)),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Icon(
            Icons.add_circle_outline_outlined,
            size: 70,
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            "Create New Client",
            style: ClanChurnTypography.font12600,
          )
        ]),
      ),
    );
  }
}
