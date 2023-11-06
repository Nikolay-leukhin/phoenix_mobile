import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:izobility_mobile/feature/wallet/data/wallet_repository.dart';
import 'package:izobility_mobile/utils/logic/constants.dart';
import 'package:izobility_mobile/utils/ui/colors.dart';
import 'package:izobility_mobile/utils/ui/fonts.dart';
import 'package:izobility_mobile/widgets/app_bar/custom_sliver_app_bar.dart';
import 'package:izobility_mobile/widgets/app_bar/custom_sliver_app_bar_delegate.dart';
import 'package:izobility_mobile/widgets/button/custom_button.dart';
import 'package:izobility_mobile/widgets/text_field/custom_text_field.dart';

class BuyCurrencyScreen extends StatefulWidget {
  const BuyCurrencyScreen({super.key});

  @override
  State<BuyCurrencyScreen> createState() => _BuyCurrencyScreenState();
}

class _BuyCurrencyScreenState extends State<BuyCurrencyScreen> {
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final walletRepository = context.read<WalletRepository>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        color: AppColors.purple200,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: AppColors.purpleBcg,
            body: CustomScrollView(
              physics: const BouncingScrollPhysics(
                  decelerationRate: ScrollDecelerationRate.fast),
              slivers: [
                const CustomSliverAppBar(
                  height: 90,
                  isBack: true,
                  title: 'Usd',
                  color: AppColors.purple200,
                ),
                SliverPersistentHeader(
                  pinned: true,
                  floating: false,
                  delegate: SliverAppBarDelegate(
                    minHeight: 100,
                    maxHeight: 100,
                    child: Container(
                      color: AppColors.purple200,
                      alignment: Alignment.center,
                      child: Column(children: [
                        const CircleAvatar(
                          radius: 20,
                          backgroundColor: AppColors.primary,
                        ),
                        Text(
                            walletRepository.obscured
                                ? AppStrings.obscuredText
                                : '123 123\$',
                            style: AppTypography.font36w700
                                .copyWith(color: AppColors.textPrimary)),
                      ]),
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
                          color: AppColors.purple200,
                          borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(16))),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 17, right: 17, top: 20),
                    child: CustomTextField.withTwoIcon(
                      error: false,
                      errorText: 'Ошибка',
                      labelText: 'Ваша сумма в \$',
                      suffixIconCallback: () {},
                      secondSuffixIconCallback: () {},
                      controller: amountController,
                      width: double.infinity,
                      backgroundColor: Colors.white,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 17, right: 17, top: 20),
                    child: CustomButton(
                      text: 'Подтвердить',
                      onTap: () {},
                      width: double.infinity,
                    ),
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
