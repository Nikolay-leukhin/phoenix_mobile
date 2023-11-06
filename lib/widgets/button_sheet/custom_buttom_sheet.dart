import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:izobility_mobile/utils/ui/colors.dart';
import 'package:izobility_mobile/utils/ui/fonts.dart';

class CardButtonSheet extends StatefulWidget {
  const CardButtonSheet({super.key});

  @override
  State<CardButtonSheet> createState() => _CardButtonSheetState();
}

class _CardButtonSheetState extends State<CardButtonSheet> {
  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);

    return SizedBox(
      height: 120,
      width: sizeOf.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                children: [
                  SvgPicture.asset('assets/icons/verified.svg',color: Colors.black,),
                  const SizedBox(width: 16,),
                  Text('Сделать основной', style: AppTypography.font18w600.copyWith(color: Colors.black, fontWeight: FontWeight.w400),),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                children: [
                  SvgPicture.asset('assets/icons/trash_bin.svg'),
                  const SizedBox(width: 16,),
                  Text('Сделать основной', style: AppTypography.font18w600.copyWith(color: Colors.black, fontWeight: FontWeight.w400),),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
