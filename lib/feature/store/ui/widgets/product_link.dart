import 'package:flutter/material.dart';
import 'package:izobility_mobile/utils/ui/fonts.dart';
import 'package:izobility_mobile/utils/utils.dart';

class ProductLink extends StatelessWidget {
  final String linkText;

  const ProductLink({super.key, required this.linkText});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.grey500, width: 2))
      ),
      child: Text(
        linkText,
        style: AppTypography.font14w700.copyWith(color: AppColors.grey500),
      ),
    );
  }
}
