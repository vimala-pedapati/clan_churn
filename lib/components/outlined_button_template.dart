import 'package:clan_churn/utils/spacing.dart';
import 'package:clan_churn/utils/typography.dart';
import 'package:flutter/material.dart';

class OutlinedButtonTemplate extends StatefulWidget {
  const OutlinedButtonTemplate(
      {super.key,
      required this.icon,
      required this.title,
      required this.onPressed,
      this.onHoverTextChange});
  final IconData icon;
  final String title;
  final VoidCallback onPressed;
  final String? onHoverTextChange;

  @override
  State<OutlinedButtonTemplate> createState() => _OutlinedButtonTemplateState();
}

class _OutlinedButtonTemplateState extends State<OutlinedButtonTemplate> {
  bool hovered = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        setState(() {
          hovered = true;
        });
      },
      onExit: (event) {
        setState(() {
          hovered = false;
        });
      },
      child: SizedBox(
        height: 35,
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
            backgroundColor: hovered
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.background,
            foregroundColor: hovered
                ? Theme.of(context).colorScheme.background
                : Theme.of(context).colorScheme.primary,
            side: BorderSide(
                color: Theme.of(context).colorScheme.primary,
                width: 1.5), // Adjust the border side
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(8), // Adjust the border radius
            ),
          ),
          onPressed: widget.onPressed,
          child: Row(
            children: [
              Icon(
                widget.icon,
                size: 20,
              ),
              ClanChurnSpacing.w10,
              Text(
               hovered? widget.onHoverTextChange ?? widget.title :  widget.title,
                style: ClanChurnTypography.font14900, // Custom text style
              ),
            ],
          ),
        ),
      ),
    );
  }
}
