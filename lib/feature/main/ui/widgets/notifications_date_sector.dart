import 'package:flutter/material.dart';
import 'package:izobility_mobile/feature/main/ui/widgets/date_container.dart';
import 'package:izobility_mobile/feature/main/ui/widgets/notification_coin_card.dart';
import 'package:izobility_mobile/feature/main/ui/widgets/notification_text_card.dart';
import 'package:izobility_mobile/models/notification_by_date.dart';
import 'package:izobility_mobile/utils/logic/constants.dart';
import 'package:izobility_mobile/utils/logic/enums.dart';
import 'package:sliver_tools/sliver_tools.dart';

class NotificationsDateSector extends StatelessWidget {
  final NotificationsByDate notificationsByDate;

  const NotificationsDateSector({super.key, required this.notificationsByDate});

  @override
  Widget build(BuildContext context) {
    return MultiSliver(
      pushPinnedChildren: true,
      children: [
        SliverPinnedHeader(
            child: DateText(
          date:
              "${notificationsByDate.dateCreate.day} ${AppStrings.months[notificationsByDate.dateCreate.month.toString()]}",
        )),
        SliverList.separated(
            itemCount: notificationsByDate.notifications.length,
            separatorBuilder: (context, index) => const SizedBox(
                  height: 5,
                ),
            itemBuilder: (context, index) {
              NotificationPositionEnum cardPose = NotificationPositionEnum.mid;

              if (index == 0 && notificationsByDate.notifications.length != 1) {
                cardPose = NotificationPositionEnum.start;
              } else if (index == notificationsByDate.notifications.length - 1) {
                cardPose = NotificationPositionEnum.end;
              }
              return NotificationTextCard(
                pose: cardPose,
                data: notificationsByDate.notifications[index],
              );
            }),
      ],
    );
  }
}
