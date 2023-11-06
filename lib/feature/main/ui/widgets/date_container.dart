import 'package:flutter/material.dart';
import 'package:izobility_mobile/utils/utils.dart';

class DateText extends StatefulWidget {
  final String date;

  const DateText({super.key, required this.date});

  @override
  State<DateText> createState() => _DateTextState();
}

class _DateTextState extends State<DateText> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      color: AppColors.purpleBcg,
      child: Text(
        widget.date,
        style: AppTypography.font12w400.copyWith(color: AppColors.grey600),
        textAlign: TextAlign.center,
      ),
    );
  }
}
