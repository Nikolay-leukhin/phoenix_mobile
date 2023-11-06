import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:izobility_mobile/feature/auth/ui/create_password.dart';
import 'package:izobility_mobile/feature/auth/ui/create_pin_screen.dart';
import 'package:izobility_mobile/feature/auth/ui/enter_email.dart';
import 'package:izobility_mobile/feature/auth/ui/enter_name.dart';
import 'package:izobility_mobile/feature/auth/ui/enter_password.dart';
import 'package:izobility_mobile/feature/auth/ui/enter_pin_screen.dart';
import 'package:izobility_mobile/feature/auth/ui/password_recovery_email.dart';
import 'package:izobility_mobile/feature/auth/ui/verify_recovery_code.dart';
import 'package:izobility_mobile/feature/cards/ui/pages/cards_screen.dart';
import 'package:izobility_mobile/feature/cards/ui/pages/cards_add_screen.dart';
import 'package:izobility_mobile/feature/games/ui/pages/games_details_screen.dart';
import 'package:izobility_mobile/feature/games/ui/pages/games_loading_screen.dart';
import 'package:izobility_mobile/feature/games/ui/pages/games_screen.dart';
import 'package:izobility_mobile/feature/home/ui/home_screen.dart';
import 'package:izobility_mobile/feature/main/ui/pages/main_qr_screen.dart';
import 'package:izobility_mobile/feature/main/ui/pages/main_screen.dart';
import 'package:izobility_mobile/feature/main/ui/pages/notifications_screen.dart';
import 'package:izobility_mobile/feature/main/ui/pages/story_screen.dart';
import 'package:izobility_mobile/feature/profile/ui/pages/profile.dart';
import 'package:izobility_mobile/feature/profile/ui/pages/profile_about.dart';
import 'package:izobility_mobile/feature/profile/ui/pages/profile_edit.dart';
import 'package:izobility_mobile/feature/profile/ui/pages/profile_language.dart';
import 'package:izobility_mobile/feature/profile/ui/pages/profile_phone_confirm.dart';
import 'package:izobility_mobile/feature/profile/ui/pages/profile_phone_edit.dart';
import 'package:izobility_mobile/feature/profile/ui/pages/profile_privacy_policy.dart';
import 'package:izobility_mobile/feature/profile/ui/pages/profile_referal.dart';
import 'package:izobility_mobile/feature/splash/splash.dart';
import 'package:izobility_mobile/feature/store/ui/pages/product_page.dart';
import 'package:izobility_mobile/feature/store/ui/pages/promo_screen.dart';
import 'package:izobility_mobile/feature/store/ui/pages/store_screen.dart';
import 'package:izobility_mobile/feature/store/ui/pages/store_user_products_state.dart';
import 'package:izobility_mobile/feature/wallet/ui/pages/burse/burse_buy_order_screen.dart';
import 'package:izobility_mobile/feature/wallet/ui/pages/burse/burse_choose_coin_screen.dart';
import 'package:izobility_mobile/feature/wallet/ui/pages/burse/burse_create_order_screen.dart';
import 'package:izobility_mobile/feature/wallet/ui/pages/burse/burse_create_order_success_screen.dart';
import 'package:izobility_mobile/feature/wallet/ui/pages/burse/burse_history_screen.dart';
import 'package:izobility_mobile/feature/wallet/ui/pages/burse/burse_my_orders.dart';
import 'package:izobility_mobile/feature/wallet/ui/pages/burse/burse_screen.dart';
import 'package:izobility_mobile/feature/wallet/ui/pages/buy_currency_screen.dart';
import 'package:izobility_mobile/feature/wallet/ui/pages/auth/wallet_auth.dart';
import 'package:izobility_mobile/feature/wallet/ui/pages/auth/wallet_enter_seed.dart';
import 'package:izobility_mobile/feature/wallet/ui/pages/coin/wallet_coin_screen.dart';
import 'package:izobility_mobile/feature/wallet/ui/pages/coin/wallet_info_coin_screen.dart';
import 'package:izobility_mobile/feature/wallet/ui/pages/wallet_choose_coin_screen.dart';
import 'package:izobility_mobile/feature/wallet/ui/pages/wallet_game-chain_transfer.dart';
import 'package:izobility_mobile/feature/wallet/ui/pages/wallet_replenish_screen.dart';
import 'package:izobility_mobile/feature/wallet/ui/pages/wallet_screen.dart';
import 'package:izobility_mobile/feature/wallet/ui/pages/settings/wallet_view_seed.dart';
import 'package:izobility_mobile/feature/wallet/ui/pages/settings/wallet_setting.dart';
import 'package:izobility_mobile/feature/wallet/ui/pages/wallet_send_ingame_coin_screen.dart';
import 'package:izobility_mobile/feature/wallet/ui/pages/wallet_send_onchain_coin_screen.dart';
import 'package:izobility_mobile/feature/wallet/ui/pages/wallet_swap_in_game_token_screen.dart';
import 'package:izobility_mobile/models/api/token_data.dart';
import 'package:izobility_mobile/models/burse/burse_order.dart';
import 'package:izobility_mobile/widgets/screens/develop_screen.dart';

import '../feature/auth/bloc/app/app_cubit.dart';
import '../feature/profile/ui/pages/profile_settings.dart';

part 'main_routes.dart';

part 'auth_routes.dart';

part 'route_names.dart';

part 'stream_auth_scope.dart';

class CustomGoRoutes {
  static final defaultKey = GlobalKey<NavigatorState>();
  static final shellNavigatorKey = GlobalKey<NavigatorState>();

  static final router = GoRouter(
    initialLocation: RouteNames.splash,
    navigatorKey: defaultKey,
    redirect: (BuildContext context, GoRouterState state) async {
      final AppState appState = StreamAuthNotifier.of(context) ?? AppInitial();

      print(appState);

      bool containsRout(String route) {
        for (String defaultRoute in mainRoutesNames) {
          if (route.startsWith(defaultRoute)) return true;
        }
        return false;
      }

      if (appState is AppAuthState && !containsRout(state.matchedLocation)) {
        return RouteNames.main;
      }
      if (appState is CreatePinState) {
        return RouteNames.authCreatePin;
      }

      if (appState is EnterPinState) {
        return RouteNames.authEnterPin;
      }

      if (appState is AppUnAuthState &&
          !authRoutes.contains(state.matchedLocation)) {
        return RouteNames.auth;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: RouteNames.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: RouteNames.develop,
        builder: (context, state) => DevelopingScreen(),
      ),
      GoRoute(
        path: RouteNames.auth,
        builder: (context, state) => const EnterEmailScreen(),
      ),
      GoRoute(
        path: RouteNames.cardsAdd,
        builder: (context, state) => const CardsAddScreen(),
      ),
      GoRoute(
          path: RouteNames.authCreateName,
          builder: (context, state) => const EnterNameScreen()),
      GoRoute(
          path: RouteNames.authEnterPassword,
          builder: (context, state) => const EnterPasswordScreen()),
      GoRoute(
          path: RouteNames.authCreatePin,
          builder: (context, state) => const CreatePinScreen()),
      GoRoute(
          path: RouteNames.authEnterPin,
          builder: (context, state) => const EnterPinScreen()),
      GoRoute(
          path: '${RouteNames.authCreatePasswordBaseLink}/:variant',
          builder: (context, state) => CreatePasswordScreen(
                creatingVariant: state.pathParameters['variant'] ?? '',
              )),
      GoRoute(
          path: RouteNames.authPasswordRecoveryEmail,
          builder: (context, state) => const PasswordRecoveryEmailScreen()),
      GoRoute(
          path: RouteNames.mainQr,
          builder: (context, state) =>  MainQrScreen(
            onFound: (state.extra as Map<String, dynamic>)['onFound'] as Function,
          )),
      GoRoute(
          path: RouteNames.authPasswordRecoveryVerifyCode,
          builder: (context, state) => const VerifyRecoveryCodeScreen()),
      GoRoute(
          path: RouteNames.profilePrivacyPolicy,
          builder: (context, state) => const ProfilePrivacyPolicyScreen()),
      GoRoute(
          path: RouteNames.profileEdit,
          builder: (context, state) => const ProfileEditScreen()),
      GoRoute(
          path: RouteNames.profileSettings,
          builder: (context, state) => const ProfileSettingsScreen()),
      GoRoute(
          path: RouteNames.profileAbout,
          builder: (context, state) => const ProfileAppAboutScreen()),
      GoRoute(
          path: RouteNames.profilePhoneConfirm,
          builder: (context, state) => const ProfilePhoneConfirm()),
      GoRoute(
          path: RouteNames.profilePhone,
          builder: (context, state) => const ProfilePhoneEdit()),
      GoRoute(
          path: RouteNames.profileReferal,
          builder: (context, state) => const ProfileReferalScreen()),
      GoRoute(
          path: RouteNames.profileLanguage,
          builder: (context, state) => const ProfileLanguageScreen()),
      GoRoute(
          path: RouteNames.notifications,
          builder: (context, state) => const NotificationsScreen()),
      GoRoute(
          path: RouteNames.storeUserProducts,
          builder: (context, state) => const StoreUserProductsScreen()),
      GoRoute(
          path: RouteNames.walletChainGameTransfer,
          builder: (context, state) =>
              WalletGameChainTransferScreen(coin: state.extra as TokenData)),
      GoRoute(
          path: RouteNames.storeProduct,
          builder: (context, state) => ProductScreen(
                id: state.pathParameters['id'] ?? "0",
              )),
      GoRoute(
          path: '${RouteNames.story}/:story_id',
          builder: (context, state) => StoryScreen(
                initialStoryIndex:
                    int.parse(state.pathParameters['story_id'] ?? 0 as String),
              )),
      GoRoute(
          path: RouteNames.walletCurrency,
          builder: (context, state) {
            return CurrencyWalletScreen(
              token: (state.extra as Map<String, dynamic>)['token_data']
                  as TokenData,
              inGameOrOrChain: (state.extra
                  as Map<String, dynamic>)['in_game_or_on_chain'] as bool,
            );
          }),
      GoRoute(
          path: RouteNames.walletViewSeed,
          builder: (context, state) => const WalletViewSeedPhraseScreen()),
      GoRoute(
          path: RouteNames.walletAuth,
          builder: (context, state) => const WalletAuthScreen()),
      GoRoute(
          path: RouteNames.walletBurse,
          builder: (context, state) => const BurseScreen()),
      GoRoute(
          path: RouteNames.walletBurseBuyOrder,
          builder: (context, state) => BurseBuyOrderScreen(
                order: state.extra as BurseOrderModel,
              )),
      GoRoute(
          path: RouteNames.walletBurseCreateOrderSuccess,
          builder: (context, state) => const BurseCreateOrderSuccessScreen()),
      GoRoute(
          path: RouteNames.walletBurseChooseCoin,
          builder: (context, state) => BurseChooseCoinScreen(
                fromOrTo: state.extra as bool,
              )),
      GoRoute(
          path: RouteNames.walletBurseCreateOrder,
          builder: (context, state) => const BurseCreateOrderScreen()),
      GoRoute(
          path: RouteNames.walletBurseHistory,
          builder: (context, state) => const BurseHistoryScreen()),
      GoRoute(
          path: RouteNames.walletInfoCurrency,
          builder: (context, state) => InfoCurrencyWalletScreen(
                token: state.extra as TokenData,
              )),
      GoRoute(
          path: RouteNames.walletSwap,
          builder: (context, state) => const SwapScreen()),
      GoRoute(
          path: RouteNames.walletSendOnChainCoin,
          builder: (context, state) => SendOnChainCoinScreen(
                coin: state.extra as TokenData,
              )),
      GoRoute(
          path: RouteNames.walletSendInGameCoin,
          builder: (context, state) => SendInGameCoinScreen(
                coin: state.extra as TokenData,
              )),
      GoRoute(
          path: RouteNames.walletReplenish,
          builder: (context, state) => const WalletReplenishScreen()),
      GoRoute(
          path: RouteNames.walletSetting,
          builder: (context, state) => const WalletSettingScreen()),
      GoRoute(
        path: RouteNames.walletChooseCoin,
        builder: (context, state) => ChooseCoinScreen(
          path: (state.extra as Map<String, dynamic>)['path'] as String,
          fromOrTo: ((state.extra as Map<String, dynamic>)['fromOrTo'] ?? false)
              as bool,
        ),
      ),
      GoRoute(
          path: RouteNames.walletBuyCurrency,
          builder: (context, state) => const BuyCurrencyScreen()),
      GoRoute(
          path: RouteNames.walletBurseMyOrder,
          builder: (context, state) => BurseMyOrdersScreen(
                order: state.extra as BurseOrderModel,
              )),
      GoRoute(
          path: RouteNames.cards,
          builder: (context, state) => const CardsScreen()),
      GoRoute(
        path: RouteNames.gamesDetails,
        builder: (context, state) => GamesDetailsScreen(
          gameId: state.pathParameters['game_id'] ?? '0',
        ),
      ),
      GoRoute(
          path: RouteNames.walletEnterSeedPhrase,
          builder: (context, state) => const EnterSeedPhraseScreen()),
      GoRoute(
          path: RouteNames.gamesDetailsLoading,
          builder: (context, state) => const GamesLoadingScreen()),
      ShellRoute(
        navigatorKey: shellNavigatorKey,
        builder: (context, state, child) {
          final routeIndexes = [
            RouteNames.main,
            RouteNames.wallet,
            RouteNames.games,
            RouteNames.basket,
            RouteNames.profile
          ];

          return HomeScreen(
            body: child,
            pageIndex: routeIndexes.indexOf(state.matchedLocation
                .replaceFirst('/false', '')
                .replaceFirst('/true', '')),
          );
        },
        routes: [
          GoRoute(
            path: RouteNames.main,
            pageBuilder: (context, state) => CustomTransitionPage<void>(
              key: state.pageKey,
              child: const MainScreen(),
              transitionsBuilder: (BuildContext context,
                  Animation<double> animation,
                  Animation<double> secondaryAnimation,
                  Widget child) {
                return child;
              },
            ),
          ),
          GoRoute(
              path: '${RouteNames.wallet}/:isAuth',
              pageBuilder: (context, state) => CustomTransitionPage<void>(
                  key: state.pageKey,
                  child: bool.parse(state.pathParameters['isAuth'] ?? 'false')
                      ? const WalletScreen()
                      : const WalletAuthScreen(),
                  transitionsBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation,
                      Widget child) {
                    return child;
                  })),
          GoRoute(
            path: RouteNames.games,
            pageBuilder: (context, state) => CustomTransitionPage<void>(
              key: state.pageKey,
              child: const GamesScreen(),
              transitionsBuilder: (BuildContext context,
                  Animation<double> animation,
                  Animation<double> secondaryAnimation,
                  Widget child) {
                return child;
              },
            ),
          ),
          GoRoute(
            path: RouteNames.basket,
            pageBuilder: (context, state) => CustomTransitionPage<void>(
              key: state.pageKey,
              child: const StoreScreen(),
              transitionsBuilder: (BuildContext context,
                  Animation<double> animation,
                  Animation<double> secondaryAnimation,
                  Widget child) {
                return child;
              },
            ),
          ),
          GoRoute(
            path: RouteNames.profile,
            pageBuilder: (context, state) => CustomTransitionPage<void>(
              key: state.pageKey,
              child: const ProfileScreen(),
              transitionsBuilder: (BuildContext context,
                  Animation<double> animation,
                  Animation<double> secondaryAnimation,
                  Widget child) {
                return child;
              },
            ),
          ),
        ],
      ),
    ],
  );
}
