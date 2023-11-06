import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/ui/colors.dart';
import '../../utils/ui/fonts.dart';

class CategoryContainer extends StatelessWidget {
  const CategoryContainer(
      {super.key,
      required this.asset,
      required this.text,
      required this.onTap});

  final String asset;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 110,
        height: 70,
        padding: const EdgeInsets.all(8),
        decoration: ShapeDecoration(
          color: AppColors.backgroundSecondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(11),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(asset),
            Text(text,
                style:
                    AppTypography.font12w500.copyWith(color: AppColors.textPrimary))
          ],
        ),
      ),
    );
  }
}
