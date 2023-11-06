import 'package:flutter/material.dart';
import 'package:izobility_mobile/utils/ui/colors.dart';
import 'package:izobility_mobile/utils/ui/fonts.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    Key? key,
    required this.title,
    required this.onTap}) : super(key: key);

  final String title;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(16),
        child: Text(
          title,
          textAlign: TextAlign.left,
          style: AppTypography.font16w500.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
      ),
    );
  }
}
