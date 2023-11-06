import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:izobility_mobile/utils/ui/colors.dart';
import 'package:izobility_mobile/utils/ui/fonts.dart';
import 'package:izobility_mobile/widgets/button_sheet/custom_buttom_sheet.dart';

class CreditCardWidget extends StatelessWidget {
  const CreditCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    void showBottomSheetBuy() async {
      await showModalBottomSheet<void>(
        isScrollControlled: true,
        context: context,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(16),
          ),
        ),
        builder: (BuildContext context) {
          return const CardButtonSheet();
        },
      );
    }

    final sizeof = MediaQuery.sizeOf(context);

    return InkWell(
      onTap: () {
        showBottomSheetBuy();
      },
      child: Container(
        width: sizeof.width - 40,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset('assets/icons/tinkoff.svg'),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      child: Text(
                        '3 753 ₽',
                        style: AppTypography.font24w700.copyWith(color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/Mastercard.svg',
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          '... 5623',
                          style:
                              AppTypography.font16w400.copyWith(color: Colors.white),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text('основная',style: AppTypography.font14w400,),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
