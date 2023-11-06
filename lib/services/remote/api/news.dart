part of 'api_service.dart';

class News with ApiHandler {
  News(
      {required Dio dio_,
      required PreferencesService preferences,
      required Token token}) {
    preferencesService = preferences;
    dio = dio_;
    currentToken = token;
  }

  Future<List> getNews() async {
    final res = await get(ApiEndpoints.newsList, queryParameters: {
      'site_id': siteId,
    });

    return res['objects'];
  }
}
