import 'package:flutter/material.dart';
import 'package:izobility_mobile/utils/utils.dart';

class CustomOutlineButton extends StatelessWidget {
  const CustomOutlineButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        alignment: Alignment.center,
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border.all(color: AppColors.darkBlue, width: 1),
            borderRadius: BorderRadius.circular(8)),
        child: Text(
          "Активировать промокод",
          style: AppTypography.font18w600.copyWith(color: AppColors.darkBlue),
        ),
      ),
    );
  }
}