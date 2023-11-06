import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:izobility_mobile/feature/games/data/games_repository.dart';
import 'package:izobility_mobile/utils/ui/colors.dart';
import 'package:izobility_mobile/utils/ui/fonts.dart';
import 'package:izobility_mobile/widgets/app_bar/custom_app_bar.dart';

class GamesLoadingScreen extends StatefulWidget {
  const GamesLoadingScreen({super.key});

  @override
  State<GamesLoadingScreen> createState() => _GamesLoadingScreenState();
}

class _GamesLoadingScreenState extends State<GamesLoadingScreen> {
  @override
  Widget build(BuildContext context) {
    final game = context.read<GamesRepository>().lastLoadedGameDetials;

    return Container(
      color: AppColors.purpleBcg,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomAppBar(
          context: context,
          isBack: true,
          onTap: () {
            context.pop();
          },
          text: "",
          backgroundColor: Colors.transparent,
        ),
        body: Center(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 128,
              height: 128,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                      fit: BoxFit.cover, image: NetworkImage(game.imagePath))),
            ),
            const SizedBox(
              height: 6,
            ),
            Text(
              game.name,
              style: AppTypography.font18w700.copyWith(color: Colors.black),
            ),
            const SizedBox(
              height: 32,
            ),
            const CircularProgressIndicator.adaptive()
          ],
        )),
      ),
    );
  }
}
