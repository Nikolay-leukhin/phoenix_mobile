import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:izobility_mobile/utils/logic/enums.dart';

class NotificationCardContainer extends StatelessWidget {
  final NotificationPositionEnum pose;
  final Widget child;

  const NotificationCardContainer(
      {super.key, required this.child, required this.pose});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        pose == NotificationPositionEnum.end
            ? Image.asset('assets/images/logo_coint_emrld.png', width: 28, height: 28,)
            : const SizedBox(
                width: 28,
              ),
        const SizedBox(
          width: 4,
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: pose == NotificationPositionEnum.start
                    ? const Radius.circular(16)
                    : const Radius.circular(4),
                topRight: pose == NotificationPositionEnum.start
                    ? const Radius.circular(16)
                    : const Radius.circular(4),
                bottomLeft: pose == NotificationPositionEnum.end
                    ? const Radius.circular(16)
                    : const Radius.circular(4),
                bottomRight: pose == NotificationPositionEnum.end
                    ? const Radius.circular(16)
                    : const Radius.circular(4),
              ),
              color: Colors.white),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          width: MediaQuery.sizeOf(context).width * 0.82222,
          child: child,
        )
      ],
    );
  }
}
