import 'package:flutter/material.dart';
import '../../utils/utils.dart';

class RoundedButton extends StatelessWidget {
  final String text;

  final double width;
  final double height;

  final VoidCallback onTap;

  const RoundedButton({
    super.key,
    required this.text,
    required this.width,
    required this.height,
    required this.onTap,});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        decoration: ShapeDecoration(
          color: AppColors.blackOpacity,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),),),
        child:TextButton(
          onPressed: onTap,
          child:  Text(text,
            style: AppTypography.font16w600.copyWith(color:AppColors.textPrimary ),),) );
  }
}
