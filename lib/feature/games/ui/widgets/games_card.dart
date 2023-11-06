import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:izobility_mobile/localization/app_localizations.dart';
import 'package:izobility_mobile/models/game.dart';
import 'package:izobility_mobile/routes/go_routes.dart';
import 'package:izobility_mobile/utils/utils.dart';

class GamesCard extends StatefulWidget {
  final GameModel game;

  const GamesCard({super.key, required this.game});

  @override
  State<GamesCard> createState() => GamesCardState();
}

class GamesCardState extends State<GamesCard> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    final localize = AppLocalizations.of(context)!;
    return InkWell(
      onTap: () {
        context.push('${RouteNames.games}/${widget.game.gameId}');
      },
      child: Container(
        color: Colors.transparent,
        height: 64,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                      image: NetworkImage(widget.game.imagePath),
                      fit: BoxFit.cover)),
            ),
            const SizedBox(
              width: 8,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: size.width * 0.4,
                  child: Text(
                    widget.game.name,
                    style: AppTypography.font16w400.copyWith(color: Colors.black),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      widget.game.grade.toString(),
                      style: AppTypography.font12w400
                          .copyWith(color: AppColors.grey500),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    const Icon(
                      Icons.grade_rounded,
                      size: 12,
                      color: AppColors.grey500,
                    )
                  ],
                )
              ],
            ),
            const Spacer(),
            Align(
              alignment: Alignment.centerRight,
              child: Material(
                  color: AppColors.purple200,
                  borderRadius: BorderRadius.circular(8),
                  child: InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(8),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        child: Text(
                          localize.download,
                          style:
                              AppTypography.font12w400.copyWith(color: Colors.black),
                        ),
                      ))),
            )
          ],
        ),
      ),
    );
  }
}
