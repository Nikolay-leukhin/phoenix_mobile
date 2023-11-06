import 'package:flutter/material.dart';
import 'package:izobility_mobile/utils/ui/fonts.dart';

import '../../utils/ui/colors.dart';

class TextButtonWithoutBackground extends StatelessWidget {
  const TextButtonWithoutBackground(
      {super.key,
      required this.onTap,
      required this.text,
      this.textColor = AppColors.disable,
      this.textStyle});

  final VoidCallback onTap;
  final String text;
  final Color textColor;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        text,
        style: (textStyle ?? AppTypography.font16w400).copyWith(color: textColor),
      ),
    );
  }
}
