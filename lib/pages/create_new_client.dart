import 'package:clan_churn/churn_blocs/client/client_bloc.dart';
import 'package:clan_churn/components/churn_continer.dart';
import 'package:clan_churn/components/dialogs.dart';
import 'package:clan_churn/components/nav_bar.dart';
import 'package:clan_churn/components/side_bar.dart';
import 'package:clan_churn/components/wrap_profile.dart';
import 'package:clan_churn/pages/create_client.dart';
import 'package:clan_churn/utils/routes.dart';
import 'package:clan_churn/utils/typography.dart';
import 'package:file_picker/_internal/file_picker_web.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CreateNewClient extends StatelessWidget {
  const CreateNewClient({super.key});

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
                            "Create > Clients > ",
                            style: ClanChurnTypography.font16500,
                          ),
                          Text(
                            "Create New Client",
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

class NewClientForm extends StatefulWidget {
  const NewClientForm({super.key});

  @override
  State<NewClientForm> createState() => _NewClientFormState();
}

class _NewClientFormState extends State<NewClientForm> {
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
    if (context.read<ClientBloc>().state.clientUploadLogoResponse == null) {
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
              "Create New Client",
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
                    foregroundImage: state.clientUploadLogoResponse == null
                        ? null
                        : NetworkImage(
                            state.clientUploadLogoResponse!.imageUrl,
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
                            onChanged: (p0) {
                              print("${clientName.text}");
                            },
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
                          GoRouter.of(context).go(AppRoutes.createClient);
                          context.read<ClientBloc>().add(CreateClientEvent(
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
                                  print(
                                      "unable to create client: $errorMessage");
                                },
                                onSuccessCallback: (message) {
                                  Navigator.pushReplacement(
                                      context,
                                      customPageRouteForNavigation(
                                          const CreateClient()));
                                  // GoRouter.of(context).goNamed(AppRoutes.createClient);
                                  // GoRouter.of(context)
                                  //     .go(AppRoutes.createClient);
                                },
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
                          "Create Client",
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

class CusText extends StatelessWidget {
  const CusText({
    super.key,
    required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: ClanChurnTypography.font18500,
    );
  }
}

OutlineInputBorder border(BuildContext context) => OutlineInputBorder(
    borderSide: BorderSide(
        width: 1.5,
        color: Theme.of(context).colorScheme.primary.withOpacity(0.6)));

class CusTextEditingController extends StatelessWidget {
  const CusTextEditingController(
      {super.key,
      this.width,
      required this.hintText,
      required this.controller,
      required this.onChanged,
      required this.textInputAction});
  final double? width;
  final String hintText;
  final TextEditingController controller;
  final Function(String) onChanged;
  final TextInputAction textInputAction;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 40,
        width: width ?? 400,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
            borderRadius: BorderRadius.circular(08)),
        margin: const EdgeInsets.only(right: 20, top: 10, bottom: 10),
        child: TextFormField(
          controller: controller, // Use the passed controller here
          textInputAction: textInputAction,
          onChanged: onChanged,
          decoration: InputDecoration(
              hintText: hintText,
              hintStyle: ClanChurnTypography.font18500.copyWith(
                  color: Theme.of(context)
                      .colorScheme
                      .onSecondary
                      .withOpacity(0.8)),
              contentPadding: const EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              enabledBorder: border(context),
              focusedBorder: border(context),
              border: border(context)),
        ));
  }
}
