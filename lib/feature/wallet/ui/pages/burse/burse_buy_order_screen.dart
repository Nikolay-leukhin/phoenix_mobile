import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:izobility_mobile/feature/wallet/bloc/burse_buy_order/burse_buy_order_cubit.dart';
import 'package:izobility_mobile/feature/wallet/data/wallet_repository.dart';
import 'package:izobility_mobile/models/api/burse_transfer.dart';
import 'package:izobility_mobile/models/burse/burse_order.dart';
import 'package:izobility_mobile/routes/go_routes.dart';
import 'package:izobility_mobile/utils/logic/constants.dart';
import 'package:izobility_mobile/utils/logic/enums.dart';
import 'package:izobility_mobile/utils/ui/colors.dart';
import 'package:izobility_mobile/utils/ui/dialogs.dart';
import 'package:izobility_mobile/utils/ui/fonts.dart';
import 'package:izobility_mobile/widgets/app_bar/custom_app_bar.dart';
import 'package:izobility_mobile/widgets/button/custom_button.dart';
import 'package:izobility_mobile/widgets/snack_bar/custom_snack_bar.dart';

class BurseBuyOrderScreen extends StatefulWidget {
  const BurseBuyOrderScreen({super.key, required this.order});

  final BurseOrderModel order;

  @override
  State<BurseBuyOrderScreen> createState() => _BurseBuyOrderScreenState();
}

class _BurseBuyOrderScreenState extends State<BurseBuyOrderScreen> {
  @override
  Widget build(BuildContext context) {
    final walletRepository = RepositoryProvider.of<WalletRepository>(context);

    return Container(
      color: Colors.white,
      child: Scaffold(
        backgroundColor: AppColors.backgroundGrey,
        appBar: CustomAppBar(
          context: context,
          text: "Покупка заказа",
          isBack: true,
          onTap: () {
            context.pop();
          },
        ),
        body: BlocListener<BurseBuyOrderCubit, BurseBuyOrderState>(
          listener: (context, state) {
            ScaffoldMessenger.of(context).clearSnackBars();

            if (state is BurseBuyOrderSuccess) {
              context.pop();

               ScaffoldMessenger.of(context).showSnackBar(
                  CustomSnackBar.successSnackBar('Успешно'));
            } else if (state is BurseBuyOrderFailure) {
              context.pop();

              ScaffoldMessenger.of(context).showSnackBar(
                  CustomSnackBar.errorSnackBar('Ошибка'));
            } else if (state is BurseBuyOrderLoading) {
              Dialogs.show(
                  context,
                  const Center(
                    child: CircularProgressIndicator.adaptive(),
                  ));
            }
          },
          child: Container(
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.white,
                      ),
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 14),
                      child: Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Отправить',
                                style: AppTypography.font14w400
                                    .copyWith(color: AppColors.grey600),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.network(
                                    widget.order.coinFrom.logo,
                                    width: 24,
                                    height: 24,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    widget.order.coinFrom.name,
                                    style: AppTypography.font18w700
                                        .copyWith(color: AppColors.textPrimary),
                                  ),
                                  Spacer(),
                                  Text(widget.order.amountFrom.toString(),
                                      style: AppTypography.font18w700.copyWith(
                                        color: AppColors.textPrimary,
                                      ))
                                ],
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const Divider(
                            height: 2,
                            color: AppColors.purpleBcg,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Получить',
                                style: AppTypography.font14w400
                                    .copyWith(color: AppColors.grey600),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.network(
                                    widget.order.coinTo.logo,
                                    width: 24,
                                    height: 24,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    widget.order.coinTo.name,
                                    style: AppTypography.font18w700
                                        .copyWith(color: AppColors.textPrimary),
                                  ),
                                  Spacer(),
                                  Text(widget.order.amountTo.toString(),
                                      style: AppTypography.font18w700.copyWith(
                                        color: AppColors.textPrimary,
                                      ))
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          "Комиссия площадки: 1.0 EMRLD",
                          style: AppTypography.font12w400
                              .copyWith(color: AppColors.grey500),
                        )),
                  ],
                ),
                Column(
                  children: [
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          "Размещено: ${widget.order.createdAt.year}.${widget.order.createdAt.month}.${widget.order.createdAt.day} ${widget.order.createdAt.hour}:${widget.order.createdAt.minute}",
                          style: AppTypography.font12w400
                              .copyWith(color: AppColors.grey500),
                        )),
                    const SizedBox(
                      height: 4,
                    ),
                    CustomButton(
                        text: "Купить",
                        onTap: () {
                          context
                              .read<BurseBuyOrderCubit>()
                              .buyOrder(int.parse(widget.order.id));
                        },
                        width: double.infinity)
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
