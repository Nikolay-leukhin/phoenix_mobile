import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:izobility_mobile/models/city_history_item.dart';
import 'package:izobility_mobile/utils/ui/colors.dart';
import 'package:izobility_mobile/utils/ui/fonts.dart';

class HistoryItem extends StatelessWidget {
  const HistoryItem({super.key, required this.data});

  final CityHistoryItem data;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 64,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
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
            Image.asset('assets/main_coin.png', width: 24, height: 24, fit: BoxFit.cover,)
          ] else ... [
            SvgPicture.asset('assets/icons/clock.svg', color: Colors.black, width: 24, height: 24,)
          ]
        ],
      ),
    );
  }
}
