import 'package:flutter/material.dart';
import 'package:izobility_mobile/utils/utils.dart';

class PorfileBlocLabel extends StatelessWidget {
  final String text;
  
  const PorfileBlocLabel({
    super.key, required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 12, top: 32),
      child: Text(
        text,
        style: AppTypography.font12w400.copyWith(color: AppColors.textSecondary),
      ),
    );
  }
}