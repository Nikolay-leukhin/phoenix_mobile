part of 'api_service.dart';

class User with ApiHandler {
  User(
      {required Dio dio_,
      required PreferencesService preferences,
      required Token token}) {
    preferencesService = preferences;
    dio = dio_;
    currentToken = token;
  }

  Future<dynamic> getUserDetailsInfo({required int userId}) async {
    final response = await dio.get(
      "${ApiEndpoints.userInfo}${userId}",
      options: Options(
        headers: {
          'Authorization': 'Bearer ${currentToken.accessToken}',
          'Content-Type': "application/json",
        },
      ),
    );
    return response.data;
  }

  Future<dynamic> updateUserData({
    required String name,
    required String surname,
    required int gender,
    required String birthday,
  }) async {
    if (name != "" && surname != "") {
      final responseUpdateName = await post(ApiEndpoints.userUpdateName, data: {
        "fam": surname.toString(),
        "name": name.toString(),
        "otch": "",
      });
    }

    final responseUpdateBirthDay = await post(ApiEndpoints.userUpdateBirthday,
        data: {"date_birth": birthday});

    final responseUpdateGender =
        await post(ApiEndpoints.userUpdateGender, data: {"gender": gender});
  }

  Future<dynamic> validateUserPhone(
      String countryCode, String phoneNumber, int userId) async {
    final response = await post(ApiEndpoints.userValidatePhone, data: {
      'phone': phoneNumber,
      'phone_country': countryCode,
      'site_id': siteId
    });
    return response;
  }

  Future<void> validatePhoneCode(String code) async {
    await post(ApiEndpoints.userValiddatePhoneCode, data: {"code": code});
  }

  Future<void> updatePhoto(String photoInBase64) async {
    await post(ApiEndpoints.userUpdatePhoto, data: {"image": photoInBase64});
  }

  Future<dynamic> getReferalList() async {
    return get(ApiEndpoints.userReferals);
  }
}
