import 'package:flutter/material.dart';
import 'package:izobility_mobile/utils/ui/fonts.dart';

class GamesDetialsStatsCard extends StatelessWidget {
  const GamesDetialsStatsCard({
    super.key,
    required this.label,
    required this.description,
  });

  final String label;
  final String description;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Container(
      alignment: Alignment.center,
      width: size.width * 0.2111,
      child: Column(children: [
        Text(
          label.toString(),
          style: AppTypography.font18w700.copyWith(color: Colors.black),
          textAlign: TextAlign.center,
        ),
        Text(
          description,
          style: AppTypography.font12w400.copyWith(color: Colors.black),
          textAlign: TextAlign.center,
        ),
      ]),
    );
  }
}
