import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:izobility_mobile/feature/wallet/data/wallet_repository.dart';
import 'package:izobility_mobile/feature/wallet/ui/widgets/order_item.dart';
import 'package:izobility_mobile/utils/logic/constants.dart';
import 'package:izobility_mobile/utils/logic/enums.dart';
import 'package:izobility_mobile/utils/ui/colors.dart';
import 'package:izobility_mobile/widgets/app_bar/custom_app_bar.dart';
import 'package:sliver_tools/sliver_tools.dart';

class BurseHistoryScreen extends StatefulWidget {
  const BurseHistoryScreen({super.key});

  @override
  State<BurseHistoryScreen> createState() => _BurseHistoryScreenState();
}

class _BurseHistoryScreenState extends State<BurseHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    final walletRepository = RepositoryProvider.of<WalletRepository>(context);

    return Scaffold(
        backgroundColor: AppColors.purpleBcg,
        appBar: CustomAppBar(
          context: context,
          text: "Покупка заказа",
          isBack: true,
          onTap: () {
            context.pop();
          },
        ),
        body: CustomScrollView(
            physics: const BouncingScrollPhysics(
                decelerationRate: ScrollDecelerationRate.fast),
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: MultiSliver(
                    children: List.generate(
                  9,
                  (index) => MultiSliver(
                    pushPinnedChildren: true,
                    children: [
                      SliverPinnedHeader(
                          child: Container(
                        padding: const EdgeInsets.all(5),
                        color: AppColors.purpleBcg,
                        child: Text(
                          "${DateTime.now().day} ${AppStrings.months[(DateTime.now().month - index).toString()]}",
                          textAlign: TextAlign.center,
                        ),
                      )),
                      SliverToBoxAdapter(
                        child: Column(
                          children: walletRepository.ordersGeneralList
                              .map((currentOrder) => Padding(
                                    padding: const EdgeInsets.only(bottom: 4),
                                    child: OrderItem(
                                      type: BurseOrderType.general,
                                      order: currentOrder,
                                      onTap: () {},
                                    ),
                                  ))
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                )),
              )
            ]));
  }
}
