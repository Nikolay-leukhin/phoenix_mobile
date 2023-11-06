import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:phoenix_mobile/utils/ui/colors.dart';
import 'package:phoenix_mobile/utils/ui/fonts.dart';
import 'package:phoenix_mobile/utils/ui/gradients.dart';

class WalletAction extends StatelessWidget {
  const WalletAction(
      {super.key,
      required this.title,
      required this.icon,
      required this.onTap,
      this.isActive = true,
      this.iconColor = Colors.white});

  final String title;
  final String icon;
  final Function onTap;
  final bool isActive;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);

    return Column(
      children: [
        Container(
          width: sizeOf.width * 0.156,
          height: sizeOf.width * 0.156,
          decoration: BoxDecoration(
              gradient: AppGradients.gradientBlueWhite,
              borderRadius: BorderRadius.circular(100)),
          child: IconButton(
            onPressed: () => onTap(),
            icon: SvgPicture.asset(
              icon,
              color: iconColor,
              width: sizeOf.width * 0.067,
              height: sizeOf.width * 0.067,
            ),
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          title,
          style: AppTypography.font12w700.copyWith(color: AppColors.primary),
        ),
      ],
    );
  }
}
