part of 'api_service.dart';

class Shop with ApiHandler {
  Shop(
      {required Dio dio_,
      required PreferencesService preferences,
      required Token token}) {
    preferencesService = preferences;
    dio = dio_;
    currentToken = token;
  }

  Future activatePromoCode(String code) =>
      post(ApiEndpoints.usePromoCode, data: {'code': code});

  Future<List> getLimitedItems(int pageSize, int pageNumber) async {
    final res = await get(ApiEndpoints.productsList, queryParameters: {
      'site_id': siteId,
      "page_size": pageSize,
      "page": pageNumber,
    });

    return res['objects'];
  }

  Future<dynamic> getMarketItemInfoById(int id) async {
    final response = await post("${ApiEndpoints.productItemInfo}$id");
    return response;
  }

  Future<dynamic> buyProduct(int productId) async {
    return await post(ApiEndpoints.productBuy, data: {
      'id': productId,
    }, queryParameters: {
      "id": productId
    });
  }

  Future<dynamic> getUserProductList() async {
    return await get(ApiEndpoints.productUserList);
  }

  Future<dynamic> sendRequestForRecievingByMail() {
    throw UnsupportedError(
        "А НУ ДЕЛАЙ ЕПТА АЗАХААХАХА sendRequestForRecievingByMail");
  }
}
