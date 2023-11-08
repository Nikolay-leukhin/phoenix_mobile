import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phoenix_mobile/routes/go_routes.dart';
import 'package:phoenix_mobile/utils/ui/colors.dart';
import 'package:phoenix_mobile/utils/ui/fonts.dart';
import 'package:phoenix_mobile/utils/ui/gradients.dart';

class ImproveCityBanner extends StatelessWidget {
  const ImproveCityBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Container(
      padding: const EdgeInsets.only(left: 12),
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: AppGradients.accentGreen,
           borderRadius: BorderRadius.circular(16)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: size.width * 0.5 + 12,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Улучши свой город",
                  style: AppTypography.font20w700.copyWith(color: Colors.white),
                ),
                Text(
                  "Помоги городу стать лучше и зарабатывай",
                  style: AppTypography.font14w400
                      .copyWith(color: AppColors.backgroundGrey),
                ),
                const SizedBox(
                  height: 12,
                ),
                InkWell(
                  onTap: () {
                    context.go(RouteNames.games);
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 26, vertical: 4),
                    decoration: BoxDecoration(
                      gradient: AppGradients.purple,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Начать",
                          style: AppTypography.font14w700
                              .copyWith(color: Colors.white),
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
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Image.asset(
              "assets/images/city_tower.png",
              height: 129,
              fit: BoxFit.fitHeight,
            ),
          )
        ],
      ),
    );
  }
}
