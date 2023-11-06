import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:izobility_mobile/feature/store/data/store_repository.dart';
import 'package:izobility_mobile/utils/logic/constants.dart';
import 'package:izobility_mobile/utils/ui/colors.dart';
import 'package:izobility_mobile/utils/ui/fonts.dart';

class ContainerWithText extends StatelessWidget {
  const ContainerWithText(
      {super.key,
      required this.title,
      required this.path,
      required this.width,
      this.onTap});

  final String title;
  final String path;
  final double width;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final walletRepository = RepositoryProvider.of<StoreRepository>(context);

    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Container(
        clipBehavior: Clip.hardEdge,
        width: width,
        height: 55,
        decoration: BoxDecoration(
            color: AppStrings.shopPage[walletRepository.activeCategory] == path
                ? AppColors.lightGreen
                : Colors.black.withOpacity(0.03),
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/icons/$path.svg',
              width: 25,
              height: 25,
              color: Colors.black,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              title,
              style: AppTypography.font18w700.copyWith(color: Colors.black),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
