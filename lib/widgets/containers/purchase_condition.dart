import 'package:flutter/cupertino.dart';

import '../../models/api/coin_data.dart';
import '../../utils/ui/colors.dart';
import '../../utils/ui/fonts.dart';

class PurchaseCondition extends StatelessWidget {
  const PurchaseCondition({super.key, required this.data});

  final CoinPreviewData data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 2),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.network(
            data.imageUrl,
            width: 16,
            height: 16,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            width: 2,
          ),
          Text(
            data.value,
            style: AppTypography.font14w700.copyWith(color: AppColors.purple600),
          ),
        ],
      ),
    );
  }
}
