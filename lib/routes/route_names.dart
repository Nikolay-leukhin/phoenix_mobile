part of 'go_routes.dart';

abstract class RouteNames {
  static const root = '/';

  static const splash = '/splash';

  static const String home = "/home";

  static const String auth = "/auth";

  static const String authCreatePasswordBaseLink = '/auth/password_create';

  static const String authCreatePassword = "/auth/password_create/create";
  static const String authCreatePin = "/auth/pin_create";
  static const String authCreateName = "/auth/name_create";

  static const String authEnterPassword = "/auth/password_enter";
  static const String authEnterPin = "/auth/pin_enter";

  static const String authPasswordRecoveryEmail =
      '/auth/password_recovery_email';
  static const String authPasswordRecoveryVerifyCode =
      '/auth/password_recovery_verify';
  static const String authPasswordRecoveryChangePassword =
      '/auth/password_create/change';

  static const String wallet = '/wallet';
  static const String walletCurrency = '/wallet/currency';
  static const String walletInfoCurrency = '/wallet/currency/info';
  static const String walletSwap = '/wallet/swap';
  static const String walletSendOnChainCoin =
      '/wallet/send_in_game_coin_currency';
  static const String walletSendInGameCoin =
      '/wallet/send_on_chain_coin_currency';
  static const String walletReplenish = '/wallet/replenish';
  static const String walletChooseCoin = '/wallet/choose_coin';
  static const String walletBuyCurrency = '/wallet/buy';
  static const String walletViewSeed = '/wallet/seed/view';
  static const String walletAuth = '/wallet/auth';
  static const String walletSetting = '/wallet/setting';
  static const String walletEnterSeedPhrase = '/wallet/enter/seed_phrase';
  static const String walletChainGameTransfer = '/wallet/chain_game_transfer';

  static const String walletBurse = '/wallet/burse';
  static const String walletBurseBuyOrder = '/wallet/burse/order/buy';
  static const String walletBurseCreateOrder = '/wallet/burse/order/create';
  static const String walletBurseHistory = '/wallet/burse/history';
  static const String walletBurseChooseCoin = '/wallet/choose/coin';
  static const String walletBurseMyOrder = '/wallet/burse/order/my';
  static const String walletBurseCreateOrderSuccess =
      '/wallet/burse/order/create/success';

  static const String profile = '/profile';

  static const String profileEdit = '/profile/edit';
  static const String profileInventory = '/profile/inventory';
  static const String profileSettings = '/profile/settings';
  static const String profileAbout = '/profile/about';
  static const String profileLanguage = '/profile/lang';
  static const String profilePhone = '/profile/phone';
  static const String profilePhoneConfirm = '/profile/phone/confirm';
  static const String profilePrivacyPolicy = "/profile/privacy_policy";
  static const String profileReferal = "/pofile/referal";

  static const String notifications = '/notifications';

  static const String story = '/story';

  static const String main = '/main';
  static const String mainQr = '/qr';

  static const String basket = '/basket';

  static const String cards = '/cards';

  static const String cardsAdd = '/cards/add';

  static const String games = '/games';
  static const String gamesDetails = '/games/:game_id';
  static const String gamesDetailsLoading = '/games/:game_id/loading';

  static const String store = '/store';
  static const String storeProduct = '/store/:id';
  static const String storePromo = '/store/promo';
  static const String storeUserProducts = '/store/user/products';

  static const String develop = '/develop';
}
