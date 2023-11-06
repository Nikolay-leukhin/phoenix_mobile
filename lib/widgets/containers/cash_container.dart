import 'package:flutter/material.dart';
import '../../utils/utils.dart';

class CashContainer extends StatelessWidget {
  final String text;

  const CashContainer({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        height: 36,
        decoration: ShapeDecoration(
          color: AppColors.backgroundContent,
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 0.50, color: AppColors.border),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Row(
          children: [
            Image.network(
              "https://api.z-boom.ru/media/" +
                  "moneta/22aca8bb1a77d571aff193a7dcb6d2d1.jpg",
              width: 24,
            ),
            const SizedBox(
              width: 4,
            ),
            Text(text,
                style: AppTypography.font16w700
                    .copyWith(color: AppColors.textSecondary))
          ],
        ),
      ),
      onTap: () {},
    );
  }
}
