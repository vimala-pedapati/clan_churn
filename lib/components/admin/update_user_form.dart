import 'package:clan_churn/api_repos/api_repo.dart';
import 'package:clan_churn/api_repos/models/user_model.dart';
import 'package:clan_churn/churn_blocs/client/client_bloc.dart';
import 'package:clan_churn/churn_blocs/user/user_bloc.dart';
import 'package:clan_churn/components/cus_text.dart';
import 'package:clan_churn/components/cus_text_editing_controller.dart';
import 'package:clan_churn/components/dialogs.dart';
import 'package:clan_churn/components/project_card.dart';
import 'package:clan_churn/pages/create_client.dart';
import 'package:clan_churn/utils/routes.dart';
import 'package:clan_churn/utils/typography.dart';
import 'package:clan_churn/utils/validations.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/_internal/file_picker_web.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateUser extends StatefulWidget {
  const UpdateUser({super.key, required this.user});
  final User user;

  @override
  State<UpdateUser> createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {
  TextEditingController fullName = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
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
    String? checkEmailAddress = Validation.validateUserEmailID(mailId.text);
    if (checkEmailAddress != null) {
      return checkEmailAddress;
    }
    if (selectedType == null) {
      return 'Should select one type';
    }
    if (context.read<ClientBloc>().state.clientUploadLogoResponse == null &&
        selectedType == null) {
      return 'Profile pic is required';
    }
    if (password.text.isNotEmpty) {
      if (!(password.text.length >= 6 &&
          password.text == confirmPassword.text)) {
        return 'Password is too weak';
      }
    }
    return null;
  }

  String? checkConfirmPassword() {
    if (password.text.isNotEmpty) {
      if (password.text == confirmPassword.text) {
        return null;
      }
    }
    return "The Password and Confirm password should be the same";
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
    confirmPassword.addListener(_validateForm);
    password.addListener(_validateForm);
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
    setState(() {
      fullName.text = widget.user.firstName ?? '';
      // lastName.text = widget.user.lastName;
      mailId.text = widget.user.email;
      selectedType = widget.user.userType.value;
    });

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
              "Update User",
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
                return ClipOval(
                    // radius: 50,
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(
                    "${widget.user.image}",
                    // loadingBuilder: ((context, child, loadingProgress) {
                    //   return const CircularProgressIndicator();
                    // }),
                    errorBuilder: (context, error, stackTrace) {
                      return ClipOval(
                          child: Image.network(
                        image,
                        scale: 1,
                      ));
                    },
                  ),
                ));
                // return CircleAvatar(
                //     radius: 50,
                //     foregroundImage: state.user == null
                //         ? null
                //         : NetworkImage(
                //             state.clientUploadLogoResponse!.imageUrl,
                //           ),
                //     child: Icon(
                //       Icons.add_photo_alternate_outlined,
                //       size: 40,
                //       color: Theme.of(context).colorScheme.background,
                //     ));
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
                            isNotRequired: true,
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
                            text: 'Email ID',
                            isNotRequired: true,
                          ),
                          CusTextEditingController(
                            hintText: "Enter Mail Id",
                            controller: mailId,
                            onChanged: (p0) {},
                            isEnabled: false,
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
                            isNotRequired: true,
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
                      const SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CusText(
                            text: 'Password',
                            isNotRequired: true,
                          ),
                          CusTextEditingController(
                            hintText: "********",
                            controller: password,
                            isObacureText: true,
                            onChanged: (p0) {},
                            textInputAction: TextInputAction.next,
                          ),
                        ],
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
                  if (password.text.trim().isNotEmpty)
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CusText(
                              text: 'Confirm Password',
                            ),
                            CusTextEditingController(
                              hintText: "********",
                              isObacureText: true,
                              controller: confirmPassword,
                              onChanged: (p0) {},
                              textInputAction: TextInputAction.next,
                            ),
                          ],
                        ),
                        // Column(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     const CusText(
                        //       text: 'Password',
                        //     ),
                        //     CusTextEditingController(
                        //       hintText: "Enter your password",
                        //       controller: password,
                        //       onChanged: (p0) {},
                        //       textInputAction: TextInputAction.next,
                        //     ),
                        //   ],
                        // ),
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
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (password.text.trim().isNotEmpty)
                  if (checkConfirmPassword() != null)
                    Text(
                      "${checkConfirmPassword()}",
                      style: ClanChurnTypography.font12600
                          .copyWith(color: Theme.of(context).colorScheme.error),
                    ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    BlocBuilder<UserBloc, UserState>(
                      builder: (context, state) {
                        return ElevatedButton(
                          onPressed: checkValidation()
                              ? () {
                                  context.read<UserBloc>().add(UpdateUserEvent(
                                        clientId: '',
                                        firstName: fullName.text,
                                        lastName: null,
                                        image:
                                            state.uploadLogoResponse?.filename,
                                        // email: mailId.text,
                                        userId: widget.user.userId,
                                        password: password.text.trim().isEmpty
                                            ? null
                                            : password.text,
                                        userType: selectedType!,
                                        onErrorCallback:
                                            (errorMessage, errorCode) {
                                          print(
                                              "error response from update user: $errorMessage, $errorCode");
                                        },
                                        onSuccessCallback: (message) {
                                          print(
                                              "success response from update user: ${message?.body}");
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
                                  "Update User",
                                  style: ClanChurnTypography.font15600,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        context.read<UserBloc>().add(
                              DeleteUserEvent(
                                userId: widget.user.userId,
                                onErrorCallback: (errorMessage, errorCode) {
                                  ApiRepository().handleWarningMessage(
                                      errorMessage, context, errorCode);
                                },
                                onSuccessCallback: (message) {
                                  Navigator.pop(context);
                                },
                              ),
                            );
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.error),
                      child: Row(
                        children: [
                          const Icon(Icons.delete_outline_outlined),
                          const SizedBox(
                            width: 10,
                          ),
                          FittedBox(
                            child: Text(
                              "Delete",
                              style: ClanChurnTypography.font15600,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ]),
        )
      ],
    );
  }
}
