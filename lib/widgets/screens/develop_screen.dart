import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:izobility_mobile/utils/ui/fonts.dart';
import 'package:izobility_mobile/utils/ui/gradients.dart';
import 'package:izobility_mobile/widgets/app_bar/custom_app_bar.dart';

class DevelopingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        context: context,
        text: "Упс..",
        isBack: true,
        onTap: () {
          context.pop();
        },
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              padding: const EdgeInsets.all(16),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(width: 2, color: Colors.green[900]!),
                  gradient: AppGradients.gradientGreenDark),
              width: MediaQuery.sizeOf(context).width * 0.8,
              constraints: const BoxConstraints(maxWidth: 500),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/sad_emoji.png",
                    width: 65,
                    fit: BoxFit.fitWidth,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Кажется, тут чего-то не хватает!",
                    style: AppTypography.font18w700,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Этот функционал находится в разработке\n\nНаши разработчики, дизайнеры и менеджеры работают 24/7, чтобы выкатить новые фишки!",
                    style: AppTypography.font12w400,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
