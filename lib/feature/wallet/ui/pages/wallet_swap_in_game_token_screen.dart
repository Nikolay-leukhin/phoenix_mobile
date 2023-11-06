import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:izobility_mobile/feature/wallet/bloc/swap_in_game_coins/swap_in_game_coins_cubit.dart';
import 'package:izobility_mobile/feature/wallet/data/wallet_repository.dart';
import 'package:izobility_mobile/feature/wallet/ui/widgets/button_choose_coin.dart';
import 'package:izobility_mobile/feature/wallet/ui/widgets/button_swop.dart';
import 'package:izobility_mobile/routes/go_routes.dart';
import 'package:izobility_mobile/utils/logic/constants.dart';
import 'package:izobility_mobile/utils/ui/colors.dart';
import 'package:izobility_mobile/utils/ui/dialogs.dart';
import 'package:izobility_mobile/utils/ui/fonts.dart';
import 'package:izobility_mobile/widgets/app_bar/custom_app_bar.dart';
import 'package:izobility_mobile/widgets/button/custom_button.dart';
import 'package:izobility_mobile/widgets/scaffold/home_scaffold.dart';
import 'package:izobility_mobile/widgets/snack_bar/custom_snack_bar.dart';
import 'package:izobility_mobile/widgets/text_field/custom_text_field.dart';

class SwapScreen extends StatefulWidget {
  const SwapScreen({super.key});

  @override
  State<SwapScreen> createState() => _SwapScreenState();
}

class _SwapScreenState extends State<SwapScreen> {
  final _enterAmountCoinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);

    final walletRepository = RepositoryProvider.of<WalletRepository>(context);
    final swapInGameCoinsCubit = BlocProvider.of<SwapInGameCoinsCubit>(context);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: BlocListener<SwapInGameCoinsCubit, SwapInGameCoinsState>(
        listener: (context, state) {
          ScaffoldMessenger.of(context).clearSnackBars();

          if (state is SwapInGameCoinsFail) {
            context.pop();

            ScaffoldMessenger.of(context)
                .showSnackBar(CustomSnackBar.errorSnackBar('ошибка перевода'));
          } else if (state is SwapInGameCoinsLoading) {
            Dialogs.show(
                context,
                const Center(
                  child: CircularProgressIndicator.adaptive(),
                ));
          } else if (state is SwapInGameCoinsSuccess) {
            context.pop();

            ScaffoldMessenger.of(context).showSnackBar(
                CustomSnackBar.successSnackBar('Успешно отправлено'));
          }
        },
        child: HomeScaffold(
          appBar: CustomAppBar(
            context: context,
            text: "Своп",
            isBack: true,
            onTap: () {
              context.pop();
            },
          ),
          body: Container(
            color: AppColors.purpleBcg,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.white,
                      ),
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              context.push(RouteNames.walletChooseCoin, extra: {
                                'path': AppStrings.nullText,
                                'fromOrTo': true
                              }).then((value) => setState(() {}));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Из',
                                      style: AppTypography.font14w400
                                          .copyWith(color: AppColors.grey600),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Image.network(
                                          walletRepository
                                              .activeSwapTockenFrom!.imageUrl,
                                          width: 24,
                                          height: 24,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          walletRepository
                                              .activeSwapTockenFrom!.name,
                                          style: AppTypography.font18w700
                                              .copyWith(
                                                  color: AppColors.textPrimary),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: Icon(Icons.arrow_forward_ios),
                                )
                              ],
                            ),
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
                          InkWell(
                            onTap: () {
                              context.push(RouteNames.walletChooseCoin, extra: {
                                'path': AppStrings.nullText,
                                'fromOrTo': false
                              }).then((value) => setState(() {}));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'В',
                                      style: AppTypography.font14w400
                                          .copyWith(color: AppColors.grey600),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Image.network(
                                          walletRepository
                                              .activeSwapTockenTo!.imageUrl,
                                          width: 24,
                                          height: 24,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          walletRepository
                                              .activeSwapTockenTo!.name,
                                          style: AppTypography.font18w700
                                              .copyWith(
                                                  color: AppColors.textPrimary),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: Icon(Icons.arrow_forward_ios),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    CustomTextField(
                      controller: _enterAmountCoinController,
                      width: double.infinity,
                      hintText: 'Количество',
                      backgroundColor: Colors.white,
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),
                CustomButton(
                    text: 'Подтвердить',
                    onTap: () {
                      swapInGameCoinsCubit.swapInGameCoins(
                          int.parse(_enterAmountCoinController.text),
                          int.parse(walletRepository.activeSwapTockenTo!.id),
                          int.parse(walletRepository.activeSwapTockenFrom!.id));
                    },
                    width: double.infinity)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
