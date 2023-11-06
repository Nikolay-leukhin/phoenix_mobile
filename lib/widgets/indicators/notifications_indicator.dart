import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:izobility_mobile/routes/go_routes.dart';
import 'package:izobility_mobile/utils/ui/colors.dart';
import 'package:izobility_mobile/utils/ui/fonts.dart';

class NotificationsIndicator extends StatelessWidget {
  const NotificationsIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    const int notificationsCount = 0;

    return SizedBox(
      width: 44,
      height: 48,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () {
                context.push(RouteNames.notifications);
              },
              child: Ink(
                width: 36,
                height: 36,
                padding: const EdgeInsets.all(6),
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 1, color: AppColors.border),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: SvgPicture.asset('assets/icons/notifications.svg'),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: notificationsCount == 0 ? const SizedBox(width: 16, height: 16,) : Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                  color: AppColors.notificationRed,
                  borderRadius: BorderRadius.circular(8)),
              alignment: Alignment.center,
              child: Text(
                notificationsCount.toString() ,
                style: AppTypography.font11w400,
              ),
            ),
          )
        ],
      ),
    );
  }
}
