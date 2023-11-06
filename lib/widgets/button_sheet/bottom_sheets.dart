import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:izobility_mobile/feature/store/bloc/store_buy/store_buy_cubit.dart';
import 'package:izobility_mobile/feature/store/data/store_repository.dart';
import 'package:izobility_mobile/models/market_item.dart';
import 'package:izobility_mobile/models/store/user_product.dart';
import 'package:izobility_mobile/routes/go_routes.dart';
import 'package:izobility_mobile/utils/ui/colors.dart';
import 'package:izobility_mobile/utils/ui/fonts.dart';
import 'package:izobility_mobile/widgets/button/custom_button.dart';
import 'package:izobility_mobile/widgets/snack_bar/custom_snack_bar.dart';
import 'package:qr_flutter/qr_flutter.dart';

class AppBottomSheets {
  static void buyProductBottomSheet(context, MarketItemModel marketItem) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Container(
            padding: const EdgeInsets.all(16).copyWith(bottom: 0),
            width: double.infinity,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 54,
                  height: 2,
                  color: AppColors.grey200,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(1000),
                      onTap: () => context.pop(),
                      child: SvgPicture.asset(
                        "assets/icons/cross_rounded.svg",
                        color: AppColors.grey200,
                        width: 30,
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(shape: BoxShape.circle),
                        child: Image.network(
                          marketItem.coin.imageUrl,
                          width: 36,
                        )),
                    const SizedBox(width: 5,),
                    Text(
                      "${marketItem.price} ${marketItem.coin.name}",
                      style: AppTypography.font20w700
                          .copyWith(color: Colors.black),
                    )
                  ],
                ),
                const SizedBox(
                  height: 38,
                ),
                CustomButton(
                    text: "Купить",
                    onTap: () {
                      context
                          .read<StoreBuyCubit>()
                          .buyProduct(int.parse(marketItem.id));
                    },
                    width: double.infinity),
                const SizedBox(
                  height: 64,
                ),
              ],
            ),
          );
        });
  }

  static void productBought(context) {
    final marketItem =
        RepositoryProvider.of<StoreRepository>(context).lastOpenedMarketItem;
    final size = MediaQuery.sizeOf(context);

    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Container(
            padding: const EdgeInsets.all(16).copyWith(bottom: 0),
            width: double.infinity,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 54,
                    height: 2,
                    color: AppColors.grey200,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(1000),
                        onTap: () => context.pop(),
                        child: SvgPicture.asset(
                          "assets/icons/cross_rounded.svg",
                          color: AppColors.grey200,
                          width: 30,
                        ),
                      )
                    ],
                  ),
                  Container(
                    width: size.width * 0.66,
                    height: size.width * 0.66,
                    clipBehavior: Clip.hardEdge,
                    constraints: BoxConstraints(maxWidth: 350, maxHeight: 350),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(8)),
                    child: Image.network(
                      marketItem.images[0],
                      fit: BoxFit.cover,
                    ),
                  ),
                  Text(
                    marketItem.name,
                    style:
                        AppTypography.font20w700.copyWith(color: Colors.black),
                  ),
                  const SizedBox(
                    height: 38,
                  ),
                  CustomButton(
                      text: "Активировать",
                      onTap: () {
                        context.go(RouteNames.profile);
                      },
                      width: double.infinity),
                  const SizedBox(
                    height: 8,
                  ),
                  CustomButton(
                      color: AppColors.grey800,
                      text: "Закрыть",
                      onTap: () {
                        context.pop();
                      },
                      width: double.infinity),
                  const SizedBox(
                    height: 64,
                  ),
                ],
              ),
            ),
          );
        });
  }

  static void showProductInfo(context, UserProductModel userProduct) {
    final size = MediaQuery.sizeOf(context);

    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Container(
            padding: const EdgeInsets.all(16).copyWith(bottom: 0),
            width: double.infinity,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 54,
                    height: 2,
                    color: AppColors.grey200,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(1000),
                        onTap: () => context.pop(),
                        child: SvgPicture.asset(
                          "assets/icons/cross_rounded.svg",
                          color: AppColors.grey200,
                          width: 30,
                        ),
                      )
                    ],
                  ),
                  Container(
                    constraints: BoxConstraints(maxWidth: 200, maxHeight: 200),
                    child: QrImageView(
                      data: "${userProduct.id}-${userProduct.token}",
                      version: QrVersions.auto,
                      size: size.width * 0.66,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(width: 2, color: Colors.black)),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Ваш код',
                              style: AppTypography.font12w400
                                  .copyWith(color: AppColors.grey500),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              "${userProduct.id}-${userProduct.token}",
                              style: AppTypography.font16w400
                                  .copyWith(color: Colors.black),
                            ),
                          ],
                        ),
                        InkWell(
                            onTap: () {
                              Clipboard.setData(ClipboardData(
                                  text:
                                      "${userProduct.id}-${userProduct.token}"));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(CustomSnackBar.snackBarCopied);
                            },
                            child: SvgPicture.asset(
                              "assets/icons/copy.svg",
                              color: AppColors.grey500,
                            ))
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  CustomButton(
                      color: AppColors.grey800,
                      text: "Закрыть",
                      onTap: () {
                        context.pop();
                      },
                      width: double.infinity),
                  const SizedBox(
                    height: 64,
                  ),
                ],
              ),
            ),
          );
        });
  }
}
