import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:izobility_mobile/utils/ui/colors.dart';
import 'package:izobility_mobile/utils/ui/fonts.dart';
import 'package:izobility_mobile/widgets/button/custom_button.dart';

class PopupPromoFailure extends StatefulWidget {
  // final Function onAccept;
  // final Function onDecline;
  // final String label;
  // final String? description;

  const PopupPromoFailure({
    super.key,
    // required this.onAccept,
    // required this.onDecline,
    // required this.label,
    // this.description
  });

  @override
  State<PopupPromoFailure> createState() => _PopupPromoFailureState();
}

class _PopupPromoFailureState extends State<PopupPromoFailure> {
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
                "assets/images/sad_emoji.png",
                width: 64,
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                "C этим промокодом что-то не так",
                textAlign: TextAlign.center,
                style:
                    AppTypography.font18w700.copyWith(color: AppColors.grey600),
              ),
              const SizedBox(
                height: 48,
              ),
              CustomButton(
                  withBorder: false,
                  color: AppColors.grey800,
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
