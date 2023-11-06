import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:izobility_mobile/feature/store/bloc/store_buy/store_buy_cubit.dart';
import 'package:izobility_mobile/feature/store/bloc/store_cubit.dart';
import 'package:izobility_mobile/feature/store/bloc/store_user_items/store_user_items_cubit.dart';
import 'package:izobility_mobile/feature/store/data/store_repository.dart';
import 'package:izobility_mobile/feature/store/ui/pages/store_user_products_state.dart';
import 'package:izobility_mobile/localization/app_localizations.dart';
import 'package:izobility_mobile/routes/go_routes.dart';
import 'package:izobility_mobile/utils/ui/colors.dart';
import 'package:izobility_mobile/utils/ui/fonts.dart';
import 'package:izobility_mobile/utils/ui/gradients.dart';
import 'package:izobility_mobile/widgets/app_bar/custom_app_bar.dart';
import 'package:izobility_mobile/widgets/button_sheet/bottom_sheets.dart';
import 'package:izobility_mobile/widgets/containers/market_Item.dart';
import 'package:izobility_mobile/widgets/scaffold/home_scaffold.dart';
import 'package:izobility_mobile/widgets/snack_bar/custom_snack_bar.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  late ScrollController scrollController = ScrollController();
  int currentCategory = 0;

  @override
  void initState() {
    final storeRepository = context.read<StoreRepository>();

    scrollController.addListener(() async {
      if (scrollController.position.atEdge) {
        double maxScroll = scrollController.position.maxScrollExtent;
        double currentScroll = scrollController.position.pixels;

        if (currentScroll >= maxScroll * 0.8) {
          storeRepository.setPageNumber(storeRepository.pageNumber + 1);
          storeRepository.getMarketItems();
        }
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);
    final storeRepository = RepositoryProvider.of<StoreRepository>(context);
    final localize = AppLocalizations.of(context)!;

    return BlocListener<StoreBuyCubit, StoreBuyState>(
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
      child: DefaultTabController(
          length: 4,
          child: HomeScaffold(
            appBar: CustomAppBar(
              text: localize.shop,
              context: context,
              isBack: false,
              bottom: TabBar(
                indicatorColor: AppColors.grey800,
                unselectedLabelColor: AppColors.grey400,
                labelColor: AppColors.grey800,
                onTap: (v) {
                  setState(() {
                    currentCategory = v;
                  });
                },
                isScrollable: true,
                tabs: [
                  Tab(
                    icon: Text(
                      "Все",
                      style: AppTypography.font14w700,
                    ),
                  ),
                  Tab(icon: Text("Места", style: AppTypography.font14w700)),
                  Tab(icon: Text("События", style: AppTypography.font14w700)),
                  Tab(icon: Text("Другое", style: AppTypography.font14w700)),
                ],
              ),
            ),
            body: RefreshIndicator.adaptive(
              onRefresh: () {
                storeRepository.setPageNumber(1);

                return storeRepository.getMarketItems();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: BlocBuilder<StoreCubit, StoreState>(
                  builder: (context, state) {
                    late final shopItems;
                    if (currentCategory != 0) {
                      shopItems = storeRepository.marketItems
                          .where((element) =>
                              element.category == currentCategory.toString())
                          .toList();
                    } else {
                      shopItems = storeRepository.marketItems;
                    }

                    bool isLoading = state is StoreLoading;

                    return CustomScrollView(
                        controller: scrollController,
                        physics: const AlwaysScrollableScrollPhysics(
                            parent: BouncingScrollPhysics()),
                        slivers: [
                          const SliverToBoxAdapter(
                            child: SizedBox(
                              height: 16,
                            ),
                          ),
                          BlocBuilder<StoreUserItemsCubit, StoreUserItemsState>(
                            builder: (context, state) {
                              if (state is StoreUserItemsSuccess) {
                                if (storeRepository
                                    .userProductList.isNotEmpty) {
                                  return buildGetUserItemsBanner(sizeOf);
                                }
                              }

                              return SliverToBoxAdapter(child: Container());
                            },
                          ),
                          const SliverToBoxAdapter(
                            child: SizedBox(
                              height: 10,
                            ),
                          ),
                          SliverGrid(
                              delegate: SliverChildBuilderDelegate(
                                (context, index) => MarketItem(
                                  marketItem: shopItems[index],
                                ),
                                childCount: shopItems.length,
                              ),
                              gridDelegate:
                                  SliverGridDelegateWithMaxCrossAxisExtent(
                                      crossAxisSpacing: 8,
                                      maxCrossAxisExtent:
                                          MediaQuery.of(context).size.width / 2,
                                      childAspectRatio: 0.64)),
                          isLoading
                              ? const SliverToBoxAdapter(
                                  child: Center(
                                      child: CircularProgressIndicator()),
                                )
                              : SliverToBoxAdapter(
                                  child: Container(),
                                )
                        ]);
                  },
                ),
              ),
            ),
          )),
    );
  }

  SliverToBoxAdapter buildGetUserItemsBanner(Size sizeOf) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(16),
        height: 145,
        decoration: BoxDecoration(
          gradient: AppGradients.shrek,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: sizeOf.width - 200,
                  child: Text(
                    'Ваши товары и все отстальное',
                    style: AppTypography.font20w700,
                  ),
                ),
                InkWell(
                  onTap: () {
                    context.go(RouteNames.profile);
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        gradient: AppGradients.accentGreen),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Получить",
                          style: AppTypography.font14w700
                              .copyWith(color: Colors.black),
                        ),
                        const Icon(
                          Icons.arrow_forward,
                          color: Colors.black,
                          size: 14,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            Image.asset(
              'assets/images/shopping_cart.png',
            ),
          ],
        ),
      ),
    );
  }
}
