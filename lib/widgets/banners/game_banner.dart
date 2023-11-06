import 'package:flutter/material.dart';
import 'package:phoenix_mobile/utils/ui/colors.dart';
import 'package:phoenix_mobile/utils/ui/fonts.dart';
import 'package:phoenix_mobile/utils/ui/gradients.dart';

class GameBanner extends StatelessWidget {
  final Function onClick;

  const GameBanner({super.key, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
          image: const DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                "assets/images/space.png",
              )),
          borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Игротека",
            style: AppTypography.font20w700.copyWith(color: Colors.white),
          ),
          Text(
            "Множетсво игр в AR",
            style: AppTypography.font14w400
                .copyWith(color: AppColors.backgroundGrey),
          ),
          const SizedBox(
            height: 36,
          ),
          InkWell(
            onTap: () {
              onClick();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 4),
              decoration: BoxDecoration(
                gradient: AppGradients.purple,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Играть",
                    style:
                        AppTypography.font14w700.copyWith(color: Colors.white),
                  ),
                  const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 14,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
