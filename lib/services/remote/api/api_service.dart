import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:izobility_mobile/models/api/token.dart';
import 'package:izobility_mobile/services/locale/preferences_service.dart';
import 'package:dio/dio.dart';
import 'package:izobility_mobile/services/remote/constants/api_constants.dart';
import 'package:izobility_mobile/services/remote/constants/api_endpoints.dart';
import 'package:izobility_mobile/utils/logic/enums.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_ffi.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_lib.dart';

part 'handler.dart';

part 'auth.dart';
part 'wallet.dart';
part "user.dart";
part 'news.dart';
part 'shop.dart';
part 'notifications.dart';

const Map<String, dynamic> _authHeaders = {
  'Content-Type': 'application/json',
};

BaseOptions dioOptions = BaseOptions(
  baseUrl: dotenv.get('BASE_SERVER_URL'),
  headers: _authHeaders,
  connectTimeout: const Duration(seconds: 15),
  receiveTimeout: const Duration(seconds: 20),
  sendTimeout: const Duration(seconds: 15),
);

class ApiService {
  final PreferencesService preferencesService;
  final Dio dio = Dio(dioOptions)..interceptors.add(PrettyDioLogger());

  late final Token token;
  late final Auth auth;
  late final Wallet wallet;
  late final User user;
  late final News news;
  late final Shop shop;
  late final NotificationsApi notifications;

  ApiService({required this.preferencesService}) {
    initialServices();
  }

  void initialServices() async {
    token = await preferencesService.getToken() ?? Token.zero();

    log(token.accessToken.toString());

    wallet = Wallet(dio_: dio, preferences: preferencesService, token: token);
    auth = Auth(dio_: dio, preferences: preferencesService, token: token);
    news = News(dio_: dio, preferences: preferencesService, token: token);
    shop = Shop(dio_: dio, preferences: preferencesService, token: token);
    user = User(dio_: dio, preferences: preferencesService, token: token);
    notifications = NotificationsApi(
        dio_: dio, preferences: preferencesService, token: token);

    auth.refreshToken(token.accessToken ?? '');
  }

  Future<void> logout() async {
    await preferencesService.logout();
    auth.refreshToken('');
  }
}
