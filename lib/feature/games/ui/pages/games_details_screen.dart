import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:izobility_mobile/feature/games/bloc/games/games_cubit.dart';
import 'package:izobility_mobile/feature/games/data/games_repository.dart';
import 'package:izobility_mobile/feature/games/ui/widgets/games_details_stats_card.dart';
import 'package:izobility_mobile/feature/games/ui/widgets/games_screenshot_card.dart';
import 'package:izobility_mobile/localization/app_localizations.dart';
import 'package:izobility_mobile/routes/go_routes.dart';

import 'package:izobility_mobile/utils/utils.dart';
import 'package:izobility_mobile/widgets/button/custom_button.dart';

class GamesDetailsScreen extends StatefulWidget {
  final String gameId;

  const GamesDetailsScreen({super.key, required this.gameId});

  @override
  State<GamesDetailsScreen> createState() => GamesDetailsScreenState();
}

class GamesDetailsScreenState extends State<GamesDetailsScreen> {
  @override
  void initState() {
    context.read<GamesCubit>().loadGameDetails(int.parse(widget.gameId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.purpleBcg,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: BlocBuilder<GamesCubit, GamesState>(
            builder: (context, state) {
              if (state is GamesWaitingState) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              } else if (state is GamesLoadedSuccessState) {
                return buildGamesDetailsContent();
              } else {
                return const Center(
                  child: Icon(
                    Icons.sentiment_dissatisfied_sharp,
                    size: 60,
                    color: AppColors.purple600,
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  CustomScrollView buildGamesDetailsContent() {
    final size = MediaQuery.sizeOf(context);

    final game = context.read<GamesRepository>().lastLoadedGameDetials;

    final localize = AppLocalizations.of(context)!;

    return CustomScrollView(
      physics: const BouncingScrollPhysics(decelerationRate: ScrollDecelerationRate.fast),
      slivers: [
        const SliverAppBar(
          pinned: true,
          backgroundColor: AppColors.purpleBcg,
          surfaceTintColor: Colors.transparent,
        ),
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 9,
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                        image: NetworkImage(game.imagePath),
                        fit: BoxFit.cover)),
              ),
              const SizedBox(
                width: 12,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: size.width * 0.4,
                    child: Text(
                      game.name,
                      style: AppTypography.font16w400.copyWith(color: Colors.black),
                    ),
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  Text(
                    game.companyName,
                    style:
                        AppTypography.font12w400.copyWith(color: AppColors.grey500),
                  )
                ],
              ),
            ]),
          ),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 16,
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GamesDetialsStatsCard(
                    label: "${game.grade}",
                    description: "${game.gradesQuantity} ${localize.grades}"),
                GamesDetialsStatsCard(
                    label: "${game.downloadsQuantity}",
                    description: localize.download_quantity),
                GamesDetialsStatsCard(
                    label: "${game.weight} MB", description: localize.size)
              ],
            ),
          ),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 16,
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CustomButton(
              width: double.infinity,
              onTap: () {
                context.push(RouteNames.gamesDetailsLoading);
              },
              text: localize.download,
              radius: 100,
              height: 40,
            ),
          ),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 16,
          ),
        ),
        SliverToBoxAdapter(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              height: size.height * 0.32,
              constraints: const BoxConstraints(minHeight: 150, maxHeight: 250),
              child: Row(
                children: [
                  ...List.generate(game.screenshotList.length * 2, (index) {
                    if (index % 2 == 1) {
                      return GamesScreenshotCard(
                        imageIndex: index ~/ 2,
                        imagePath: game.screenshotList[index ~/ 2],
                      );
                    } else {
                      return const SizedBox(
                        width: 16,
                      );
                    }
                  }),
                  const SizedBox(
                    width: 16,
                  )
                ],
              ),
            ),
          ),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 16,
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  localize.description,
                  style: AppTypography.font18w700.copyWith(color: Colors.black),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  game.description,
                  style: AppTypography.font12w400.copyWith(color: Colors.black),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
