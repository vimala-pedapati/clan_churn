import 'package:clan_churn/api_repos/api_repo.dart';
import 'package:clan_churn/churn_blocs/client/client_bloc.dart';
import 'package:clan_churn/churn_blocs/user/user_bloc.dart';
import 'package:clan_churn/components/cus_text.dart';
import 'package:clan_churn/components/cus_text_editing_controller.dart';
import 'package:clan_churn/components/dialogs.dart';
import 'package:clan_churn/pages/create_client.dart';
import 'package:clan_churn/utils/api_endpoins.dart';
import 'package:clan_churn/utils/routes.dart';
import 'package:clan_churn/utils/typography.dart';
import 'package:clan_churn/utils/validations.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/_internal/file_picker_web.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewUserForm extends StatefulWidget {
  const NewUserForm({super.key});

  @override
  State<NewUserForm> createState() => _NewUserFormState();
}

class _NewUserFormState extends State<NewUserForm> {
  TextEditingController fullName = TextEditingController();
  // TextEditingController lastName = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController mailId = TextEditingController();
  bool isImageUploading = false;
  bool imageUploadFailed = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? selectedType;

  String? validateFields() {
    String? checkUserName = Validation.validateUserName(fullName.text);

    if (checkUserName != null) {
      return checkUserName;
    }
    if (selectedType == null) {
      return 'Should select one type';
    }

    String? checkEmailAddress = Validation.validateUserEmailID(mailId.text);
    if (checkEmailAddress != null) {
      return checkEmailAddress;
    }

    if (password.text.isEmpty) {
      return 'Passwrd cannot be empty';
    }

    if (password.text.length > 6) {
      return 'Password is too weak';
    }

    if (context.read<ClientBloc>().state.clientUploadLogoResponse == null &&
        selectedType == null) {
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
    fullName.addListener(_validateForm);
    // lastName.addListener(_validateForm);
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
            BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                return Text(
                  "Create New User ${state.uploadLogoResponse}",
                  style: ClanChurnTypography.font20600,
                );
              },
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
                              // add get all users api
                            },
                          ));
                      Navigator.pop(context);
                    }
                  },
                );
              }
            },
            child: BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                return CircleAvatar(
                    radius: 50,
                    foregroundImage: state.uploadLogoResponse == null
                        ? null
                        : NetworkImage(
                            state.uploadLogoResponse!.imageUrl,
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
                            text: 'Full Name',
                          ),
                          CusTextEditingController(
                            hintText: "Enter Full Name",
                            controller: fullName,
                            onChanged: (p0) {},
                            textInputAction: TextInputAction.next,
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CusText(
                            text: 'Type of user',
                          ),
                          SizedBox(
                            width: 400,
                            child: BlocBuilder<UserBloc, UserState>(
                              builder: (context, state) {
                                return DropdownButtonHideUnderline(
                                  child: DropdownButton2<String>(
                                    isExpanded: true,
                                    hint: Row(children: [
                                      Text(
                                        'Select',
                                        style: ClanChurnTypography.font18500,
                                        overflow: TextOverflow.ellipsis,
                                      )
                                    ]),
                                    items: state.userTypes
                                        .map((String item) =>
                                            DropdownMenuItem<String>(
                                              value: item,
                                              child: Text(
                                                item,
                                                style: ClanChurnTypography
                                                    .font18500
                                                    .copyWith(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .background),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ))
                                        .toList(),
                                    value: selectedType,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedType = value;
                                      });
                                    },
                                    selectedItemBuilder:
                                        (BuildContext context) {
                                      return state.userTypes.map((String item) {
                                        return Center(
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                item,
                                                style: ClanChurnTypography
                                                    .font18500
                                                    .copyWith(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .secondary),
                                              ),
                                            ],
                                          ),
                                        );
                                      }).toList();
                                    },
                                    buttonStyleData: ButtonStyleData(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary
                                                .withOpacity(0.6)),
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary
                                            .withOpacity(0.2),
                                      ),
                                      elevation: 0,
                                    ),
                                    iconStyleData: IconStyleData(
                                      icon:
                                          const Icon(Icons.keyboard_arrow_down),
                                      iconSize: 25,
                                      iconEnabledColor: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      iconDisabledColor: Colors.grey,
                                    ),
                                    dropdownStyleData: DropdownStyleData(
                                      elevation: 0,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary
                                                .withOpacity(0.6)),
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary
                                            .withOpacity(1.0),
                                      ),
                                      scrollbarTheme: ScrollbarThemeData(
                                        radius: const Radius.circular(40),
                                        thickness: MaterialStateProperty.all(6),
                                        thumbVisibility:
                                            MaterialStateProperty.all(true),
                                      ),
                                    ),
                                    menuItemStyleData: const MenuItemStyleData(
                                      height: 40,
                                      padding:
                                          EdgeInsets.only(left: 14, right: 14),
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),

                      // Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     const CusText(
                      //       text: 'Last Name',
                      //     ),
                      //     CusTextEditingController(
                      //       hintText: "Enter Last Name",
                      //       controller: lastName,
                      //       onChanged: (p0) {},
                      //       textInputAction: TextInputAction.next,
                      //     )
                      //   ],
                      // ),
                    ],
                  ),
                  const Row(
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      // Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     const CusText(
                      //       text: 'Assign Client',
                      //     ),
                      //     CusTextEditingController(
                      //       hintText: "Enter Last Name",
                      //       controller: lastName,
                      //       onChanged: (p0) {},
                      //       textInputAction: TextInputAction.next,
                      //     )
                      //   ],
                      // ),
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
                BlocBuilder<UserBloc, UserState>(
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: checkValidation()
                          ? () {
                              context.read<UserBloc>().add(AddUserEvent(
                                    clientId: '',
                                    firstName: fullName.text,
                                    lastName: '',
                                    email: mailId.text,
                                    password: password.text,
                                    userType: selectedType ?? '',
                                    image: state.uploadLogoResponse?.filename,
                                    onErrorCallback: (errorMessage, errorCode) {
                                      ApiRepository().handleWarningMessage(
                                          errorMessage, context, errorCode);
                                    },
                                    onSuccessCallback: (message) {
                                      Navigator.pushReplacement(
                                          context,
                                          customPageRouteForNavigation(
                                              const CreateClient()));
                                      ApiRepository().handleSuccessMessage(
                                          "successfully created user!....",
                                          context);
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
                    );
                  },
                )
              ]),
        )
      ],
    );
  }
}
