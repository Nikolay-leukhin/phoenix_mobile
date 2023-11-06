import 'package:flutter/material.dart';
import 'package:izobility_mobile/utils/ui/colors.dart';
import 'package:izobility_mobile/utils/ui/fonts.dart';

class CardTransactionContainer extends StatelessWidget {
  final String title;
  final String prise;
  final String secondaryTitle;
  final String usdValue;

  final VoidCallback onTap;

  const CardTransactionContainer(
      {super.key,
      required this.title,
      required this.prise,
      required this.secondaryTitle,
      required this.onTap,
      required this.usdValue});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Ink(
          width: double.infinity,
          decoration: ShapeDecoration(
              color: AppColors.purple100,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              )),
          child: Container(
            padding: EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      padding: const EdgeInsets.all(4),
                      decoration: ShapeDecoration(
                        color: AppColors.backgroundSecondary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: AppTypography.font16w400
                              .copyWith(color: AppColors.textPrimary),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(secondaryTitle,
                            style: AppTypography.font14w400
                                .copyWith(color: AppColors.disabledTextButton))
                      ],
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(prise,
                        style: AppTypography.font16w400
                            .copyWith(color: AppColors.textPrimary)),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(usdValue,
                        style: AppTypography.font12w400
                            .copyWith(color: AppColors.disabledTextButton)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
