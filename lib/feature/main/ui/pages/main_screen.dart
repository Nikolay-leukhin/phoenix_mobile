import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:phoenix_mobile/feature/main/bloc/main/main_screen_cubit.dart';
import 'package:phoenix_mobile/feature/main/data/main_repository.dart';
import 'package:phoenix_mobile/feature/main/ui/widgets/guides_suggestion_loading.dart';
import 'package:phoenix_mobile/feature/main/ui/widgets/market_item.dart';
import 'package:phoenix_mobile/feature/store/bloc/store_buy/store_buy_cubit.dart';
import 'package:phoenix_mobile/feature/wallet/bloc/coin_in_game/coin_in_game_cubit.dart';
import 'package:phoenix_mobile/feature/wallet/bloc/promo_code/promo_code_cubit.dart';
import 'package:phoenix_mobile/feature/wallet/data/wallet_repository.dart';
import 'package:phoenix_mobile/localization/app_localizations.dart';
import 'package:phoenix_mobile/routes/go_routes.dart';
import 'package:phoenix_mobile/utils/ui/animations.dart';
import 'package:phoenix_mobile/utils/ui/dialogs.dart';
import 'package:phoenix_mobile/utils/utils.dart';
import 'package:phoenix_mobile/widgets/banners/game_banner.dart';
import 'package:phoenix_mobile/widgets/banners/improve_city.dart';
import 'package:phoenix_mobile/widgets/button/custom_button.dart';
import 'package:phoenix_mobile/widgets/button_sheet/bottom_sheets.dart';
import 'package:phoenix_mobile/widgets/containers/cash_container.dart';
import 'package:phoenix_mobile/widgets/indicators/notifications_indicator.dart';
import 'package:phoenix_mobile/widgets/popup/popup_promo_failure.dart';
import 'package:phoenix_mobile/widgets/popup/popup_promo_success.dart';
import 'package:phoenix_mobile/widgets/snack_bar/custom_snack_bar.dart';
import 'package:phoenix_mobile/widgets/text_field/custom_text_field.dart';

import '../../../../widgets/containers/guides_suggestion.dart';
import '../../../../widgets/containers/market_Item.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final TextEditingController codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final localize = AppLocalizations.of(context)!;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: BlocListener<StoreBuyCubit, StoreBuyState>(
        listener: (context, state) {
          ScaffoldMessenger.of(context).clearSnackBars();

          if (state is StoreBuyLoading) {
            showDialog(
                context: context,
                builder: (context) => const Center(
                      child: CircularProgressIndicator.adaptive(),
                    ));
          } else if (state is StoreBuyFailure) {
            context.pop();

            ScaffoldMessenger.of(context)
                .showSnackBar(CustomSnackBar.successSnackBar('Ошибка'));
          } else if (state is StoreBuySuccess) {
            print('------ popped');
            context.pop(); // clear dialog
            context.pop(); // clear modal

            AppBottomSheets.productBought(context);
          }
        },
        child: Scaffold(
            backgroundColor: AppColors.purpleBcg,
            appBar: AppBar(
              surfaceTintColor: Colors.transparent,
              title: Row(
                children: [
                  Image.asset(
                    'assets/images/mini_logo.png',
                    width: MediaQuery.sizeOf(context).width / 3.6,
                    fit: BoxFit.fitWidth,
                  ),
                  const Spacer(),
                  BlocBuilder<CoinInGameCubit, CoinInGameState>(
                    builder: (context, state) {
                      if (state is CoinInGameSuccess) {
                        return CashContainer(
                          text: RepositoryProvider.of<WalletRepository>(context)
                              .emeraldInGameBalance
                              .toString(),
                        );
                      }

                      return const CashContainer(
                        text: '0',
                      );
                    },
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  const NotificationsIndicator()
                ],
              ),
            ),
            body: BlocBuilder<MainScreenCubit, MainScreenState>(
              builder: (context, state) {
                final repository =
                    RepositoryProvider.of<MainScreenRepository>(context);
                return SafeArea(
                  child: Padding(
                    padding:
                        const EdgeInsets.all(16).copyWith(bottom: 0, top: 0),
                    child: RefreshIndicator(
                      onRefresh: () async {
                        await repository.getPreview();
                      },
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 16,
                              ),
                              const ImproveCityBanner(),
                              BlocListener<PromoCodeCubit, PromoCodeState>(
                                listener: (context, state) {
                                  if (state is PromoActivateProcessState) {
                                    Dialogs.showModal(
                                        context,
                                        const Center(
                                          child: AppAnimations
                                              .circularProgressIndicator,
                                        ));
                                  } else {
                                    Dialogs.hide(context);
                                  }

                                  if (state is PromoActivatedState) {
                                    showDialog(
                                        context: context,
                                        builder: (context) => PopupPromoSuccess(
                                              coinName: state.coinName,
                                              coinAmount: state.coinAmount,
                                            ));
                                  }
                                  if (state is PromoInvalidState) {
                                    showDialog(
                                        context: context,
                                        builder: (context) =>
                                            const PopupPromoFailure());
                                  }
                                },
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16),
                                    child: CustomTextField.withTwoIcon(
                                      suffixIconCallback: () {
                                        context.push(RouteNames.mainQr, extra: {
                                          "onFound": (data) => context
                                              .read<PromoCodeCubit>()
                                              .activateCode(
                                                  data.code.toString())
                                        });
                                      },
                                      secondSuffixIconCallback: () {
                                        Clipboard.getData('text/plain')
                                            .then((value) {
                                          setState(() {
                                            codeController.text = value != null
                                                ? value.text ??
                                                    codeController.text
                                                : codeController.text;
                                          });

                                          FocusScope.of(context).unfocus();
                                        });
                                      },
                                      obscured: false,
                                      controller: codeController,
                                      width: double.infinity,
                                      backgroundColor: Colors.white,
                                      hintText: localize.your_promo,
                                      onChange: (v) {
                                        setState(() {});
                                      },
                                    )),
                              ),
                              if (codeController.text.isNotEmpty) ...[
                                CustomButton(
                                    text: localize.activate,
                                    onTap: () {
                                      BlocProvider.of<PromoCodeCubit>(context)
                                          .activateCode(
                                              codeController.text.trim());
                                      setState(() {
                                        codeController.text = '';
                                      });
                                    },
                                    width: double.infinity),
                                const SizedBox(
                                  height: 16,
                                )
                              ],
                              GameBanner(
                                onClick: () {
                                  context.go(RouteNames.games);
                                },
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              const Divider(
                                color: AppColors.disableButton,
                                height: 1,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                child: SizedBox(
                                  width: MediaQuery.sizeOf(context).width - 32,
                                  height: 102,
                                  child: state is MainScreenPreview
                                      ? ListView.builder(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 2),
                                          scrollDirection: Axis.horizontal,
                                          shrinkWrap: true,
                                          itemCount:
                                              repository.storiesList.length,
                                          itemBuilder: (ctx, ind) =>
                                              GuidesSuggestion(
                                                text: repository
                                                    .storiesList[ind].title,
                                                imageUrl: repository
                                                    .storiesList[ind]
                                                    .previewUrl,
                                                onTap: () {
                                                  context.go(
                                                      '${RouteNames.story}/$ind');
                                                },
                                                viewed: false,
                                              ))
                                      : ListView.builder(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 2),
                                          scrollDirection: Axis.horizontal,
                                          shrinkWrap: true,
                                          itemCount: 4,
                                          itemBuilder: (ctx, ind) =>
                                              const GuidesSuggestionLoading()),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    localize.shop,
                                    style: AppTypography.font24w700
                                        .copyWith(color: Colors.black),
                                  ),
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () {
                                      context.go(RouteNames.basket);
                                    },
                                    child: Ink(
                                      padding: const EdgeInsets.only(
                                          left: 18, top: 6, bottom: 6),
                                      child: Text(
                                        'Ещё',
                                        style: AppTypography.font12w400
                                            .copyWith(color: AppColors.disable),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              SizedBox(
                                width: MediaQuery.sizeOf(context).width - 32,
                                height:
                                    (MediaQuery.of(context).size.width - 40) /
                                            2 *
                                            240 /
                                            160 +
                                        10,
                                child: state is MainScreenPreview
                                    ? ListView.builder(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 2),
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        itemCount:
                                            repository.marketItems.length,
                                        itemBuilder: (ctx, ind) => MarketItem(
                                              marketItem:
                                                  repository.marketItems[ind],
                                            ))
                                    : ListView.builder(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 2),
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        itemCount:
                                            repository.marketItems.length,
                                        itemBuilder: (ctx, ind) =>
                                            const MarketItemLoading()),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                            ]),
                      ),
                    ),
                  ),
                );
              },
            )),
      ),
    );
  }
}
