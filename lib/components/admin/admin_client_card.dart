import 'package:clan_churn/api_repos/models/client_details.dart';
import 'package:clan_churn/churn_blocs/client/client_bloc.dart';
import 'package:clan_churn/churn_blocs/project_architect/project_architect_bloc.dart';
import 'package:clan_churn/components/dialogs.dart';
import 'package:clan_churn/components/project_card.dart';
import 'package:clan_churn/pages/admin_home_page.dart';
import 'package:clan_churn/pages/create_new_client.dart';
import 'package:clan_churn/utils/routes.dart';
import 'package:clan_churn/utils/typography.dart';
import 'package:file_picker/_internal/file_picker_web.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminClientCard extends StatelessWidget {
  const AdminClientCard({super.key, required this.client});
  final ClientDetails client;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectArchitectBloc, ProjectArchitectState>(
      builder: (context, state) {
        return Container(
          height: 190,
          width: 160,
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              border: Border.all(color: Theme.of(context).colorScheme.primary),
              borderRadius: BorderRadius.circular(10)),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: state.isNotExpanded ? 40 : 35,
                  backgroundColor: Theme.of(context).colorScheme.background,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(
                      "${client.image}",
                      // loadingBuilder: ((context, child, loadingProgress) {
                      //   return const CircularProgressIndicator();
                      // }),
                      errorBuilder: (context, error, stackTrace) {
                        return ClipOval(
                            child: Image.network(
                          image,
                          scale: 2,
                        ));
                      },
                    ),
                  ),
                ),
                Column(
                  children: [
                    Text(
                      client.name,
                      style: ClanChurnTypography.font15600,
                    ),
                  ],
                ),
                SizedBox(
                  width: 160,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        shape: const StadiumBorder()),
                    child: Text(
                      "Edit",
                      style: ClanChurnTypography.font15600,
                    ),
                    onPressed: () {
                      updateClient(context, client);
                    },
                  ),
                )
              ]),
        );
      },
    );
  }
}

void updateClient(BuildContext context, ClientDetails updateClient) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.background,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(08),
      ),
      content: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
          Radius.circular(0.0),
        )),
        child: UpdateClientBody(
          updateClient: updateClient,
        ),
      ),
    ),
  );
}

class UpdateClientBody extends StatefulWidget {
  const UpdateClientBody({super.key, required this.updateClient});
  final ClientDetails updateClient;

  @override
  State<UpdateClientBody> createState() => _UpdateClientBodyState();
}

class _UpdateClientBodyState extends State<UpdateClientBody> {
  TextEditingController clientName = TextEditingController();
  TextEditingController roleName = TextEditingController();
  TextEditingController address1 = TextEditingController();
  TextEditingController address2 = TextEditingController();
  TextEditingController pocName = TextEditingController();
  TextEditingController pocContactNumber = TextEditingController();
  TextEditingController pocMailId = TextEditingController();
  bool isImageUploading = false;
  bool imageUploadFailed = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? validateFields() {
    if (clientName.text.isEmpty) {
      return 'Client name cannot be empty';
    }
    if (roleName.text.isEmpty) {
      return 'Role name cannot be empty';
    }
    if (address1.text.isEmpty) {
      return 'Address line 1 cannot be empty';
    }
    if (address2.text.isEmpty) {
      return 'Address line 2 cannot be empty';
    }
    if (pocName.text.isEmpty) {
      return 'Point of contact name cannot be empty';
    }
    if (pocContactNumber.text.isEmpty) {
      return 'Point of contact number cannot be empty';
    }
    if (!RegExp(r'^\d{10}$').hasMatch(pocContactNumber.text)) {
      return 'Point of contact number must be 10 digits';
    }
    if (pocMailId.text.isEmpty) {
      return 'Point of contact email cannot be empty';
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(pocMailId.text)) {
      return 'Point of contact email is not in valid format';
    }
    if (context.read<ClientBloc>().state.clientUploadLogoResponse == null && widget.updateClient.image == null) {
      return 'Profile pic is required';
    }
    return null;
  }

  bool checkValidation() {
    String? validationResult = validateFields();
    if (validationResult != null) {
      print(validationResult);
      return false;
    }
    return true;
  }

  @override
  void initState() {
    setState(() {
      clientName.text = widget.updateClient.name;
      roleName.text = widget.updateClient.role ?? '';
      address1.text = widget.updateClient.address1 ?? '';
      address2.text = widget.updateClient.address2 ?? '';
      pocName.text = widget.updateClient.pocName ?? '';
      pocContactNumber.text = widget.updateClient.pocContactNumber ?? '';
      pocMailId.text = widget.updateClient.pocMailId ?? '';
    });

    clientName.addListener(_validateForm);
    roleName.addListener(_validateForm);
    address1.addListener(_validateForm);
    address2.addListener(_validateForm);
    pocName.addListener(_validateForm);
    pocContactNumber.addListener(_validateForm);
    pocMailId.addListener(_validateForm);

    super.initState();
  }

  void _validateForm() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.keyboard_backspace_outlined)),
            const SizedBox(
              width: 30,
            ),
            Text(
              "Update Client",
              style: ClanChurnTypography.font20600,
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          flex: 1,
          child: InkWell(
            onTap: () async {
              if (kIsWeb) {
                await FilePickerWeb.platform.pickFiles(
                  type: FileType.custom,
                  allowedExtensions: ['png', 'jpg', 'jpeg'],
                ).then(
                  (value) {
                    setState(() {
                      isImageUploading = true;
                    });
                    if (value != null) {
                      GetDialog.uploadFile(context);
                      context.read<ClientBloc>().add(UploadClientLogo(
                            filePickerResult: value,
                            onErrorCallback: (errorMessage, errorCode) {
                              setState(() {
                                isImageUploading = false;
                                imageUploadFailed = true;
                              });
                            },
                            onSuccessCallback: (message) {
                              setState(() {
                                isImageUploading = false;
                              });
                            },
                          ));
                      Navigator.pop(context);
                    }
                  },
                );
              }
            },
            child: BlocBuilder<ClientBloc, ClientState>(
              builder: (context, state) {
                return CircleAvatar(
                    radius: 50,
                    foregroundImage: NetworkImage(
                      state.clientUploadLogoResponse == null
                          ? widget.updateClient.image ?? ''
                          : state.clientUploadLogoResponse!.imageUrl,
                    ),
                    child: Icon(
                      Icons.add_photo_alternate_outlined,
                      size: 40,
                      color: Theme.of(context).colorScheme.background,
                    ));
              },
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          flex: 3,
          child: FittedBox(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CusText(
                            text: 'Client Name',
                          ),
                          CusTextEditingController(
                            hintText: "Enter Client Name",
                            controller: clientName,
                            onChanged: (p0) {},
                            textInputAction: TextInputAction.next,
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CusText(
                            text: 'Role Name',
                          ),
                          CusTextEditingController(
                            hintText: "Enter Role Name",
                            controller: roleName,
                            onChanged: (p0) {},
                            textInputAction: TextInputAction.next,
                          )
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CusText(
                        text: 'Client Office Address',
                      ),
                      CusTextEditingController(
                        hintText: "Address Line 1",
                        controller: address1,
                        onChanged: (p0) {},
                        textInputAction: TextInputAction.next,
                      ),
                      CusTextEditingController(
                        hintText: "Address Line 2",
                        controller: address2,
                        onChanged: (p0) {},
                        textInputAction: TextInputAction.next,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CusText(
                            text: 'POC Name',
                          ),
                          CusTextEditingController(
                            hintText: "Enter POC Name",
                            controller: pocName,
                            onChanged: (p0) {},
                            textInputAction: TextInputAction.next,
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CusText(
                            text: 'POC Contact Number',
                          ),
                          CusTextEditingController(
                            hintText: "Enter POC Contact",
                            controller: pocContactNumber,
                            onChanged: (p0) {},
                            textInputAction: TextInputAction.next,
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CusText(
                            text: 'POC Mail ID',
                          ),
                          CusTextEditingController(
                            hintText: "Enter POC Mail ID",
                            controller: pocMailId,
                            onChanged: (p0) {},
                            textInputAction: TextInputAction.next,
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: checkValidation()
                      ? () {
                          context.read<ClientBloc>().add(UpdateClientEvent(
                                clinetName: clientName.text,
                                roleName: roleName.text,
                                address1: address1.text,
                                address2: address2.text,
                                pocName: pocName.text,
                                pocContactNumber: pocContactNumber.text,
                                pocMailId: pocMailId.text,
                                image: context
                                        .read<ClientBloc>()
                                        .state
                                        .clientUploadLogoResponse
                                        ?.filename ?? 
                                    '',
                                onErrorCallback: (errorMessage, errorCode) {
                                  print( "unable to update the client: $errorMessage");
                                },
                                onSuccessCallback: (message) {
                                  Navigator.pushReplacement(
                                      context,
                                      customPageRouteForNavigation(
                                          const AdminHomePage()));
                                },
                                clientId: widget.updateClient.id,
                              ));
                        }
                      : null,
                  child: Row(
                    children: [
                      const Icon(Icons.arrow_circle_right_outlined),
                      const SizedBox(
                        width: 10,
                      ),
                      FittedBox(
                        child: Text(
                          "Update Client",
                          style: ClanChurnTypography.font15600,
                        ),
                      ),
                    ],
                  ),
                )
              ]),
        )
      ],
    );
  }
}
