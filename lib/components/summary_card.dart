import 'package:clan_churn/utils/typography.dart';
import 'package:flutter/material.dart';

class SummaryCard extends StatefulWidget {
  const SummaryCard(
      {super.key,
      required this.value,
      required this.header,
      required this.isDisabled});
  final String value;
  final String header;
  final bool isDisabled;

  @override
  State<SummaryCard> createState() => _SummaryCardState();
}

class _SummaryCardState extends State<SummaryCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 200,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(05),
          color: widget.isDisabled
              ? Theme.of(context).colorScheme.secondary.withOpacity(0.8)
              : Theme.of(context).colorScheme.primary.withOpacity(0.8)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(widget.isDisabled ? "--" : widget.value,
              style: ClanChurnTypography.font15900
                  .copyWith(color: Theme.of(context).colorScheme.background)),
          Text(widget.header,
              style: ClanChurnTypography.font14900
                  .copyWith(color: Theme.of(context).colorScheme.background))
        ],
      ),
    );
  }
}
