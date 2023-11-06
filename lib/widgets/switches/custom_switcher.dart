import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:izobility_mobile/feature/wallet/data/wallet_repository.dart';
import 'package:izobility_mobile/routes/go_routes.dart';
import 'package:izobility_mobile/utils/ui/colors.dart';
import 'package:izobility_mobile/utils/ui/fonts.dart';
import 'package:izobility_mobile/utils/ui/gradients.dart';

class CustomSwitcher extends StatelessWidget {
  const CustomSwitcher({super.key, required this.active, required this.onTap});

  final int active;
  final Function(int value) onTap;

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);

    final walletRepository = context.read<WalletRepository>();

    return Container(
      height: 50,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Color(0xFFEEEEEE),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              onTap(0);
            },
            child: Container(
              width: (sizeOf.width - 60 - 84) * 0.5,
              height: 46,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: active == 0
                    ? AppColors.switcherBackground
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                'Wallet',
                style: AppTypography.font16w700.copyWith(
                    color: active == 0
                        ? AppColors.backgroundContent
                        : AppColors.textPrimary),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(1000),
                gradient: AppGradients.gradientGreenWhite),
            child: InkWell(
              borderRadius: BorderRadius.circular(1000),
              onTap: () {
                context.push(RouteNames.walletChooseCoin, extra: {
                  'path': 'chain_game_transfer',
                  "fromOrTo": walletRepository.walletPage == 0
                });
              },
              child: Ink(
                  padding: const EdgeInsets.all(5),
                  child: SvgPicture.asset(
                    "assets/icons/transfer_arrows.svg",
                    width: 24,
                    color: Colors.black,
                  )),
            ),
          ),
          InkWell(
            onTap: () {
              onTap(1);
            },
            child: Container(
              width: (sizeOf.width - 60 - 84) * 0.5,
              height: 46,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: active == 1
                    ? AppColors.switcherBackground
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                'Игровые',
                style: AppTypography.font16w700.copyWith(
                    color: active == 1
                        ? AppColors.backgroundContent
                        : AppColors.textPrimary),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
