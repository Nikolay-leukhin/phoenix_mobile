import 'package:izobility_mobile/models/notification.dart';
import 'package:izobility_mobile/models/notification_by_date.dart';
import 'package:izobility_mobile/services/locale/preferences_service.dart';
import 'package:izobility_mobile/services/remote/api/api_service.dart';

class NotificationsRepository {
  final ApiService apiService;
  final PreferencesService preferences;

  final List<String> filterCategories = [
    'Все',
    'Покупка',
    'Продажа',
    'Акция',
  ];

  int currentFilterIndex = 0;

  List<dynamic> rawNotificationList = [];

  List<dynamic> sortedByCategoryNotificationList = [];

  List<NotificationsByDate> notificationsByDates = [];

  NotificationsRepository(
      {required this.apiService, required this.preferences});

  Future<dynamic> loadNotificationList() async {
    final rawNotifications = (await apiService.notifications.loadNotifications()
        as Map<String, dynamic>)['objects'] as Map<String, dynamic>;

    notificationsByDates.clear();

    var c = 0;
    rawNotifications.forEach((key, value) {
      c+=1;
      var date = DateTime.parse(key.split('.').reversed.toList().join('-'));

      List<Notificatian> list = [];
      for (var i in (value['items'] as List<dynamic>)) {
        var times = i['time'].toString().split(':');

        date = date.copyWith(minute: int.parse(times[1]),hour: int.parse(times[0]));
        list.add(Notificatian.fromJson(i, date));
      }

      NotificationsByDate notificationByDate = NotificationsByDate(
          dateCreate: date, notifications: list);

      notificationsByDates.add(notificationByDate);
    });
  }
}
