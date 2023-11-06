import 'package:izobility_mobile/feature/profile/data/user_repository.dart';
import 'package:izobility_mobile/models/market_item.dart';
import 'package:izobility_mobile/models/store/user_product.dart';
import 'package:izobility_mobile/services/remote/api/api_service.dart';
import 'package:izobility_mobile/utils/logic/enums.dart';
import 'package:izobility_mobile/widgets/containers/market_Item.dart';
import 'package:rxdart/rxdart.dart';

enum CategoryEnum { promos, gifts, products }

class StoreRepository {
  final ApiService apiService;

  late MarketItemModel lastOpenedMarketItem;

  StoreRepository({required this.apiService});

  CategoryEnum activeCategory = CategoryEnum.products;

  List<MarketItemModel> marketItems = [];
  List<dynamic> giftsList = [];
  List<dynamic> promoCodeList = [];

  int pageNumber = 1;

  List<UserProductModel> userProductList = [];

  BehaviorSubject<LoadingStateEnum> marketItemsStream =
      BehaviorSubject.seeded(LoadingStateEnum.wait);

  BehaviorSubject<LoadingStateEnum> userProductListStream =
      BehaviorSubject.seeded(LoadingStateEnum.wait);

  void setActiveCategory(CategoryEnum category) {
    activeCategory = category;
  }

  Future getMarketItems() async {
    marketItemsStream.add(LoadingStateEnum.loading);

    try {
      final res = await apiService.shop.getLimitedItems(10, pageNumber);

      if (pageNumber == 1) {
        marketItems.clear();
      }

      for (int i = 0; i < res.length; i++) {
        try {
          marketItems.add(MarketItemModel.fromJson(res[i]));
        } catch (ex, stackTrace) {
          print(ex);
          print(stackTrace);
        }
      }

      marketItemsStream.add(LoadingStateEnum.success);
    } catch (e) {
      marketItemsStream.add(LoadingStateEnum.fail);
    }
  }

  Future<MarketItemModel?> getMarketItemInfoById(int id) async {
    try {
      final response = await apiService.shop.getMarketItemInfoById(id);

      final MarketItemModel marketItem = MarketItemModel.fromJson(response);

      return marketItem;
    } catch (ex, stacktrace) {
      print(ex);
      print(stacktrace);
      return null;
    }
  }

  void setPageNumber(int number) {
    pageNumber = number;

    getMarketItems();
  }

  Future<dynamic> buyProduct(int productId) async {
    final response = await apiService.shop.buyProduct(productId);

    getUserProductList();
  }

  Future<dynamic> getUserProductList() async {
    userProductListStream.add(LoadingStateEnum.loading);

    try {
      final response = (await apiService.shop.getUserProductList())['objects'];
      userProductList.clear();

      for (var json in response) {
        userProductList.add(UserProductModel.fromJson(json));
      }

      userProductListStream.add(LoadingStateEnum.success);
    } catch (ex, stacktrace) {
      print(stacktrace);
      userProductListStream.add(LoadingStateEnum.fail);
    }
  }

  Future<dynamic> sendRequestForReceivingByMail() async {
    final response = await apiService.shop.sendRequestForRecievingByMail();
  }
}
