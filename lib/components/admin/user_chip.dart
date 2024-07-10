
import 'package:clan_churn/api_repos/models/user_model.dart';
import 'package:clan_churn/utils/typography.dart';
import 'package:flutter/material.dart';

class UserChip extends StatelessWidget {
  const UserChip({super.key, required this.user, this.onDeleted});
  final User user;
  final Function()? onDeleted;

  @override
  Widget build(BuildContext context) {
    return Chip(
        labelPadding: EdgeInsets.zero,
        elevation: 00,
        backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.0),
          side: const BorderSide(width: 0, color: Colors.transparent),
        ),
        deleteIcon: Icon(
          Icons.close,
          size: 15,
          color: Theme.of(context).colorScheme.primary,
        ),
        onDeleted: () {},
        label: Text('${user.firstName}',
            style: ClanChurnTypography.font14400.copyWith(
                height: 1, color: Theme.of(context).colorScheme.primary)));
  }
}
