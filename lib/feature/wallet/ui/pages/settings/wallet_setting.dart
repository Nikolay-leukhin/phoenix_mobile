import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:izobility_mobile/feature/wallet/data/wallet_repository.dart';
import 'package:izobility_mobile/routes/go_routes.dart';
import 'package:izobility_mobile/utils/ui/colors.dart';
import 'package:izobility_mobile/widgets/app_bar/custom_app_bar.dart';
import 'package:izobility_mobile/widgets/button/custom_button.dart';

class WalletSettingScreen extends StatefulWidget {
  const WalletSettingScreen({super.key});

  @override
  State<WalletSettingScreen> createState() => _WalletSettingScreenState();
}

class _WalletSettingScreenState extends State<WalletSettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        appBar: CustomAppBar(
          context: context,
          text: 'Настройки',
          isBack: true,
          onTap: () {
            context.pop();
          },
        ),
        backgroundColor: AppColors.purpleBcg,
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomButton(
                  text: 'Моя Seed-фраза',
                  onTap: () {
                    context.push(RouteNames.walletViewSeed);
                  },
                  width: double.infinity),
              CustomButton(
                text: 'Выйти',
                onTap: () async {
                  await context
                      .read<WalletRepository>()
                      .clearWallet()
                      .then((value) => context.replace(RouteNames.walletAuth));
                },
                width: double.infinity,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
