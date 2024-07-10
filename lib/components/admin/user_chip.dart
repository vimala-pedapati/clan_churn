import 'package:clan_churn/api_repos/models/user_model.dart';
import 'package:clan_churn/utils/typography.dart';
import 'package:flutter/material.dart';

class UserChip extends StatelessWidget {
  const UserChip({super.key, required this.user, this.onDeleted});
  final User user;
  final Function()? onDeleted;
  // final Function(List<User>) updatedUser;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(),
      child: Chip(
          labelPadding:
              const EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 5),
          elevation: 00,
          backgroundColor:
              Theme.of(context).colorScheme.primary.withOpacity(0.2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100.0),
            side: const BorderSide(width: 0, color: Colors.transparent),
          ),
          deleteIcon: Icon(
            Icons.close,
            size: 15,
            color: Theme.of(context).colorScheme.primary,
          ),
          onDeleted:onDeleted,
          label: Text('${user.firstName}',
              style: ClanChurnTypography.font15600.copyWith(
                  height: 1, color: Theme.of(context).colorScheme.primary))),
    );
  }
}
