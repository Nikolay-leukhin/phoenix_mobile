import 'package:izobility_mobile/models/market_item.dart';
import 'package:izobility_mobile/utils/logic/enums.dart';
import 'package:rxdart/rxdart.dart';

import '../../../models/story.dart';
import '../../../services/remote/api/api_service.dart';


class MainScreenRepository {
  final ApiService apiService;

  MainScreenRepository({required this.apiService});

  List<MarketItemModel> marketItems = [];
  List<Story> storiesList = [];
  String bannerUrl = '';

  BehaviorSubject<LoadingStateEnum> loadingState =
      BehaviorSubject.seeded(LoadingStateEnum.wait);

  Future<void> getPreview() async {
    loadingState.add(LoadingStateEnum.loading);
    try {
      await getStories();
      await getMarketItems();
      loadingState.add(LoadingStateEnum.success);
    } catch (e) {
      loadingState.add(LoadingStateEnum.fail);
    }
  }

  Future getStories() async {
    final res = await apiService.news.getNews();

    storiesList.clear();

    for (int i = 0; i < res.length; i++) {
      storiesList.add(Story.fromJson(json: res[i], index: i));
    }
  }
  Future getMarketItems() async {
    final res = await apiService.shop.getLimitedItems(10, 0);

    marketItems.clear();

    for (int i = 0; i < res.length; i++) {
      try{
        marketItems.add(MarketItemModel.fromJson(res[i]));
      }catch (ex){}
    }
  }
}
