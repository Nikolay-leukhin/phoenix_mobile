import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:izobility_mobile/feature/wallet/bloc/burse_general_orders/burse_general_orders_cubit.dart';
import 'package:izobility_mobile/feature/wallet/bloc/burse_my_orders/burse_my_orders_cubit.dart';
import 'package:izobility_mobile/feature/wallet/data/wallet_repository.dart';
import 'package:izobility_mobile/feature/wallet/ui/widgets/order_item.dart';
import 'package:izobility_mobile/routes/go_routes.dart';
import 'package:izobility_mobile/utils/logic/constants.dart';
import 'package:izobility_mobile/utils/logic/enums.dart';
import 'package:izobility_mobile/utils/ui/colors.dart';
import 'package:izobility_mobile/utils/ui/fonts.dart';
import 'package:izobility_mobile/widgets/app_bar/custom_app_bar.dart';
import 'package:izobility_mobile/widgets/app_bar/custom_sliver_app_bar_delegate.dart';
import 'package:izobility_mobile/widgets/button/custom_button.dart';

class BurseScreen extends StatefulWidget {
  const BurseScreen({super.key});

  @override
  State<BurseScreen> createState() => _BurseScreenState();
}

class _BurseScreenState extends State<BurseScreen>
    with SingleTickerProviderStateMixin {
  int isBurseOrMyOrder = 0;

  late TabController _tabController;
  late ScrollController scrollController = ScrollController();

  @override
  void initState() {
    final walletRepository = context.read<WalletRepository>();

    walletRepository.getBurseGeneralItemList(
        50, walletRepository.burseGeneralCurrentPageIndex);

    walletRepository.getBurseMyItemList(
        50, walletRepository.burseMyCurrentPageIndex);

    scrollController.addListener(() async {
      if (scrollController.position.atEdge) {
        double maxScroll = scrollController.position.maxScrollExtent;
        double currentScroll = scrollController.position.pixels;

        if (isBurseOrMyOrder == 0) {
          if (currentScroll >= maxScroll * 0.96 || currentScroll == 0) {
            print("BURSE PAGE UPPED");
            walletRepository.getBurseGeneralItemList(
                50, walletRepository.burseGeneralCurrentPageIndex + 1);
          }
        } else {
          if (currentScroll >= maxScroll * 0.96 || currentScroll == 0) {
            print("MY BURSE PAGE UPPED");
            walletRepository.getBurseMyItemList(
                50, walletRepository.burseMyCurrentPageIndex + 1);
          }
        }
      }
    });

    _tabController = TabController(length: 2, vsync: this);
    _tabController.index = isBurseOrMyOrder;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final walletRepository = RepositoryProvider.of<WalletRepository>(context);

    return Container(
      color: Colors.white,
      child: Scaffold(
        backgroundColor: AppColors.purpleBcg,
        appBar: CustomAppBar(
          context: context,
          text: "Биржа",
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: InkWell(
                splashColor: Colors.transparent,
                onTap: () {
                  context.push(RouteNames.walletBurseHistory);
                },
                child: const Icon(
                  Icons.history,
                  size: 28,
                  color: Colors.black,
                ),
              ),
            )
          ],
          isBack: true,
          onTap: () {
            context.pop();
          },
        ),
        body: CustomScrollView(
          controller: scrollController,
          physics:
              BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          slivers: [
            SliverPersistentHeader(
              pinned: false,
              floating: true,
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
                              image: const DecorationImage(
                                  image: NetworkImage(
                                      'https://assets.coingecko.com/coins/images/2655/large/emd.png?1644748192'))),
                        ),
                      ),
                      Text(
                          walletRepository.obscured
                              ? AppStrings.obscuredText
                              : walletRepository.emeraldInGameBalance
                                  .toString(),
                          style: AppTypography.font36w700
                              .copyWith(color: AppColors.textPrimary)),
                    ],
                  ),
                ),
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              floating: false,
              delegate: SliverAppBarDelegate(
                minHeight: 55,
                maxHeight: 55,
                child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    color: Colors.white,
                    child: CustomButton(
                      text: 'Создать свой заказ',
                      onTap: () {
                        context.push(RouteNames.walletBurseCreateOrder);
                      },
                      width: double.infinity,
                    )),
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
            SliverPersistentHeader(
              pinned: true,
              floating: false,
              delegate: SliverAppBarDelegate(
                minHeight: 60,
                maxHeight: 60,
                child: Container(
                  color: AppColors.purpleBcg,
                  alignment: Alignment.center,
                  child: TabBar(
                    labelColor: AppColors.textPrimary,
                    indicatorColor: AppColors.textPrimary,
                    indicatorWeight: 2,
                    indicator: const UnderlineTabIndicator(
                        borderSide:
                            BorderSide(color: AppColors.textPrimary, width: 2),
                        insets: EdgeInsets.symmetric(horizontal: -40)),
                    onTap: (int val) {
                      setState(() {
                        isBurseOrMyOrder = val;
                      });
                    },
                    controller: _tabController,
                    tabs: const [
                      Tab(
                        text: 'Биржа',
                      ),
                      Tab(text: 'Мои заказы'),
                    ],
                  ),
                ),
              ),
            ),
            CupertinoSliverRefreshControl(
              onRefresh: () {
                if (isBurseOrMyOrder == 0) {
                  return walletRepository.getBurseGeneralItemList(50, 0);
                } else {
                  return walletRepository.getBurseMyItemList(50, 0);
                }
              },
            ),
            SliverPadding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10)
                        .copyWith(bottom: 0),
                sliver: isBurseOrMyOrder == 0
                    ? BurseGeneralItemsListWidget(
                        itemsList: walletRepository.ordersGeneralList)
                    : BurseMyItemsListWidget(
                        itemsList: walletRepository.ordersMyList,
                      )),
          ],
        ),
      ),
    );
  }
}

class BurseGeneralItemsListWidget extends StatelessWidget {
  final List<dynamic> itemsList;

  const BurseGeneralItemsListWidget({
    required this.itemsList,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate([
        BlocBuilder<BurseGeneralOrdersCubit, BurseGeneralOrdersState>(
          buildWhen: (previous, current) {
            return current is BurseGeneralOrdersSuccess ||
                previous is BurseGeneralOrdersInitial;
          },
          builder: (context, state) {
            if (state is BurseGeneralOrdersSuccess) {
              return Column(
                children: itemsList
                    .map((currentOrder) => OrderItem(
                          type: BurseOrderType.general,
                          order: currentOrder,
                          onTap: () {
                            context.push(RouteNames.walletBurseBuyOrder,
                                extra: currentOrder);
                          },
                        ))
                    .toList(),
              );
            } else if (state is BurseGeneralOrdersLoading) {
              return Column(children: [
                ...itemsList
                    .map((currentOrder) => OrderItem(
                          type: BurseOrderType.general,
                          order: currentOrder,
                          onTap: () {
                            context.push(RouteNames.walletBurseBuyOrder,
                                extra: currentOrder);
                          },
                        ))
                    .toList(),
                const Center(
                  child: CircularProgressIndicator.adaptive(),
                )
              ]);
            }

            return Container();
          },
        )
      ]),
    );
  }
}

class BurseMyItemsListWidget extends StatelessWidget {
  final List<dynamic> itemsList;

  const BurseMyItemsListWidget({
    required this.itemsList,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate([
        BlocBuilder<BurseMyOrdersCubit, BurseMyOrdersState>(
          buildWhen: (previous, current) {
            return current is BurseMyOrdersSuccess ||
                previous is BurseMyOrdersInitial;
          },
          builder: (context, state) {
            if (state is BurseMyOrdersSuccess) {
              return Column(
                children: itemsList
                    .map((currentOrder) => OrderItem(
                          type: BurseOrderType.my,
                          order: currentOrder,
                          onTap: () {
                            context.push(RouteNames.walletBurseMyOrder,
                                extra: currentOrder);
                          },
                        ))
                    .toList(),
              );
            } else if (state is BurseMyOrdersLoading) {
              return Column(children: [
                ...itemsList
                    .map((currentOrder) => OrderItem(
                          type: BurseOrderType.my,
                          order: currentOrder,
                          onTap: () {
                            context.push(RouteNames.walletBurseMyOrder,
                                extra: currentOrder);
                          },
                        ))
                    .toList(),
                const Center(
                  child: CircularProgressIndicator.adaptive(),
                )
              ]);
            }

            return Container();
          },
        )
      ]),
    );
  }
}
