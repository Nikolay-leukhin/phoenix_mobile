import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:izobility_mobile/utils/ui/colors.dart';
import 'package:izobility_mobile/utils/ui/fonts.dart';

enum KeyboardButtonType { number, delete, biometric }

class KeyboardButton extends StatelessWidget {
  KeyboardButton(
      {super.key,
      required this.onTap,
      String? number,
      required this.side,
      this.keyboardButtonType = KeyboardButtonType.number})
      : child = number != null
            ? Text(
                number,
                style: AppTypography.font16w700.copyWith(color: Colors.black),
              )
            : SvgPicture.asset(
                keyboardButtonType == KeyboardButtonType.delete
                    ? 'assets/icons/delete-left.svg'
                    : 'assets/icons/fingerprint.svg',
              ) {
    assert(
        !(number == null && keyboardButtonType == KeyboardButtonType.number));
  }

  final VoidCallback onTap;
  final Widget child;
  final double side;
  final KeyboardButtonType keyboardButtonType;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return InkWell(
      borderRadius: BorderRadius.circular(80),
      onTap: onTap,
      child: Ink(
        width: side,
        height: side,
        decoration: ShapeDecoration(
          color: AppColors.backgroundSecondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(80),
          ),
        ),
        child: Container(
          padding: EdgeInsets.all(size.width * 0.055),
          child: FittedBox(child: child),
        ),
      ),
    );
  }
}
