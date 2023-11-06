import 'package:flutter/material.dart';
import 'package:izobility_mobile/utils/utils.dart';

class ButtonChooseCoin extends StatelessWidget {
  final String coinName;
  final String imagePath;
  final double width;
  final Function() onTap;

  ButtonChooseCoin({
    super.key,
    required this.coinName,
    required this.imagePath,
    required this.width,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      constraints: const BoxConstraints(minWidth: 128, maxWidth: 300),
      padding: EdgeInsets.zero,
      alignment: Alignment.centerLeft,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.only(left: 18),
          foregroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 2, color: Colors.black),
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        onPressed: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration:  BoxDecoration(borderRadius: BorderRadius.circular(100),),
              clipBehavior: Clip.hardEdge,
              alignment: Alignment.center,
              child: Image.network(
                imagePath,
                width: 24,
                height: 24,
              ),
            ),
            const SizedBox(
              width: 4,
            ),
            Container(
              alignment: Alignment.centerLeft,
              width: width - 72,
              child: Text(
                coinName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.font16w700.copyWith(color: Colors.black),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.black,
              size: 18,
            )
          ],
        ),
      ),
    );
  }
}
