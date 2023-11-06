import 'package:izobility_mobile/models/referal.dart';
import 'package:izobility_mobile/models/user.dart';
import 'package:izobility_mobile/models/user_details.dart';
import 'package:izobility_mobile/services/locale/preferences_service.dart';
import 'package:izobility_mobile/services/remote/api/api_service.dart';
import 'package:izobility_mobile/utils/logic/enums.dart';
import 'package:rxdart/rxdart.dart';

class UserRepository {
  UserRepository({required this.apiService, required this.preferences}) {}

  final ApiService apiService;
  final PreferencesService preferences;

  UserModel user = UserModel();

  List<ReferalModel> referalList = [];

  BehaviorSubject<LoadingStateEnum> userDetailsDataStream =
      BehaviorSubject.seeded(LoadingStateEnum.wait);

  Future<void> loadUserDataFromCache() async {
    final cachedUser = await preferences.getUser();
    user = cachedUser!;
  }

  Future<dynamic> loadUserDetailsInfo() async {
    userDetailsDataStream.add(LoadingStateEnum.loading);

    final UserModel? cachedUser = await preferences.getUser();

    print("~`~~~~~~~~~~~changed user ~~~~~~~~~~");
    print(cachedUser);
    print("~`~~~~~~~~~~~changed user ~~~~~~~~~~");

    if (cachedUser == null) {
      userDetailsDataStream.add(LoadingStateEnum.fail);
      return null;
    }
    try {
      final response =
          await apiService.user.getUserDetailsInfo(userId: cachedUser.id!);

      final UserDetailsModel userDetails = UserDetailsModel.fromJson(response);

      user = cachedUser;
      user.details = userDetails;

      await preferences.setUser(user);

      userDetailsDataStream.add(LoadingStateEnum.success);
    } catch (ex) {
      print(ex);

      userDetailsDataStream.add(LoadingStateEnum.fail);
    }
  }

  void setLanguage(String countryCode) async {
    preferences.setLanguage(countryCode);
  }

  Future<String> getLanguage() async {
    return await preferences.getLanguage() ?? 'en';
  }

  Future<void> updateUserData({
    required String name,
    required String surname,
    required int gender,
    required String birthday,
  }) async {
    await apiService.user.updateUserData(
        name: name, surname: surname, gender: gender, birthday: birthday);
  }

  Future<dynamic> validateUserPhone(
      String countryCode, String phoneNumber) async {
    final response = await apiService.user
        .validateUserPhone(countryCode, phoneNumber, user.id!);
    return response;
  }

  Future<dynamic> validatePhoneCode(String code) async {
    await apiService.user.validatePhoneCode(code);
  }

  Future<dynamic> updatePhoto(String photoInBase64) async {
    await apiService.user.updatePhoto(photoInBase64);

    await loadUserDetailsInfo();
  }

  Future<dynamic> loadReferalsList() async {
    dynamic parseReferals(ReferalModel referal) {
      referalList.add(referal);

      for (var item in referal.referalList) {
        parseReferals(item);
      }
    }

    referalList.clear();

    final response = (await apiService.user.getReferalList())['objects'];
    final List<ReferalModel> parsedReferals = [];

    for (var json in response) {
      parsedReferals.add(ReferalModel.fromJson(json, 1));
    }

    for (var item in parsedReferals) {
      parseReferals(item);
    }
  }
}
