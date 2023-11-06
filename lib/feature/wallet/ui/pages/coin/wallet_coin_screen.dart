import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:izobility_mobile/feature/profile/bloc/profile_links/profile_links_cubit.dart';
import 'package:izobility_mobile/feature/wallet/data/wallet_repository.dart';
import 'package:izobility_mobile/feature/wallet/ui/widgets/button_social_media_link.dart';
import 'package:izobility_mobile/feature/wallet/ui/widgets/transaction_container.dart';
import 'package:izobility_mobile/localization/app_localizations.dart';
import 'package:izobility_mobile/models/api/token_data.dart';
import 'package:izobility_mobile/routes/go_routes.dart';
import 'package:izobility_mobile/utils/logic/constants.dart';
import 'package:izobility_mobile/widgets/app_bar/custom_sliver_app_bar.dart';
import 'package:izobility_mobile/widgets/app_bar/custom_sliver_app_bar_delegate.dart';
import 'package:izobility_mobile/feature/wallet/ui/widgets/wallet_action.dart';
import 'package:izobility_mobile/utils/ui/colors.dart';
import 'package:izobility_mobile/utils/ui/fonts.dart';

class CurrencyWalletScreen extends StatefulWidget {
  const CurrencyWalletScreen(
      {super.key, required this.token, required this.inGameOrOrChain});

  final TokenData token;
  final bool inGameOrOrChain;

  @override
  State<CurrencyWalletScreen> createState() => _CurrencyWalletScreenState();
}

class _CurrencyWalletScreenState extends State<CurrencyWalletScreen> {
  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);

    final walletRepository = context.read<WalletRepository>();

    final localize = AppLocalizations.of(context)!;

    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.purpleBcg,
          body: CustomScrollView(
            physics: const BouncingScrollPhysics(
                decelerationRate: ScrollDecelerationRate.fast),
            slivers: [
              CustomSliverAppBar(
                height: 90,
                isBack: true,
                title: widget.token.name,
                color: Colors.white,
                onTapRightIcon: () {
                  context.push(RouteNames.walletInfoCurrency,
                      extra: widget.token);
                },
              ),
              SliverPersistentHeader(
                pinned: true,
                floating: false,
                delegate: SliverAppBarDelegate(
                  minHeight: 115,
                  maxHeight: 115,
                  child: Container(
                    color: Colors.white,
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                image: DecorationImage(
                                    image:
                                        NetworkImage(widget.token.imageUrl))),
                          ),
                        ),
                        Text(
                            walletRepository.obscured
                                ? AppStrings.obscuredText
                                : widget.token.amount,
                            style: AppTypography.font36w700
                                .copyWith(color: AppColors.textPrimary)),
                        Text(
                          walletRepository.obscured
                              ? AppStrings.obscuredText
                              : '≈ ${widget.token.rubleExchangeRate} ₽',
                          style: AppTypography.font16w400
                              .copyWith(color: AppColors.grey600),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverPersistentHeader(
                pinned: true,
                floating: true,
                delegate: SliverAppBarDelegate(
                  minHeight: sizeOf.width * 0.156 + 40,
                  maxHeight: sizeOf.width * 0.156 + 40,
                  child: Container(
                    color: Colors.white,
                    alignment: Alignment.center,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 16, right: 16, top: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          WalletAction(
                            title: localize.send,
                            icon: 'assets/icons/send.svg',
                            onTap: () {
                              context.push(
                                  widget.inGameOrOrChain
                                      ? RouteNames.walletSendInGameCoin
                                      : RouteNames.walletSendOnChainCoin,
                                  extra: widget.token);
                            },
                          ),
                          !widget.inGameOrOrChain
                              ? WalletAction(
                                  title: localize.replenish,
                                  icon: 'assets/icons/get.svg',
                                  onTap: () {
                                    context.push(RouteNames.walletReplenish);
                                  },
                                )
                              : Container(),
                          WalletAction(
                            title: localize.swap,
                            icon: 'assets/icons/swap.svg',
                            onTap: () {
                              context.push(RouteNames.walletSwap);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SliverPersistentHeader(
                pinned: true,
                floating: false,
                delegate: SliverAppBarDelegate(
                  minHeight: 17,
                  maxHeight: 17,
                  child: Container(
                    height: 18,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.vertical(bottom: Radius.circular(16))),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        localize.description,
                        style: AppTypography.font16w400
                            .copyWith(color: AppColors.grey600),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.token.description,
                        style: AppTypography.font14w400
                            .copyWith(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverToBoxAdapter(
                  child: Container(
                    color: AppColors.purpleBcg,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          localize.contract,
                          style: AppTypography.font16w400
                              .copyWith(color: AppColors.grey600),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Wrap(
                          direction: Axis.horizontal,
                          alignment: WrapAlignment.spaceBetween,
                          runAlignment: WrapAlignment.start,
                          runSpacing: 10,
                          children: [
                            ButtonSocialMediaLink(
                              text: "Сайт",
                              onTap: () {
                                context
                                    .read<ProfileLinksCubit>()
                                    .loadLink(widget.token.url);
                              },
                            ),
                            ButtonSocialMediaLink(
                              text: "BSC scan",
                              onTap: () {},
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
