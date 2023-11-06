import 'package:flutter/material.dart';
import 'package:izobility_mobile/utils/ui/gradients.dart';

class MarketItemLoading extends StatelessWidget {
  const MarketItemLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (MediaQuery.of(context).size.width - 40) / 2,
      height: (MediaQuery.of(context).size.width - 40) / 2 * 160 / 240,
      margin: const EdgeInsets.all(6),
      decoration: ShapeDecoration(
        gradient: AppGradients.gradientGreenDark,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}
