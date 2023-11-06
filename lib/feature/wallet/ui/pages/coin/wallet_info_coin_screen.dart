import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:izobility_mobile/feature/wallet/data/wallet_repository.dart';
import 'package:izobility_mobile/localization/app_localizations.dart';
import 'package:izobility_mobile/models/api/token_data.dart';
import 'package:izobility_mobile/utils/logic/constants.dart';
import 'package:izobility_mobile/widgets/app_bar/custom_sliver_app_bar.dart';
import 'package:izobility_mobile/widgets/app_bar/custom_sliver_app_bar_delegate.dart';
import 'package:izobility_mobile/utils/ui/colors.dart';
import 'package:izobility_mobile/utils/ui/fonts.dart';

final list = List.generate(100, (index) => 1);

class InfoCurrencyWalletScreen extends StatefulWidget {
  const InfoCurrencyWalletScreen({super.key, required this.token});

  final TokenData token;

  @override
  State<InfoCurrencyWalletScreen> createState() =>
      _InfoCurrencyWalletScreenState();
}

class _InfoCurrencyWalletScreenState extends State<InfoCurrencyWalletScreen> {
  @override
  Widget build(BuildContext context) {
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
                floating: false,
                delegate: SliverAppBarDelegate(
                  minHeight: 17,
                  maxHeight: 17,
                  child: Container(
                    height: 18,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(16))),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
