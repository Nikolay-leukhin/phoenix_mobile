import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:phoenix_mobile/feature/wallet/data/wallet_repository.dart';
import 'package:phoenix_mobile/localization/app_localizations.dart';
import 'package:phoenix_mobile/routes/go_routes.dart';
import 'package:phoenix_mobile/utils/ui/colors.dart';
import 'package:phoenix_mobile/utils/ui/fonts.dart';
import 'package:phoenix_mobile/widgets/navigator_bar/custom_main_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.body, required this.pageIndex});

  final Widget body;
  final int pageIndex;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    GoRouter router = GoRouter.of(context);

    final walletRepository = RepositoryProvider.of<WalletRepository>(context);
    final locolize = AppLocalizations.of(context)!;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          backgroundColor: AppColors.purpleBcg,
          body: widget.body,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: widget.pageIndex != 2
              ? NavigationFloatingActionButton(
                  withShadow: false,
                  onTap: () {
                    router.go(RouteNames.games);
                  },
                )
              : null,
          bottomNavigationBar: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                color: Colors.transparent),
            clipBehavior: Clip.hardEdge,
            child: BottomAppBar(
              notchMargin: 8,
              color: Colors.white,
              surfaceTintColor: Colors.transparent,
              height: 80,
              shape: const CircularNotchedRectangle(),
              elevation: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  NavigatorBarItem(
                    asset: 'assets/icons/home.svg',
                    isSelected: widget.pageIndex == 0,
                    onTap: () {
                      router.go(RouteNames.main);
                    },
                    name: locolize.main,
                  ),
                  NavigatorBarItem(
                    asset: 'assets/icons/wallet.svg',
                    isSelected: widget.pageIndex == 1,
                    onTap: () async {
                      bool isAuth = await walletRepository.checkWalletAuth();
                      if (isAuth == true) {
                        await context.read<WalletRepository>().getWallet();
                      }

                      router.go('${RouteNames.wallet}/${isAuth.toString()}');
                    },
                    name: locolize.wallet,
                  ),
                  Opacity(
                      opacity: widget.pageIndex == 2 ? 1 : 0,
                      child: NavigationFloatingActionButton(
                        withShadow: true,
                        onTap: () {},
                      )),
                  NavigatorBarItem(
                    asset: 'assets/icons/card.svg',
                    isSelected: widget.pageIndex == 3,
                    onTap: () {
                      router.go(RouteNames.basket);
                    },
                    name: locolize.shop,
                  ),
                  NavigatorBarItem(
                    asset: 'assets/icons/user.svg',
                    isSelected: widget.pageIndex == 4,
                    onTap: () {
                      router.go(RouteNames.profile);
                    },
                    name: locolize.profile,
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

class NavigatorBarItem extends StatelessWidget {
  const NavigatorBarItem(
      {Key? key,
      required this.asset,
      required this.isSelected,
      required this.onTap,
      required this.name})
      : super(key: key);

  final String asset;
  final String name;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        // padding: const EdgeInsets.only(top: 12),

        width: MediaQuery.of(context).size.width / 5,
        height: MediaQuery.of(context).size.width / 5,
        child: Center(
          child: Column(
            children: [
              SvgPicture.asset(
                asset,
                height: 28,
                width: 28,
                // ignore: deprecated_member_use
                color: isSelected ? AppColors.textPrimary : AppColors.disable,
              ),
              FittedBox(
                child: Text(
                  name,
                  style: AppTypography.font12w700.copyWith(
                      color: isSelected
                          ? AppColors.textPrimary
                          : AppColors.disable),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class NavigationFloatingActionButton extends StatelessWidget {
  final Function onTap;
  final bool withShadow;

  const NavigationFloatingActionButton(
      {super.key, required this.onTap, required this.withShadow});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10000),
      color: AppColors.primary,
      child: InkWell(
        borderRadius: BorderRadius.circular(10000),
        child: Container(
          decoration: BoxDecoration(
              boxShadow: withShadow
                  ? [
                      const BoxShadow(
                        color: Color(0x59001067),
                        blurRadius: 20,
                        offset: Offset(0, 8),
                        spreadRadius: 0,
                      )
                    ]
                  : []),
          padding: const EdgeInsets.all(12),
          child: SvgPicture.asset(
            "assets/icons/city.svg",
            width: 24,
            color: Colors.white,
          ),
        ),
        onTap: () {
          onTap();
        },
      ),
    );
  }
}
