import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:izobility_mobile/utils/ui/fonts.dart';
import 'package:izobility_mobile/utils/ui/colors.dart';

class UtilityContainer extends StatelessWidget {
  const UtilityContainer({
    super.key,
    required this.name,
    required this.assetName,
    required this.callback,
  });

  final String assetName;
  final String name;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    final width = (MediaQuery.sizeOf(context).width - 48) / 3;
    final BorderRadius radius = BorderRadius.circular(16);
    return InkWell(
      borderRadius: radius,
      splashColor: Colors.grey[100],
      onTap: callback,
      child: Ink(
        width: width,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: radius,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: SvgPicture.asset(
                assetName,
                color: AppColors.textPrimary,
                width: 32,
                height: 32,
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            Text(name,
                textAlign: TextAlign.center,
                style:
                    AppTypography.font14w400.copyWith(color: Colors.black))
          ],
        ),
      ),
    );
  }
}
