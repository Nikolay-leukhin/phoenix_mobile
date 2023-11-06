import 'package:flutter/material.dart';
import 'package:izobility_mobile/utils/ui/colors.dart';
import 'package:izobility_mobile/utils/ui/fonts.dart';

class ButtonSocialMediaLink extends StatelessWidget {
  final String text;
  final Function() onTap;

  const ButtonSocialMediaLink({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);

    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: AppColors.disableButton),
            borderRadius: BorderRadius.circular(100)),
        padding: const EdgeInsets.symmetric(vertical: 4),
        width: sizeOf.width * 0.45,
        child: Text(text, style: AppTypography.font14w700.copyWith(color: Colors.black),),
      ),
    );
  }
}
