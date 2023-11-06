import 'package:flutter/material.dart';
import 'package:izobility_mobile/utils/ui/colors.dart';
import 'package:izobility_mobile/utils/ui/fonts.dart';

class CustomLinearIndicator extends StatefulWidget {
  const CustomLinearIndicator({super.key});

  @override
  State<CustomLinearIndicator> createState() => _CustomLinearIndicatorState();
}

class _CustomLinearIndicatorState extends State<CustomLinearIndicator>
    with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
      if(controller.value >= 0.99){
        Navigator.pushNamed(context, '/home_screen');
      }
      setState(() {});
    });
    controller.repeat();

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LinearProgressIndicator(
          value: controller.value,
          semanticsLabel: 'Linear progress indicator',
          backgroundColor: AppColors.backgroundSecondary,
          color: AppColors.primary,
          minHeight: 8,
          borderRadius: BorderRadius.circular(4),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          '${(controller.value * 100).round()}% загрузка',
          style: AppTypography.font14w400.copyWith(color: AppColors.primary),
        )
      ],
    );
  }
}