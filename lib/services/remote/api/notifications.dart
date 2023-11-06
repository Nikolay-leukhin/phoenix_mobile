part of 'api_service.dart';

class NotificationsApi with ApiHandler {
  NotificationsApi(
      {required Dio dio_,
      required PreferencesService preferences,
      required Token token}) {
    preferencesService = preferences;
    dio = dio_;
    currentToken = token;
  }

  Future<dynamic> loadNotifications() async {
    final response = await get(ApiEndpoints.getNotifications);

    return response;
  }
}
