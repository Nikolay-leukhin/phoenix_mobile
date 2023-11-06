import 'package:flutter/material.dart';
import 'package:izobility_mobile/utils/ui/colors.dart';
import 'package:izobility_mobile/utils/ui/fonts.dart';

class UnderlineTextLink extends StatelessWidget {
  const UnderlineTextLink({
    Key? key,
    required this.text,
    required this.onTap}) : super(key: key);

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        text,
        style: AppTypography.font12w400.copyWith(
          color: AppColors.textSecondary,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
