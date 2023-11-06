import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:izobility_mobile/utils/ui/colors.dart';
import 'package:izobility_mobile/utils/ui/fonts.dart';
import 'package:izobility_mobile/widgets/button/custom_button.dart';

class PopupPromoSuccess extends StatefulWidget {
  // final Function onAccept;
  // final Function onDecline;
  // final String label;
  // final String? description;

  final String coinName;
  final String coinAmount;

  const PopupPromoSuccess({super.key, required this.coinName,
  required this.coinAmount
      // required this.onAccept,
      // required this.onDecline,
      // required this.label,
      // this.description
      });

  @override
  State<PopupPromoSuccess> createState() => _PopupPromoSuccessState();
}

class _PopupPromoSuccessState extends State<PopupPromoSuccess> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
      child: Dialog(
        insetPadding: EdgeInsets.zero,
        elevation: 0,
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        child: Container(
          width: MediaQuery.sizeOf(context).width - 32,
          constraints: const BoxConstraints(maxWidth: 500),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(16)),
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                "assets/images/celebrate.png",
                width: 64,
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                "Поздравляем! Вы получили:",
                textAlign: TextAlign.center,
                style:
                    AppTypography.font18w700.copyWith(color: AppColors.grey600),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                "${widget.coinAmount} ${widget.coinName}",
                style:
                    AppTypography.font32w700.copyWith(color: AppColors.primary),
              ),
              const SizedBox(
                height: 16,
              ),
              CustomButton(
                  isActive: true,
                  text: "Подтвердить",
                  onTap: () {
                    context.pop();
                  },
                  width: size.width)
            ],
          ),
        ),
      ),
    );
  }
}
