import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:izobility_mobile/feature/main/bloc/story/story_cubit.dart';
import 'package:izobility_mobile/feature/main/ui/widgets/story_indicator.dart';
import 'package:izobility_mobile/utils/ui/fonts.dart';
import 'package:izobility_mobile/widgets/button/custom_button.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../routes/go_routes.dart';

class StoryScreen extends StatefulWidget {
  const StoryScreen({super.key, required this.initialStoryIndex});

  final int initialStoryIndex;

  @override
  State<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen>
    with TickerProviderStateMixin {
  late AnimationController animationController;

  void exit() {
    try {
      BlocProvider.of<StoryCubit>(context).dispose();
      animationController.dispose();
    } catch (e) {}
    context.go(RouteNames.main);
  }

  DateTime? lastTapTime;

  final double minDeltaToDetectSwipe = 10;

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<StoryCubit>(context);
    if (bloc.controller == null) {
      animationController = AnimationController(
        vsync: this,
      );
      bloc.initController(animationController,
          initialStoryIndex: widget.initialStoryIndex);
      animationController.addListener(bloc.controllerListener);
    }


    onTapDown(TapDownDetails details) {
      lastTapTime = DateTime.now();
      bloc.pause();
    }

    onTapUp(TapUpDetails details) {
      final bool tap = DateTime.now().difference(lastTapTime!).inMilliseconds < 200;

      if (tap) {
        final bool right = details.localPosition.dx > MediaQuery.sizeOf(context).width / 2;
        if (right) {
          bloc.changeStory();
        } else {
          bloc.prevStory();
        }
      }

      bloc.play();
      lastTapTime = null;
    }

    onPanUpdate(DragUpdateDetails details) {
      print(details.delta.dx);

      if (details.delta.dx > minDeltaToDetectSwipe) {
        bloc.changeStory();
      } else if (details.delta.dx < -minDeltaToDetectSwipe) {
        bloc.prevStory();
      }
    }


    final Size size = MediaQuery.sizeOf(context);
    final double itemSize =
        (MediaQuery.sizeOf(context).width - 24 - (bloc.storiesCount - 1) * 4) /
            bloc.storiesCount;

    Future<void> openUrl(String url) async {
      final Uri uri = Uri.parse(url);

      if (!await launchUrl(uri)) {
        throw Exception('Could not launch $uri');
      }
    }

    return WillPopScope(
      onWillPop: () async {
        exit();
        return false;
      },
      child: BlocListener<StoryCubit, StoryState>(
        listener: (context, state) {
          if (state is EndOfStories) exit();
        },
        child: SafeArea(
          child: BlocBuilder<StoryCubit, StoryState>(
            builder: (context, state) {
              return GestureDetector(
                onTapDown: onTapDown,
                onTapUp: onTapUp,
                child: Container(
                  width: size.width,
                  height: size.height,
                  padding: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(bloc
                              .storiesList[bloc.currentStoryIndex].imageUrl),
                          fit: BoxFit.cover)),
                  child: Container(
                    width: size.width,
                    height: size.height,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.center,
                        colors: [Colors.black45, Colors.transparent],
                      ),
                    ),
                    child: Scaffold(
                      backgroundColor: Colors.transparent,
                      body: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BlocBuilder<StoryCubit, StoryState>(
                              builder: (context, state) {
                                int i = 0;
                                return Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 12),
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: bloc.storiesList.map((e) {
                                        i++;
                                        return StoryDurationIndicator(
                                            width: itemSize,
                                            duration: e.duration,
                                            index: i - 1);
                                      }).toList()),
                                );
                              }),
                          InkWell(
                            onTap: exit,
                            child: Ink(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: SvgPicture.asset(
                                'assets/icons/cross_rounded.svg',
                                color: Colors.white,
                                width: 24,
                                height: 24,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 64),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  bloc.storiesList[bloc.currentStoryIndex]
                                      .title,
                                  style: AppTypography.font24w700,
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  bloc.storiesList[bloc.currentStoryIndex]
                                      .subtitle,
                                  style: AppTypography.font14w400,
                                ),
                                if (bloc.storiesList[bloc.currentStoryIndex]
                                        .buttonUrl !=
                                    null) ...[
                                  const SizedBox(height: 16),
                                  CustomButton(
                                      text: 'Читать',
                                      onTap: () {
                                        openUrl(bloc
                                            .storiesList[bloc.currentStoryIndex]
                                            .buttonUrl!);
                                      },
                                      width: double.infinity)
                                ]
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
