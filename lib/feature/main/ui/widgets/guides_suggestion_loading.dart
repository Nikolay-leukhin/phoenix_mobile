import 'package:flutter/material.dart';
import 'package:izobility_mobile/utils/ui/gradients.dart';

class GuidesSuggestionLoading extends StatelessWidget {
  const GuidesSuggestionLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 6, left: 2),
      padding: const EdgeInsets.all(6),
      alignment: Alignment.bottomCenter,
      width: 100,
      height: 100,
      decoration: ShapeDecoration(
        gradient: AppGradients.gradientGreenDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
