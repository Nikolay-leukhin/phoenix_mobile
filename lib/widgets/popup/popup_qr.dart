import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:izobility_mobile/feature/profile/data/user_repository.dart';
import 'package:izobility_mobile/utils/ui/colors.dart';
import 'package:izobility_mobile/utils/ui/fonts.dart';
import 'package:izobility_mobile/widgets/button/custom_button.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PopupQr extends StatefulWidget {
  const PopupQr({
    super.key,
  });

  @override
  State<PopupQr> createState() => _PopupQrState();
}

class _PopupQrState extends State<PopupQr> {
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
              Container(
                constraints: const BoxConstraints(
                  maxWidth: 360
                ),
                child: Image.asset(
                  "assets/images/emerald_logo.png",
                  fit: BoxFit.fitWidth,
                  width: size.width * 0.44,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                constraints: const BoxConstraints(
                  maxWidth: 450
                ),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: QrImageView(
                  data:
                      context.read<UserRepository>().user.details!.referalcode!,
                  version: QrVersions.auto,
                  size: size.width * 0.5,
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              CustomButton(
                  isActive: true,
                  text: "Закрыть",
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
