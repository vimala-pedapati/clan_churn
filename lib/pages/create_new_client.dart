import 'package:clan_churn/components/churn_continer.dart';
import 'package:clan_churn/components/nav_bar.dart';
import 'package:clan_churn/components/side_bar.dart';
import 'package:clan_churn/components/wrap_profile.dart';
import 'package:clan_churn/utils/typography.dart';
import 'package:flutter/material.dart';

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
                        child: ChurnContainer(
                            child: Expanded(child: NewClientForm()))),
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

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.keyboard_backspace_outlined),
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
          child: CircleAvatar(
            radius: 50,
            child: Icon(
              Icons.add_photo_alternate_outlined,
              size: 40,
              color: Theme.of(context).colorScheme.background,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          flex: 3,
          child: FittedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
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
                      mainAxisAlignment: MainAxisAlignment.start,
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
                  mainAxisAlignment: MainAxisAlignment.start,
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
                      mainAxisAlignment: MainAxisAlignment.start,
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
                      mainAxisAlignment: MainAxisAlignment.start,
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
                      mainAxisAlignment: MainAxisAlignment.start,
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
        Expanded(
          flex: 1,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
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
                  onPressed: () {},
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
          controller: TextEditingController(),
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
