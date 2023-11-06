part of 'api_service.dart';

class Auth with ApiHandler {
  Auth(
      {required Dio dio_,
      required PreferencesService preferences,
      required Token token}) {
    preferencesService = preferences;
    dio = dio_;
    currentToken = token;
  }

  Future<dynamic> registerUser(String email, String? promo) async {
    final res = await dio.post(ApiEndpoints.register, data: {
      "email": email,
      "promo": promo ?? "",
      "site_id": siteId
    });

    return res;
  }

  Future<dynamic> confirmRegistration(
      {required String confirmCode, required String userId}) async {
    final response = post(ApiEndpoints.confirmRegister,
        data: {"token": confirmCode, "id": userId});

    return response;
  }

  Future<dynamic> login(
      {required String email, required String password}) async {
    final response = await dio.post(ApiEndpoints.login, data: {
      "email": email,
      "password": password,
      "site_id": siteId
    });

    await refreshToken(response.data['jwt']);

    return response.data;
  }

  Future restorePassword({required String email}) async {
    await post(ApiEndpoints.restore, data: {
      "email": email,
      "site_id": siteId
    });
  }

  Future restoreConfirm({required String email, required String code}) async {
    await post(ApiEndpoints.restoreCheck, data: {
      "email": email,
      "token": code,
      "site_id": siteId
    });

    await post(ApiEndpoints.restoreConfirm, data: {
      "email": email,
      "token": code,
      "site_id": siteId,
      "password": code,
      "password_confirm": code
    });
  }

  Future<dynamic> resendVerificationCode({required int userId}) async {
    final res = await post(ApiEndpoints.resendCode, data: {'id': userId});

    return res;
  }
}
