import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:izobility_mobile/feature/store/data/store_repository.dart';
import 'package:izobility_mobile/feature/wallet/bloc/coins_in_game/coins_in_game_cubit.dart';
import 'package:izobility_mobile/feature/wallet/data/wallet_repository.dart';
import 'package:izobility_mobile/localization/app_localizations.dart';
import 'package:izobility_mobile/models/market_item.dart';
import 'package:izobility_mobile/routes/go_routes.dart';
import 'package:izobility_mobile/widgets/button/custom_button.dart';
import 'package:izobility_mobile/widgets/button_sheet/bottom_sheets.dart';

import '../../models/api/coin_data.dart';
import '../../utils/ui/colors.dart';
import '../../utils/ui/fonts.dart';

class MarketItem extends StatelessWidget {
  final MarketItemModel marketItem;

  const MarketItem({super.key, required this.marketItem});

  @override
  Widget build(BuildContext context) {
    final localize = AppLocalizations.of(context)!;

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        context.push("/store/${marketItem.id}");
      },
      child: Container(
        width: (MediaQuery.of(context).size.width - 40) / 2,
        padding: const EdgeInsets.all(6),
        decoration: ShapeDecoration(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: (MediaQuery.of(context).size.width - 40) / 2,
              height: (MediaQuery.of(context).size.width - 40) / 2,
              decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  color: Colors.grey[300],
                  image: DecorationImage(
                      image: NetworkImage(marketItem.images[0]),
                      fit: BoxFit.cover)),
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              children: [
                Image.network(
                  marketItem.coin.imageUrl,
                  width: 16,
                ),
                const SizedBox(
                  width: 3,
                ),
                Text(
                  marketItem.price.toString(),
                  style: AppTypography.font14w700.copyWith(color: Colors.black),
                ),
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              marketItem.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.font12w400
                  .copyWith(color: AppColors.textPrimary),
            ),
            const SizedBox(
              height: 5,
            ),
            BlocBuilder<CoinsInGameCubit, CoinsInGameState>(
              builder: (context, state) {
                if (state is CoinsInGameSuccess) {
                  final double quantity = double.parse(context
                      .read<WalletRepository>()
                      .coinsInGame
                      .where((element) => element.id == marketItem.coin.id)
                      .toList()[0]
                      .amount);

                  return CustomButton(
                    isActive: marketItem.price <= quantity,
                    fontSize: 14,
                    height: 28,
                    text: "Купить",
                    onTap: () {
                      context.read<StoreRepository>().lastOpenedMarketItem =
                          marketItem;
                      AppBottomSheets.buyProductBottomSheet(
                          context, marketItem);
                    },
                    width: 90,
                    radius: 16,
                  );
                }

                return CustomButton(
                  isActive: false,
                  fontSize: 14,
                  height: 28,
                  text: "Купить",
                  onTap: () {
                    context.read<StoreRepository>().lastOpenedMarketItem =
                        marketItem;
                    AppBottomSheets.buyProductBottomSheet(context, marketItem);
                  },
                  width: 90,
                  radius: 16,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
