import 'package:izobility_mobile/utils/logic/constants.dart';

class Token {
  String? accessToken;
  String? refreshToken;
  // String? accessTokenExpired;
  // String? refreshTokenExpired;

  Token({required this.accessToken, required this.refreshToken});

  Token.zero()
      : accessToken = null,
        refreshToken = null;

  Token.fromJson(Map<String, dynamic> json)
      : accessToken = json['jwt'],
        refreshToken = json['user']['refresh_token'];



  // accessTokenExpired = json[''],
  // refreshTokenExpired = json[''];

  // bool get accessExpired {
  //   try {
  //     DateTime expiredTime = DateTime.parse(accessTokenExpired!);
  //     expiredTime = expiredTime.add(AppStrings.serverOffset);

  //     final Duration difference = DateTime.now().difference(expiredTime);

  //     return difference.inMinutes >= -1;
  //   } catch (e) {
  //     return true;
  //   }
  // }

  // bool get refreshExpired {
  //   try {
  //     DateTime expiredTime = DateTime.parse(refreshTokenExpired!);
  //     expiredTime = expiredTime.add(AppStrings.serverOffset);

  //     final Duration difference = DateTime.now().difference(expiredTime);

  //     return difference.inMinutes >= -1;
  //   } catch (e) {
  //     return true;
  //   }
  // }
}
