import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:izobility_mobile/feature/profile/bloc/profile_links/profile_links_cubit.dart';
import 'package:izobility_mobile/feature/store/bloc/store_buy/store_buy_cubit.dart';
import 'package:izobility_mobile/feature/store/bloc/store_item/store_item_cubit.dart';
import 'package:izobility_mobile/feature/store/data/store_repository.dart';
import 'package:izobility_mobile/feature/store/ui/widgets/product_link.dart';
import 'package:izobility_mobile/feature/store/ui/widgets/profuct_my_coin_quantity.dart';
import 'package:izobility_mobile/feature/store/ui/widgets/store_item_quantity_container.dart';
import 'package:izobility_mobile/feature/store/ui/widgets/store_price_container.dart';
import 'package:izobility_mobile/feature/wallet/bloc/coin_in_game/coin_in_game_cubit.dart';
import 'package:izobility_mobile/feature/wallet/data/wallet_repository.dart';
import 'package:izobility_mobile/services/remote/api/api_service.dart';
import 'package:izobility_mobile/utils/ui/animations.dart';
import 'package:izobility_mobile/utils/ui/dialogs.dart';
import 'package:izobility_mobile/utils/utils.dart';
import 'package:izobility_mobile/widgets/app_bar/custom_app_bar.dart';
import 'package:izobility_mobile/widgets/button/custom_button.dart';
import 'package:izobility_mobile/widgets/button_sheet/bottom_sheets.dart';
import 'package:izobility_mobile/widgets/scaffold/home_scaffold.dart';
import 'package:izobility_mobile/widgets/snack_bar/custom_snack_bar.dart';

class ProductScreen extends StatefulWidget {
  final String id;

  const ProductScreen({super.key, required this.id});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  PageController pageController = PageController();
  int page = 0;

  @override
  void initState() {
    context.read<StoreItemCubit>().loadMarketItemInfo(int.parse(widget.id));

    pageController.addListener(() {
      if (pageController.page?.round() != page) {
        setState(() {});

        page = pageController.page!.round();
      }
    });

    super.initState();
  }

  Row getImageIndicator(int count) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
            count,
            (index) => Container(
                  margin: const EdgeInsets.only(right: 5),
                  width: page == index ? 25 : 9,
                  height: 9,
                  decoration: BoxDecoration(
                    color: AppColors.disableButton,
                    borderRadius: BorderRadius.circular(8),
                  ),
                )));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<StoreBuyCubit, StoreBuyState>(
      listener: (context, state) {
        ScaffoldMessenger.of(context).clearSnackBars();

        if (state is StoreBuyLoading) {
          Dialogs.showModal(
              context,
              const Center(
                child: AppAnimations.circularProgressIndicator,
              ));
        } else if (state is StoreBuyFailure) {
          context.pop();

          ScaffoldMessenger.of(context)
              .showSnackBar(CustomSnackBar.successSnackBar('Ошибка'));
        } else if (state is StoreBuySuccess) {
          context.pop(); // clear dialog
          context.pop(); // clear modal bottom sheet

          AppBottomSheets.productBought(context);
        }
      },
      child: HomeScaffold(
        appBar: CustomAppBar(
          context: context,
          text: "Промокод",
          isBack: true,
          onTap: () {
            context.pop();
          },
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await context.read<WalletRepository>().getGameTokens();
          },
          child: SingleChildScrollView(
            child: BlocBuilder<StoreItemCubit, StoreItemState>(
              builder: (context, state) {
                if (state is StoreItemLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                } else if (state is StoreItemSuccessState) {
                  return buildMarketItemData();
                } else {
                  return Container();
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Column buildMarketItemData() {
    final marketItem = context.read<StoreRepository>().lastOpenedMarketItem;
    final emeraldCoin = context.read<WalletRepository>().emeraldInGameBalance;

    final sizeOf = MediaQuery.sizeOf(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Column(
          children: [
            SizedBox(
              height: sizeOf.width,
              child: PageView.builder(
                  controller: pageController,
                  itemCount: marketItem.images!.length,
                  pageSnapping: true,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {},
                      child: Container(
                        width: sizeOf.width,
                        height: sizeOf.width,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                marketItem.images[index],
                              ),
                              fit: BoxFit.cover),
                        ),
                      ),
                    );
                  }),
            ),
            const SizedBox(
              height: 10,
            ),
            getImageIndicator(marketItem.images!.length),
          ],
        ),
        Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                marketItem.name!,
                style: AppTypography.font20w700.copyWith(color: Colors.black),
              ),
              const SizedBox(
                height: 8,
              ),
              StorePriceContainer(
                marketItem: marketItem,
              ),
              const SizedBox(
                height: 4,
              ),
              StoreItemQuantityContainer(
                  itemsLost: int.parse(marketItem.quantity), itemsAll: 1000),
              const SizedBox(
                height: 16,
              ),
              const SizedBox(
                height: 16,
              ),
              const Text("У вас есть"),
              BlocBuilder<CoinInGameCubit, CoinInGameState>(
                builder: (context, state) {
                  if (state is CoinInGameLoading) {
                    return Column(
                      children: [
                        Container(
                          height: 40,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: AppColors.grey400.withOpacity(0.6),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        CustomButton(
                            isActive: false,
                            text: "Получить",
                            onTap: () {
                              AppBottomSheets.buyProductBottomSheet(
                                  context, marketItem);
                            },
                            width: double.infinity),
                      ],
                    );
                  } else if (state is CoinInGameSuccess) {
                    final double quantity = double.parse(context
                        .read<WalletRepository>()
                        .coinsInGame
                        .where((element) => element.id == marketItem.coin.id)
                        .toList()[0]
                        .amount);

                    return Column(
                      children: [
                        ProductMyCoinQuantity(
                          imagePath: marketItem.coin.imageUrl,
                          quantity: quantity,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        CustomButton(
                            isActive: marketItem.price <= quantity,
                            text: "Получить",
                            onTap: () {
                              AppBottomSheets.buyProductBottomSheet(
                                  context, marketItem);
                            },
                            width: double.infinity),
                      ],
                    );
                  }

                  return Container();
                },
              ),
              const SizedBox(
                height: 8,
              ),
              CustomButton(
                  isActive: true,
                  text: "Купить монет",
                  onTap: () async {
                    context.read<ProfileLinksCubit>().loadLink(
                        marketItem.coin.url == ""
                            ? "https://oqopo.org/emerald-verse/"
                            : marketItem.coin.url);
                  },
                  width: double.infinity),
              const SizedBox(
                height: 16,
              ),
              Text(
                'Описание',
                style: AppTypography.font18w700.copyWith(color: Colors.black),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                marketItem.description,
                style:
                    AppTypography.font12w400.copyWith(color: AppColors.grey500),
              ),
              const SizedBox(
                height: 10,
              ),
              const ProductLink(
                linkText: "О компании",
              ),
              const SizedBox(
                height: 5,
              ),
              const ProductLink(
                linkText: "Об акции",
              ),
              const SizedBox(
                height: 5,
              ),
              const ProductLink(
                linkText: "Публичная офёрта",
              ),
              const SizedBox(
                height: 5,
              ),
              const ProductLink(
                linkText: "О возврате",
              ),
              const SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
