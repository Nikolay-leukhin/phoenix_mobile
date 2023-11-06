import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:izobility_mobile/utils/ui/gradients.dart';

import '../../../../utils/utils.dart';

class ButtonSwap extends StatelessWidget {
  final Function onTap;

  const ButtonSwap({
    super.key, required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: AppColors.purple600,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        gradient: AppGradients.gradientGreenWhite
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(100),
        onTap: () {
          onTap();
        },
        child: Container(
          width: 56,
          height: 56,
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: SvgPicture.asset("assets/icons/transfer_arrows_bold.svg", color: Colors.black,),
        ),
      ),
    );
  }
}
