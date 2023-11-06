import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:izobility_mobile/feature/store/data/store_repository.dart';
import 'package:izobility_mobile/feature/store/ui/pages/promo_screen.dart';
import 'package:izobility_mobile/feature/store/ui/widgets/product_coin_card.dart';
import 'package:izobility_mobile/utils/ui/colors.dart';
import 'package:izobility_mobile/utils/ui/fonts.dart';

class ProductMyCoinQuantity extends StatelessWidget {
  final String imagePath;
  final double quantity;

  const ProductMyCoinQuantity({
    super.key,
    required this.imagePath,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(width: 2, color: Colors.green[100]!))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ProductCoinCard(
            imagePath: imagePath,
            quantity: quantity,
          ),
          (context.read<StoreRepository>().lastOpenedMarketItem.price ?? 0) <=
                  quantity
              ? const Icon(
                  Icons.check,
                  color: AppColors.primary,
                  size: 24,
                )
              : Icon(
                  Icons.block_flipped,
                  color: Colors.red[600],
                  size: 24,
                )
        ],
      ),
    );
  }
}
