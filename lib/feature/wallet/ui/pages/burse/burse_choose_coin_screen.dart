import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:izobility_mobile/feature/wallet/data/wallet_repository.dart';
import 'package:izobility_mobile/feature/wallet/ui/widgets/choose_coin_card.dart';
import 'package:izobility_mobile/models/api/token_data.dart';
import 'package:izobility_mobile/utils/ui/colors.dart';
import 'package:izobility_mobile/widgets/app_bar/custom_app_bar.dart';

class BurseChooseCoinScreen extends StatefulWidget {
  const BurseChooseCoinScreen({super.key, required this.fromOrTo});

  final bool fromOrTo;

  @override
  State<BurseChooseCoinScreen> createState() => _BurseChooseCoinScreenState();
}

class _BurseChooseCoinScreenState extends State<BurseChooseCoinScreen> {
  @override
  Widget build(BuildContext context) {
    final walletRepository = context.read<WalletRepository>();

    List<TokenData> res = walletRepository.walletPage == 0
        ? walletRepository.coinsInChain
        : walletRepository.coinsInGame;

    return Container(
      color: Colors.white,
      child: Scaffold(
        backgroundColor: AppColors.purpleBcg,
        appBar: CustomAppBar(
          context: context,
          text: "Coin",
          isBack: true,
          onTap: () {
            context.pop();
          },
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(children: [
              const SizedBox(
                height: 16,
              ),
              Column(children: [
                ...List.generate(
                    res.length,
                    (index) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: ChooseCoinCard(
                            onTap: () {
                              if (widget.fromOrTo) {
                                walletRepository.setActiveBurseTokenFrom(res[index]);
                                print(walletRepository.activeBurseTokenFrom!.name);
                              } else {
                                walletRepository.setActiveBurseTokenTo(res[index]);
                              }
                              setState(() {});
                              context.pop();
                            },
                            coin: res[index],
                          ),
                        )),
              ])
            ]),
          ),
        ),
      ),
    );
  }
}
