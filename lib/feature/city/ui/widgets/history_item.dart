import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:phoenix_mobile/models/city_history_item.dart';
import 'package:phoenix_mobile/routes/go_routes.dart';
import 'package:phoenix_mobile/utils/ui/colors.dart';
import 'package:phoenix_mobile/utils/ui/fonts.dart';

class HistoryItem extends StatelessWidget {
  const HistoryItem({super.key, required this.data});

  final CityHistoryItem data;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push('${RouteNames.cityAppeal}/${data.id}');
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        width: double.infinity,
        height: 64,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.white),
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Заявка №${data.id}',
                  style: AppTypography.font16w400.copyWith(color: Colors.black),
                ),
                Text(
                  data.fulfilled ? 'Исполнено' : 'Проблема ещё не решена',
                  style: AppTypography.font12w400
                      .copyWith(color: AppColors.disabledTextButton),
                )
              ],
            ),
            const Spacer(),
            if (data.fulfilled)...[
              Text('+${data.reward}', style: AppTypography.font16w700.copyWith(color: AppColors.primary),),
              const SizedBox(width: 4,),
              Image.asset('assets/images/main_coin.png', width: 24, height: 24, fit: BoxFit.cover,)
            ] else ... [
              SvgPicture.asset('assets/icons/clock.svg', color: Colors.black, width: 24, height: 24,)
            ]
          ],
        ),
      ),
    );
  }
}
