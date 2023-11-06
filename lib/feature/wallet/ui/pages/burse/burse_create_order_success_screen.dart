import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:izobility_mobile/utils/ui/colors.dart';
import 'package:izobility_mobile/utils/ui/fonts.dart';
import 'package:izobility_mobile/utils/ui/gradients.dart';
import 'package:izobility_mobile/widgets/app_bar/custom_app_bar.dart';
import 'package:izobility_mobile/widgets/button/custom_button.dart';

class BurseCreateOrderSuccessScreen extends StatefulWidget {
  const BurseCreateOrderSuccessScreen({super.key});

  @override
  State<BurseCreateOrderSuccessScreen> createState() => _BurseCreateOrderSuccessScreenState();
}

class _BurseCreateOrderSuccessScreenState extends State<BurseCreateOrderSuccessScreen> {
  final _sendController = TextEditingController();
  final _getController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Container(
      color: Colors.white,
      child: Scaffold(
          backgroundColor: AppColors.purpleBcg,
          appBar: CustomAppBar(
            context: context,
            text: "Создание заказа",
            isBack: true,
            onTap: () {
              context.pop();
            },
          ),
          body: Container(
              color: AppColors.purpleBcg,
              padding: const EdgeInsets.all(16),
              child: buildCreateOrderSuccessWidget())),
    );
  }

  Widget buildCreateOrderSuccessWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          decoration: BoxDecoration(
              gradient: AppGradients.gradientGreenDark,
              borderRadius: BorderRadius.circular(16)),
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/celebrate.png",
                width: 64,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "Поздравляем!\nВаш заказ размещен!!",
                textAlign: TextAlign.center,
                style: AppTypography.font18w700.copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        CustomButton(
            text: "На биржу",
            onTap: () {
              context.pop();
              context.pop();
            },
            width: double.infinity)
      ],
    );
  }
}
