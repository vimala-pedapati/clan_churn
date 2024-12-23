import 'package:clan_churn/utils/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../api_repos/models/get_pro_threshold_val_model.dart';
import '../churn_blocs/project_architect/project_architect_bloc.dart';
import 'cus_text_editing_controller.dart';

class CusThresholdCurrencyField extends StatefulWidget {
  const CusThresholdCurrencyField(
      {super.key,
      required this.thresholdFormVal,
      this.textInputAction,
      // required this.onChanged,
      this.isEnabled,
      this.value,
      required this.isMaxValue});
  final GetProThresholdFormValModel thresholdFormVal;
  final TextInputAction? textInputAction;
  // final Function(String) onChanged;
  final bool? isEnabled;
  final dynamic value;
  final bool isMaxValue;

  @override
  State<CusThresholdCurrencyField> createState() => _CusThresholdCurrencyFieldState();
}

class _CusThresholdCurrencyFieldState extends State<CusThresholdCurrencyField> {
  final TextEditingController controller = TextEditingController();
  String value = "";
  String formatToCurrency({required String currency}) {
    if (currency.isNotEmpty) {
      int a = int.parse(currency.replaceAll(",", ""));
      String c = NumberFormat.decimalPattern("hi-IN").format(a);
      return c;
    }

    return "";
  }

  // updateController(String value) {
  //   controller.text = formatToCurrency(currency: (value).toString().replaceAll(",", ""));
  //   // setState(() {});
  // }

  @override
  // void didUpdateWidget(covariant CusThresholdCurrencyField oldWidget) {
  //   controller.text = formatToCurrency(currency: (value).toString().replaceAll(",", ""));
  //   super.didUpdateWidget(oldWidget);
  // }

  @override
  void initState() {
    controller.text = formatToCurrency(currency: (widget.value ?? '').toString());
    if (widget.value != null) {
      if (widget.isMaxValue) {
        context.read<ProjectArchitectBloc>().add(
              UpdateProjectThresholdMaxValue(
                maxValue: widget.value,
                thresholdId: widget.thresholdFormVal.id,
              ),
            );
      } else {
        context.read<ProjectArchitectBloc>().add(
              UpdateProjectThresholdMinValue(
                minValue: widget.value,
                thresholdId: widget.thresholdFormVal.id,
              ),
            );
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 35,
        width: 150,
        decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary.withOpacity(0.2), borderRadius: BorderRadius.circular(08)),
        margin: const EdgeInsets.only(right: 20, top: 10, bottom: 10),
        child: TextFormField(
          controller: controller,
          textInputAction: widget.textInputAction,
          onChanged: (value) {
            // updateController(value);
            controller.text = formatToCurrency(currency: value);
            controller.selection = TextSelection(baseOffset: controller.text.length, extentOffset: controller.text.length);
            if (widget.isMaxValue) {
              context.read<ProjectArchitectBloc>().add(
                    UpdateProjectThresholdMaxValue(
                      maxValue: value.replaceAll(",", ""),
                      thresholdId: widget.thresholdFormVal.id,
                    ),
                  );
            } else {
              context.read<ProjectArchitectBloc>().add(
                    UpdateProjectThresholdMinValue(
                      minValue: value.replaceAll(",", ""),
                      thresholdId: widget.thresholdFormVal.id,
                    ),
                  );
            }
          },
          enabled: widget.isEnabled,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^-?[\d,]*')),
            LengthLimitingTextInputFormatter(11),
          ],
          decoration: InputDecoration(
            hintText: "0",
            hintStyle: ClanChurnTypography.font18500.copyWith(color: Theme.of(context).colorScheme.onSecondary.withOpacity(0.8)),
            contentPadding: const EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            enabledBorder: border(context),
            focusedBorder: border(context),
            border: border(context),
            prefixIcon: widget.thresholdFormVal.columnDataType == ColumnDataType.numericCurrnecy
                ? Icon(
                    Icons.currency_rupee_outlined,
                    size: 20,
                    color: Theme.of(context).colorScheme.primary,
                  )
                : null,
          ),
        ));
  }
}
