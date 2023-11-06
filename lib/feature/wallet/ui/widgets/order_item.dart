import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:izobility_mobile/feature/wallet/data/wallet_repository.dart';
import 'package:izobility_mobile/models/burse/burse_order.dart';
import 'package:izobility_mobile/utils/logic/constants.dart';
import 'package:izobility_mobile/utils/logic/enums.dart';
import 'package:izobility_mobile/utils/ui/colors.dart';
import 'package:izobility_mobile/utils/ui/fonts.dart';
import 'package:izobility_mobile/utils/ui/gradients.dart';

class OrderItem extends StatelessWidget {
  final VoidCallback onTap;
  final BurseOrderModel order;
  final BurseOrderType type;

  const OrderItem({super.key, required this.order, required this.onTap, required this.type});

  @override
  Widget build(BuildContext context) {
    final walletRepository = RepositoryProvider.of<WalletRepository>(context);

    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Ink(
          width: double.infinity,
          height: 64,
          decoration: ShapeDecoration(
              color: AppColors.textContrast,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              )),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 17),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: (MediaQuery.sizeOf(context).width - 116) / 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            color: AppColors.backgroundSecondary,
                            borderRadius: BorderRadius.circular(32),
                            image: DecorationImage(
                                image: NetworkImage(order.coinFrom.logo),
                                fit: BoxFit.cover)),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                  width: ((MediaQuery.sizeOf(context).width -
                                                  136) /
                                              2 -
                                          37) /
                                      2,
                                  child: Text(
                                    walletRepository.obscured
                                        ? AppStrings.obscuredText
                                        : order.amountFrom,
                                    maxLines: 1,
                                    overflow: TextOverflow.clip,
                                    style: AppTypography.font16w400.copyWith(
                                      color: AppColors.textPrimary,
                                    ),
                                  )),
                              const SizedBox(
                                width: 3,
                              ),
                              SizedBox(
                                width:
                                    ((MediaQuery.sizeOf(context).width - 136) /
                                                2 -
                                            37) /
                                        2,
                                child: Text(
                                  order.coinFrom.codename,
                                  maxLines: 1,
                                  overflow: TextOverflow.clip,
                                  style: AppTypography.font16w400
                                      .copyWith(color: AppColors.textPrimary),
                                ),
                              ),
                            ],
                          ),
                          Text('Отправить',
                              style: AppTypography.font16w400.copyWith(
                                  color: AppColors.disabledTextButton))
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                    padding: const EdgeInsets.all(3),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, gradient: AppGradients.gradientGreenWhite),
                    child: SvgPicture.asset(
                      type == BurseOrderType.general ? 'assets/icons/transfer_arrows.svg' : order.closedAt != null ? "assets/icons/completed.svg" : "assets/icons/clock.svg",
                      color: Colors.black,
                      width: 21,
                    )),
                SizedBox(
                  width: (MediaQuery.sizeOf(context).width - 116) / 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            color: AppColors.backgroundSecondary,
                            borderRadius: BorderRadius.circular(32),
                            image: DecorationImage(
                                image: NetworkImage(order.coinTo.logo),
                                fit: BoxFit.cover)),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width:
                                    ((MediaQuery.sizeOf(context).width - 136) /
                                                2 -
                                            37) /
                                        2,
                                child: Text(
                                  walletRepository.obscured
                                      ? AppStrings.obscuredText
                                      : order.amountTo,
                                  overflow: TextOverflow.clip,
                                  maxLines: 1,
                                  style: AppTypography.font16w400.copyWith(
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              SizedBox(
                                width:
                                    ((MediaQuery.sizeOf(context).width - 136) /
                                                2 -
                                            37) /
                                        2,
                                child: Text(
                                  order.coinTo.codename,
                                  maxLines: 1,
                                  overflow: TextOverflow.clip,
                                  style: AppTypography.font16w400
                                      .copyWith(color: AppColors.textPrimary),
                                ),
                              ),
                            ],
                          ),
                          Text('Получить',
                              style: AppTypography.font14w400.copyWith(
                                  color: AppColors.disabledTextButton))
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
