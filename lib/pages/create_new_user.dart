import 'package:clan_churn/churn_blocs/client/client_bloc.dart';
import 'package:clan_churn/churn_blocs/user/user_bloc.dart';
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

class CreateNewUser extends StatelessWidget {
  const CreateNewUser({super.key});

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

class NewClientForm extends StatefulWidget {
  const NewClientForm({super.key});

  @override
  State<NewClientForm> createState() => _NewClientFormState();
}

class _NewClientFormState extends State<NewClientForm> {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController mailId = TextEditingController();
  bool isImageUploading = false;
  bool imageUploadFailed = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? validateFields() {
    if (firstName.text.isEmpty) {
      return 'First name cannot be empty';
    }
    if (lastName.text.isEmpty) {
      return 'Last name cannot be empty';
    }

    if (password.text.isEmpty) {
      return 'Passwrd cannot be empty';
    }
    // if (!RegExp(r'^\d{10}$').hasMatch(phoneNumber.text)) {
    //   return 'Contact number must be 10 digits';
    // }
    if (password.text.length >= 6) {
      return 'Password is too weak';
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(mailId.text)) {
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
    firstName.addListener(_validateForm);
    lastName.addListener(_validateForm);
    password.addListener(_validateForm);
    mailId.addListener(_validateForm);

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
              "Create New User",
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
                      context.read<UserBloc>().add(UploadUserProfileEvent(
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
                            text: 'First Name',
                          ),
                          CusTextEditingController(
                            hintText: "Enter First Name",
                            controller: firstName,
                            onChanged: (p0) {},
                            textInputAction: TextInputAction.next,
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CusText(
                            text: 'Last Name',
                          ),
                          CusTextEditingController(
                            hintText: "Enter Last Name",
                            controller: lastName,
                            onChanged: (p0) {},
                            textInputAction: TextInputAction.next,
                          )
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CusText(
                            text: 'Type of user',
                          ),
                          CusTextEditingController(
                            hintText: "Enter First Name",
                            controller: firstName,
                            onChanged: (p0) {},
                            textInputAction: TextInputAction.next,
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CusText(
                            text: 'Assign Client',
                          ),
                          CusTextEditingController(
                            hintText: "Enter Last Name",
                            controller: lastName,
                            onChanged: (p0) {},
                            textInputAction: TextInputAction.next,
                          )
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CusText(
                            text: 'Mail ID',
                          ),
                          CusTextEditingController(
                            hintText: "Enter Mail Id",
                            controller: mailId,
                            onChanged: (p0) {},
                            textInputAction: TextInputAction.next,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CusText(
                            text: 'Password',
                          ),
                          CusTextEditingController(
                            hintText: "Enter your password",
                            controller: password,
                            onChanged: (p0) {},
                            textInputAction: TextInputAction.next,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 80,
                  ),
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
                          // GoRouter.of(context).go(AppRoutes.createClient);
                          context.read<UserBloc>().add(AddUserEvent(
                                clientId: '',
                                firstName: firstName.text,
                                lastName: lastName.text,
                                email: mailId.text,
                                password: password.text,
                                userType: '',
                                onErrorCallback: (errorMessage, errorCode) {
                                  print("unable to create user: $errorMessage");
                                },
                                onSuccessCallback: (message) {
                                  Navigator.pushReplacement(
                                      context,
                                      customPageRouteForNavigation(
                                          const CreateClient()));
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
                          "Create User",
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
