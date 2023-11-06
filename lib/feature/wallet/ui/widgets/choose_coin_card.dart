import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:izobility_mobile/feature/wallet/data/wallet_repository.dart';
import 'package:izobility_mobile/models/api/token_data.dart';
import 'package:izobility_mobile/utils/logic/constants.dart';
import 'package:izobility_mobile/utils/ui/fonts.dart';

class ChooseCoinCard extends StatelessWidget {
  final Function onTap;
  final TokenData coin;

  const ChooseCoinCard({
    super.key,
    required this.onTap,
    required this.coin,
  });

  @override
  Widget build(BuildContext context) {
    final walletRepository = RepositoryProvider.of<WalletRepository>(context);

    return Material(
      borderRadius: BorderRadius.circular(16),
      color: Colors.white,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          onTap();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  width: 32,
                  height: 32,
                  clipBehavior: Clip.hardEdge,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(100)),
                  child: Image.network(
                    coin.imageUrl,
                    fit: BoxFit.cover,
                  )),
              const SizedBox(
                width: 12,
              ),
              Text(
                coin.name,
                style: AppTypography.font16w400.copyWith(color: Colors.black),
              ),
              const Spacer(),
              Text(
                walletRepository.obscured ? AppStrings.obscuredText : coin.amount,
                style: AppTypography.font18w700.copyWith(color: Colors.black),
              )
            ],
          ),
        ),
      ),
    );
  }
}
