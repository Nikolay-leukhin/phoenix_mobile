import 'package:flutter/material.dart';
import 'package:izobility_mobile/utils/ui/colors.dart';
import 'package:izobility_mobile/utils/ui/fonts.dart';

class WalletTransactionContainer extends StatelessWidget {
  final String title;
  final String prise;
  final String address;
  final bool isAddition;

  final VoidCallback onTap;

  const WalletTransactionContainer({
    super.key,
    required this.title,
    required this.prise,
    required this.onTap,
    required this.address,
    required this.isAddition,
  });

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);

    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Ink(
          width: double.infinity,
          height: 64,
          decoration: ShapeDecoration(
              color: AppColors.textContrast,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              )),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 17),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 34,
                      height: 34,
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
                        SizedBox(
                          width: sizeOf.width - 230,
                          child: Text(
                              'На: $address asdfasdfasdasdfasdfasdffasdf',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTypography.font14w400.copyWith(
                                  color: AppColors.disabledTextButton)),
                        ),
                      ],
                    ),
                  ],
                ),
                Text(prise,
                    style: AppTypography.font16w500
                        .copyWith(color: !isAddition ? AppColors.negative : AppColors.positive)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
