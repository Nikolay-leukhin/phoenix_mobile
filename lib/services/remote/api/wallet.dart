part of 'api_service.dart';

class Wallet with ApiHandler {
  Wallet(
      {required Dio dio_,
      required PreferencesService preferences,
      required Token token}) {
    preferencesService = preferences;
    dio = dio_;
    currentToken = token;
  }

  Future getUserGameTokens() async {
    final res = await get(ApiEndpoints.userGameTokens, data: {
      'site_id': siteId,
    });
    return res['objects'];
  }

  Future<dynamic> getEmeraldCoin() async {
    return await get(
      ApiEndpoints.wallet,
    );
  }

  Future<void> swapCoinInGameToOnChain(
      int coinId, double amount, HDWallet wallet) async {
    await post(ApiEndpoints.walletSwapInGameToOnChain, data: {
      'moneta_id': coinId,
      'amount': amount,
      'wallet': wallet.getAddressForCoin(TWCoinType.TWCoinTypeSmartChain),
    });
  }

  Future<void> swapCoinOnChainToInGame(int coinId, double amount,
      HDWallet wallet, String transactionCode) async {
    await post(ApiEndpoints.walletSwapOnChainToInGame, data: {
      'moneta_id': coinId,
      'amount': amount,
      'wallet': wallet.getAddressForCoin(TWCoinType.TWCoinTypeSmartChain),
      'trx': transactionCode,
      'site_id': siteId
    });
    print("trans $transactionCode");
    print("done---------------------- trx transfer");
  }

  Future<dynamic> getBurseItemList(
      BurseOrderType type, int itemsQuantity, int pageNumber) async {
    final response = await post(ApiEndpoints.burseOrdersList, queryParameters: {
      "isMy": type == BurseOrderType.my,
      "page_size": itemsQuantity,
      "page": pageNumber
    });
    return response;
  }

  Future<void> createBurseOrder(int amountFrom, int amountTo,
      String monetIdFrom, String monetIdTo) async {
    final response = await post(ApiEndpoints.burseCreateOrder, data: {
      "amount_from": amountFrom,
      "amount_to": amountTo,
      "monet_from": monetIdFrom,
      "monet_to": monetIdTo
    });
  }

  Future<void> buyBurseOrder(int orderId) async {
    print("order_id $orderId");
    final response =
        await post(ApiEndpoints.burseBuyOrder, data: {"id": orderId});
  }

  Future<void> canselBurseOrder(int orderId) async {
    final response =
        await post(ApiEndpoints.burseCancelOrder, data: {"id": orderId});
  }

  Future<void> sendInGameCoinByEmail(
      String email, int amount, int idCoin) async {
    await post(ApiEndpoints.walletSendInGameCoin,
        data: {"amount": amount, "email": email, "moneta_id": idCoin});
  }

  Future<void> swapInGameCoins(int amount, int idToCoin, int idFromCoin) async {
    await post(ApiEndpoints.walletSwapCoins, data: {
      "amount": amount,
      "monet_from": idFromCoin,
      "monet_to": idToCoin
    });
  }

  Future<dynamic> getCoinOperations(
      String walletAddress, String tokenAddress) async {
    final response = await post(ApiEndpoints.walletTransactionList,
        data: {'wallet': walletAddress, 'address': tokenAddress});

    return response;
  }
}
