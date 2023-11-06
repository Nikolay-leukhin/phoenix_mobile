import 'dart:developer';

import 'package:izobility_mobile/models/api/token_data.dart';
import 'package:izobility_mobile/models/burse/burse_order.dart';
import 'package:izobility_mobile/services/crypto/api_cripto.dart';
import 'package:izobility_mobile/services/locale/preferences_service.dart';
import 'package:izobility_mobile/services/remote/api/api_service.dart';
import 'package:izobility_mobile/services/remote/constants/api_constants.dart';
import 'package:izobility_mobile/utils/logic/enums.dart';
import 'package:rxdart/subjects.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_ffi.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_lib.dart';

class WalletRepository {
  final ApiService apiService;
  final PreferencesService prefs;
  final ApiCripto apiCripto;

  WalletRepository(
      {required this.apiService, required this.prefs, required this.apiCripto});

  bool obscured = false;

  List<TokenData> coinsInGame = [];
  List<TokenData> coinsInChain = [];

  double emeraldInGameBalance = 0;
  double emeraldInWalletBalance = 0;

  int burseGeneralCurrentPageIndex = 0;
  int burseMyCurrentPageIndex = 0;

  int walletPage = 1;
  TransferTypes transferType = TransferTypes.inGame;

  HDWallet? walletModel;

  double gas = 0.0;

  List<dynamic> ordersGeneralList = [];
  List<dynamic> ordersMyList = [];

  TokenData? activeBurseTokenTo;
  TokenData? activeBurseTokenFrom;

  TokenData? activeSwapTockenTo;
  TokenData? activeSwapTockenFrom;

  BehaviorSubject<LoadingStateEnum> emeraldInGameStream =
      BehaviorSubject.seeded(LoadingStateEnum.wait);

  BehaviorSubject<LoadingStateEnum> emeraldInWalletStream =
      BehaviorSubject.seeded(LoadingStateEnum.wait);

  BehaviorSubject<LoadingStateEnum> burseGeneralOrdersStream =
      BehaviorSubject.seeded(LoadingStateEnum.wait);

  BehaviorSubject<LoadingStateEnum> burseMyOrdersStream =
      BehaviorSubject.seeded(LoadingStateEnum.wait);

  BehaviorSubject<LoadingStateEnum> coinsOnChainStream =
      BehaviorSubject.seeded(LoadingStateEnum.wait);

  BehaviorSubject<LoadingStateEnum> coinsInGameStream =
      BehaviorSubject.seeded(LoadingStateEnum.wait);

  BehaviorSubject<LoadingStateEnum> sendInGameTokenStream =
      BehaviorSubject.seeded(LoadingStateEnum.wait);

// ---------------------------------------

  Future<bool> checkWalletAuth() async {
    final seedPhrase = await prefs.getSeedPhrase();

    return seedPhrase != null;
  }

  Future<void> createWallet() async {
    HDWallet wallet = HDWallet();

    walletModel = wallet;
    print(walletModel);

    await prefs.setSeedPhrase(wallet.mnemonic());
  }

  Future<void> enterWalletBySeedPhrase(String seedPhrase) async {
    HDWallet wallet = HDWallet.createWithMnemonic(seedPhrase);

    walletModel = wallet;
    print(walletModel);

    await prefs.setSeedPhrase(wallet.mnemonic());
  }

  Future<void> clearWallet() async {
    await prefs.clearSeedPhrase();
  }

  Future<void> getWallet() async {
    final seedPhrase = await prefs.getSeedPhrase();

    walletModel = HDWallet.createWithMnemonic(seedPhrase!);
  }

  void setObscured(bool f) {
    obscured = f;
  }

  void setWalletPage(int page) {
    walletPage = page;
  }

  Future<void> getUserEmeraldBill() async {
    emeraldInWalletStream.add(LoadingStateEnum.loading);

    try {
      emeraldInWalletBalance = await apiCripto.getUserCoinBill(
          walletModel!, coinsTransferData['42']!);
      emeraldInWalletStream.add(LoadingStateEnum.success);
    } catch (ex) {
      log(ex.toString());
      emeraldInWalletStream.add(LoadingStateEnum.success);
    }
  }

  Future<void> sendCoinOnChain(
      String address, double amount, int coinId) async {
    final coin = coinsTransferData[coinId.toString()];
    print(coin);
    print(coinId);

    if (coin == null) {
      throw Exception();
    } else if (coinId == 18) {
      await apiCripto.sendBnb(walletModel!, amount, address);
    } else {
      await apiCripto.sendCoinOnChainTo(walletModel!, address, amount, coin);
    }
  }

  Future<void> sendCoinInGame() async {
    // await apiCripto.sendEmeraldTo(walletModel!, address, amount);
  }

  Future<void> swapCoinInGameToOnChain(int coinId, double amount) async {
    await apiService.wallet
        .swapCoinInGameToOnChain(coinId, amount, walletModel!);
  }

  Future<void> swapCoinOnChainToInGame(int coinId, double amount) async {
    final coin = coinsTransferData[coinId.toString()];
    late final String transactionCode;
    print(coin?.name);
    print(coinId);
    if (coinId == 18) {
      transactionCode =
          await apiCripto.sendBnb(walletModel!, amount, techWalletAddress);
    } else if (coin == null) {
      throw Exception("COIN IS NULL swapCoinOnChainToInGame method");
    } else {
      transactionCode = await apiCripto.sendCoinOnChainTo(
          walletModel!, techWalletAddress, amount, coin);
    }
    print("trans_code $transactionCode");
    await apiService.wallet
        .swapCoinOnChainToInGame(coinId, amount, walletModel!, transactionCode);
  }

  Future<void> loadEmeraldCoin() async {
    emeraldInGameStream.add(LoadingStateEnum.loading);
    try {
      final data = await apiService.wallet.getEmeraldCoin();

      emeraldInGameBalance = double.parse(data['balance'].toString());

      emeraldInGameStream.add(LoadingStateEnum.success);
    } catch (e) {
      print(e);
      emeraldInGameStream.add(LoadingStateEnum.fail);
      rethrow;
    }
  }

  Future<void> sendInGameCoinByEmail(
      String email, int amount, int coinId) async {
    await apiService.wallet.sendInGameCoinByEmail(email, amount, coinId);
  }

  Future<void> getOnChainCoinsData() async {
    coinsOnChainStream.add(LoadingStateEnum.loading);

    final List<TokenData> temporatyOnChainCoinDataList = [];
    final List<String> coinsIdList = coinsTransferData.keys.toList();

    for (var coinId in coinsIdList) {
      final coin = coinsTransferData[coinId]!;

      if (coinId == "18") {
        // bnb id
        final bnbBill = await apiCripto.getBnbBill(walletModel!);
        temporatyOnChainCoinDataList.add(TokenData(
            amount: bnbBill.toStringAsFixed(5),
            id: coinId,
            name: coin.name,
            imageUrl: coin.imageUrl,
            url: '',
            rubleExchangeRate: coin.rubleExchangeRate,
            description: coin.description));
      } else {
        final coinBill = await apiCripto.getUserCoinBill(walletModel!, coin);

        temporatyOnChainCoinDataList.add(TokenData(
            amount: coinBill.toStringAsFixed(5),
            id: coinId,
            name: coin.name,
            imageUrl: coin.imageUrl,
            url: '',
            rubleExchangeRate: coin.rubleExchangeRate,
            description: coin.description));
      }
    }

    coinsInChain.clear();
    coinsInChain = temporatyOnChainCoinDataList;

    coinsInChain.sort((item1, item2) =>
        double.parse(item2.amount).compareTo(double.parse(item1.amount)));

    coinsOnChainStream.add(LoadingStateEnum.success);
  }

  Future getGameTokens() async {
    coinsInGameStream.add(LoadingStateEnum.loading);

    try {
      final res = await apiService.wallet.getUserGameTokens();
      coinsInGame.clear();

      for (var json in res) {
        try {
          coinsInGame.add(TokenData.fromJson(json));
        } catch (e) {
          print(e);
        }
      }

      await loadEmeraldCoin();

      final emeraldCoin = TokenData(
          amount: obscured ? "****" : emeraldInGameBalance.toStringAsFixed(5),
          id: "0",
          url: '',
          imageUrl:
              'https://w7.pngwing.com/pngs/967/250/png-transparent-z-letter-font-letter-z-miscellaneous-angle-english.png',
          name: "Z-BOOM",
          rubleExchangeRate: "0",
          description: '');

      coinsInGame.add(emeraldCoin);

      coinsInGame.sort((item1, item2) =>
          double.parse(item2.amount).compareTo(double.parse(item1.amount)));

      activeBurseTokenFrom = coinsInGame[0];
      activeBurseTokenTo = coinsInGame[1];

      activeSwapTockenFrom = coinsInGame[0];
      activeSwapTockenTo = coinsInGame[1];
      coinsInGameStream.add(LoadingStateEnum.success);
    } catch (ex) {
      print("cur_ex $ex");
      coinsInGameStream.add(LoadingStateEnum.fail);
    }
  }

  Future<dynamic> getBurseGeneralItemList(
      int itemsQuantity, int pageNumber) async {
    if (pageNumber == 0) {
      burseGeneralCurrentPageIndex = 0;
      ordersGeneralList.clear();
    }

    burseGeneralOrdersStream.add(LoadingStateEnum.loading);

    try {
      final response = await apiService.wallet
          .getBurseItemList(BurseOrderType.general, itemsQuantity, pageNumber);

      final responseItems = response['objects'];

      for (var json in responseItems) {
        try {
          ordersGeneralList.add(BurseOrderModel.fromJson(json));

          burseGeneralCurrentPageIndex += 1;
        } catch (e) {
          print(e);
          continue;
        }
      }

      burseGeneralOrdersStream.add(LoadingStateEnum.success);
    } catch (ex) {
      burseGeneralOrdersStream.add(LoadingStateEnum.fail);
    }
  }

  Future<dynamic> getBurseMyItemList(int itemsQuantity, int pageNumber) async {
    if (pageNumber == 0) {
      burseMyCurrentPageIndex = 0;
      ordersMyList.clear();
    }
    burseGeneralOrdersStream.add(LoadingStateEnum.loading);

    try {
      final response = await apiService.wallet
          .getBurseItemList(BurseOrderType.my, itemsQuantity, pageNumber);

      for (var json in response['objects']) {
        try {
          ordersMyList.add(BurseOrderModel.fromJson(json));

          burseMyCurrentPageIndex += 1;
        } catch (e) {
          print("cur_ex $e");
          continue;
        }
      }
      print(ordersMyList);

      burseMyOrdersStream.add(LoadingStateEnum.success);
    } catch (ex) {
      print("getBurseMyItemList $ex");
      burseMyOrdersStream.add(LoadingStateEnum.fail);
    }
  }

  Future<void> createBurseOrder(int amountFrom, int amountTo) async {
    await apiService.wallet.createBurseOrder(
        amountFrom, amountTo, activeBurseTokenFrom!.id, activeBurseTokenTo!.id);
  }

  Future<void> buyBurseOrder(int orderId) async {
    await apiService.wallet.buyBurseOrder(orderId);
  }

  Future<void> canselBurseOrder(int orderId) async {
    await apiService.wallet.canselBurseOrder(orderId);
  }

  void setActiveBurseTokenFrom(TokenData r) {
    activeBurseTokenFrom = r;
  }

  void setActiveBurseTokenTo(TokenData r) {
    activeBurseTokenTo = r;
  }

  void setActiveSwapTokenFrom(TokenData r) {
    activeSwapTockenFrom = r;
  }

  void setActiveSwapTokenTo(TokenData r) {
    activeSwapTockenTo = r;
  }

  void loadGas() async {
    final gasLimit = await ApiCripto.clientBSC.estimateGas();

    final gasPrice = await ApiCripto.clientBSC.getGasPrice();

    gas = (gasPrice.getInWei * gasLimit / BigInt.from(1000000000000000000))
            .toDouble() *
        0.97865;
  }

  Future<void> swapInGameCoins(int amount, int idToCoin, int idFromCoin) async {
    await apiService.wallet.swapInGameCoins(amount, idToCoin, idFromCoin);
  }

  Future<void> getCoinOperations(String coinAddress) async {
    final operationList = await apiService.wallet.getCoinOperations(
        walletModel!.getAddressForCoin(TWCoinType.TWCoinTypeSmartChain),
        coinAddress);

    print("OPERATION LIST---------------- \n  ${operationList}");
  }
}
