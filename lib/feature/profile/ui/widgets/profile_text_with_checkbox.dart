import 'package:flutter/material.dart';
import 'package:izobility_mobile/utils/ui/colors.dart';
import 'package:izobility_mobile/utils/ui/fonts.dart';

class TextWithCheckBox extends StatelessWidget {
  const TextWithCheckBox(
      {super.key,
      required this.value,
      required this.onTap,
      required this.title});

  final bool value;
  final Function() onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Checkbox.adaptive(value: value, onChanged: (v) {
              onTap();
            }),
            Text(
              title,
              style: AppTypography.font24w700
                  .copyWith(color: AppColors.textPrimary),
            ),
          ],
        ));
  }
}
