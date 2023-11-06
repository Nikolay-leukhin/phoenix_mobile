import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:izobility_mobile/feature/auth/bloc/app/app_cubit.dart';
import 'package:izobility_mobile/feature/auth/bloc/password_recovery/password_recovery_cubit.dart';
import 'package:izobility_mobile/feature/auth/data/auth_repository.dart';
import 'package:izobility_mobile/feature/games/bloc/games/games_cubit.dart';
import 'package:izobility_mobile/feature/games/data/games_repository.dart';
import 'package:izobility_mobile/feature/main/bloc/main/main_screen_cubit.dart';
import 'package:izobility_mobile/feature/main/bloc/story/story_cubit.dart';
import 'package:izobility_mobile/feature/main/bloc/notifications/notifications_cubit.dart';
import 'package:izobility_mobile/feature/main/data/main_repository.dart';
import 'package:izobility_mobile/feature/main/data/notification_repository.dart';
import 'package:izobility_mobile/feature/profile/bloc/profile/profile_cubit.dart';
import 'package:izobility_mobile/feature/profile/bloc/profile_links/profile_links_cubit.dart';
import 'package:izobility_mobile/feature/profile/bloc/profile_phone/profile_phone_change_cubit.dart';
import 'package:izobility_mobile/feature/profile/bloc/profile_referals/profile_referals_cubit.dart';
import 'package:izobility_mobile/feature/profile/data/user_repository.dart';
import 'package:izobility_mobile/feature/store/bloc/store_buy/store_buy_cubit.dart';
import 'package:izobility_mobile/feature/store/bloc/store_cubit.dart';
import 'package:izobility_mobile/feature/store/bloc/store_item/store_item_cubit.dart';
import 'package:izobility_mobile/feature/store/bloc/store_user_items/store_user_items_cubit.dart';
import 'package:izobility_mobile/feature/store/data/store_repository.dart';
import 'package:izobility_mobile/feature/wallet/bloc/burse_buy_order/burse_buy_order_cubit.dart';
import 'package:izobility_mobile/feature/wallet/bloc/burse_create_order/burse_create_order_cubit.dart';
import 'package:izobility_mobile/feature/wallet/bloc/burse_general_orders/burse_general_orders_cubit.dart';
import 'package:izobility_mobile/feature/wallet/bloc/burse_my_orders/burse_my_orders_cubit.dart';
import 'package:izobility_mobile/feature/wallet/bloc/coin_in_game/coin_in_game_cubit.dart';
import 'package:izobility_mobile/feature/wallet/bloc/coin_in_wallet/coin_in_wallet_cubit.dart';
import 'package:izobility_mobile/feature/wallet/bloc/coin_send/coin_send_cubit.dart';
import 'package:izobility_mobile/feature/wallet/bloc/coins_in_game/coins_in_game_cubit.dart';
import 'package:izobility_mobile/feature/wallet/bloc/coins_on_chain/coins_on_chain_cubit.dart';
import 'package:izobility_mobile/feature/wallet/bloc/promo_code/promo_code_cubit.dart';
import 'package:izobility_mobile/feature/wallet/bloc/swap_in_game_coins/swap_in_game_coins_cubit.dart';
import 'package:izobility_mobile/feature/wallet/bloc/wallet_auth/wallet_auth_cubit.dart';
import 'package:izobility_mobile/feature/wallet/data/wallet_repository.dart';
import 'package:izobility_mobile/main.dart';
import 'package:izobility_mobile/routes/go_routes.dart';
import 'package:izobility_mobile/services/crypto/api_cripto.dart';
import 'package:izobility_mobile/services/locale/export_locale_services.dart';
import 'package:izobility_mobile/services/remote/api/api_service.dart';

import 'feature/auth/bloc/auth/auth_cubit.dart';

final PreferencesService prefs = PreferencesService();
final ApiService api = ApiService(preferencesService: prefs);

class MyBlocProviders extends StatelessWidget {
  const MyBlocProviders(this.notifier, {super.key});

  final StreamAuthNotifier notifier;

  @override
  Widget build(BuildContext context) {
    final appCubit = AppCubit(
        userRepository: RepositoryProvider.of<UserRepository>(context),
        authRepository: RepositoryProvider.of<AuthRepository>(context),
        mainRepository: RepositoryProvider.of<MainScreenRepository>(context),
        walletRepository: RepositoryProvider.of<WalletRepository>(context),
        storeRepository: RepositoryProvider.of<StoreRepository>(context));

    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => AuthCubit(
                authRepository: RepositoryProvider.of<AuthRepository>(context)),
            lazy: false,
          ),
          BlocProvider(
            create: (_) => appCubit,
            lazy: false,
          ),
          BlocProvider(
            create: (_) => PasswordRecoveryCubit(apiService: api),
            lazy: false,
          ),
          BlocProvider(
            create: (_) => StoryCubit(
                repository:
                    RepositoryProvider.of<MainScreenRepository>(context)),
            lazy: false,
          ),
          BlocProvider(
            create: (_) => StoreCubit(
                storeRepository:
                    RepositoryProvider.of<StoreRepository>(context)),
            lazy: false,
          ),
          BlocProvider(
            create: (_) => ProfilePhoneChangeCubit(
                RepositoryProvider.of<UserRepository>(context)),
            lazy: false,
          ),
          BlocProvider(
            create: (_) => StoreItemCubit(
                storeRepository:
                    RepositoryProvider.of<StoreRepository>(context)),
            lazy: false,
          ),
          BlocProvider(
            create: (_) => MainScreenCubit(
                repository:
                    RepositoryProvider.of<MainScreenRepository>(context)),
            lazy: false,
          ),
          BlocProvider(
            create: (_) => NotificationsCubit(
                RepositoryProvider.of<NotificationsRepository>(context)),
            lazy: false,
          ),
          BlocProvider(
            create: (_) => PromoCodeCubit(
                apiService: api,
                walletRepository:
                    RepositoryProvider.of<WalletRepository>(context)),
            lazy: false,
          ),
          BlocProvider(
            create: (_) =>
                GamesCubit(RepositoryProvider.of<GamesRepository>(context)),
            lazy: false,
          ),
          BlocProvider(
            create: (_) =>
                ProfileCubit(RepositoryProvider.of<UserRepository>(context)),
            lazy: false,
          ),
          BlocProvider(
            create: (_) => ProfileLinksCubit(),
            lazy: false,
          ),
          BlocProvider(
            create: (_) => CoinInGameCubit(
                walletRepository:
                    RepositoryProvider.of<WalletRepository>(context)),
            lazy: false,
          ),
          BlocProvider(
            create: (_) => WalletAuthCubit(
                RepositoryProvider.of<WalletRepository>(context)),
            lazy: false,
          ),
          BlocProvider(
            create: (_) => CoinInWalletCubit(
                RepositoryProvider.of<WalletRepository>(context)),
            lazy: false,
          ),
          BlocProvider(
            create: (_) => BurseCreateOrderCubit(
                RepositoryProvider.of<WalletRepository>(context)),
            lazy: false,
          ),
          BlocProvider(
            create: (_) => BurseGeneralOrdersCubit(
                RepositoryProvider.of<WalletRepository>(context)),
            lazy: false,
          ),
          BlocProvider(
            create: (_) => CoinSendCubit(
                walletRepository:
                    RepositoryProvider.of<WalletRepository>(context)),
            lazy: false,
          ),
          BlocProvider(
            create: (_) => BurseBuyOrderCubit(
                RepositoryProvider.of<WalletRepository>(context)),
            lazy: false,
          ),
          BlocProvider(
            create: (_) => CoinsOnChainCubit(
                RepositoryProvider.of<WalletRepository>(context)),
            lazy: false,
          ),
          BlocProvider(
            create: (_) => BurseMyOrdersCubit(
                RepositoryProvider.of<WalletRepository>(context)),
            lazy: false,
          ),
          BlocProvider(
            create: (_) => CoinsInGameCubit(
                RepositoryProvider.of<WalletRepository>(context)),
            lazy: false,
          ),
          BlocProvider(
            create: (_) => SwapInGameCoinsCubit(
                walletRepository:
                    RepositoryProvider.of<WalletRepository>(context)),
            lazy: false,
          ),
          BlocProvider(
            create: (_) => ProfileReferalsCubit(
                RepositoryProvider.of<UserRepository>(context)),
            lazy: false,
          ),
          BlocProvider(
            create: (_) =>
                StoreBuyCubit(RepositoryProvider.of<StoreRepository>(context)),
            lazy: false,
          ),
          BlocProvider(
            create: (_) => StoreUserItemsCubit(
                RepositoryProvider.of<StoreRepository>(context)),
            lazy: false,
          ),
        ],
        child: StreamAuthScope(
          customNotifier: notifier,
          child: const MyApp(),
        ));
  }
}

class MyRepositoryProviders extends StatelessWidget {
  const MyRepositoryProviders({super.key, required this.notifier});

  final StreamAuthNotifier notifier;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(providers: [
      RepositoryProvider(
          create: (_) => AuthRepository(apiService: api, preferences: prefs)),
      RepositoryProvider(
        create: (_) => UserRepository(apiService: api, preferences: prefs),
      ),
      RepositoryProvider(
        create: (_) => WalletRepository(
            apiService: api, prefs: prefs, apiCripto: ApiCripto()),
      ),
      RepositoryProvider(
        create: (_) => MainScreenRepository(apiService: api),
      ),
      RepositoryProvider(
        create: (_) => GamesRepository(),
      ),
      RepositoryProvider(
        create: (_) => StoreRepository(apiService: api),
      ),
      RepositoryProvider(
          create: (context) =>
              NotificationsRepository(apiService: api, preferences: prefs))
    ], child: MyBlocProviders(notifier));
  }
}
