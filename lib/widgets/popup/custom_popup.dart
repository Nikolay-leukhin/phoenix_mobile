import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:izobility_mobile/utils/ui/colors.dart';
import 'package:izobility_mobile/utils/ui/fonts.dart';
import 'package:izobility_mobile/widgets/button/custom_button.dart';

class CustomPopup extends StatefulWidget {
  final Function onTap;
  final String imagePath;
  final String label;

  const CustomPopup({
    super.key,
    required this.imagePath,
    required this.onTap,
    required this.label,
  });

  @override
  State<CustomPopup> createState() => _CustomPopupState();
}

class _CustomPopupState extends State<CustomPopup> {
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
                widget.imagePath,
                width: 64,
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                widget.label,
                textAlign: TextAlign.center,
                style:
                    AppTypography.font18w700.copyWith(color: AppColors.grey600),
              ),
              const SizedBox(
                height: 16,
              ),
              const SizedBox(
                height: 16,
              ),
              CustomButton(
                  isActive: true,
                  text: "Подтвердить",
                  onTap: () {
                    widget.onTap();
                  },
                  width: size.width)
            ],
          ),
        ),
      ),
    );
  }
}
