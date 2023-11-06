import 'package:flutter/material.dart';
import 'package:izobility_mobile/feature/main/ui/widgets/notification_card_container.dart.dart';
import 'package:izobility_mobile/utils/logic/enums.dart';
import 'package:izobility_mobile/utils/utils.dart';

import '../../../../models/notification.dart';


class NotificationTextCard extends StatelessWidget {
  final Notificatian data;
  final NotificationPositionEnum pose;

  const NotificationTextCard({super.key, required this.data, required this.pose});

  @override
  Widget build(BuildContext context) {
    return NotificationCardContainer(
        pose: pose,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Text(
                    data.header,
                    style: AppTypography.font14w700.copyWith(
                      color: AppColors.grey700,
                    ),
                    softWrap: true,
                  ),
                ),
                Text(
                  "${data.dateCreate.hour}:${data.dateCreate.minute}",
                  style: AppTypography.font12w400
                      .copyWith(color: AppColors.grey600),
                )
              ],
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              data.message,
              style: AppTypography.font12w400
                  .copyWith(color: AppColors.grey600),
            )
          ],
        ));
  }
}