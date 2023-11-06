import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:izobility_mobile/feature/games/data/games_repository.dart';
import 'package:izobility_mobile/widgets/app_bar/custom_app_bar.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class GamesScreenshotsGallery extends StatefulWidget {
  final int indexStart;

  const GamesScreenshotsGallery({super.key, required this.indexStart});

  @override
  State<GamesScreenshotsGallery> createState() =>
      _GamesScreenshotsGalleryState();
}

class _GamesScreenshotsGalleryState extends State<GamesScreenshotsGallery> {
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: widget.indexStart);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final game = context.read<GamesRepository>().lastLoadedGameDetials;

    return Scaffold(
      appBar: CustomAppBar(
          context: context,
          isBack: true,
          onTap: () {
            context.pop();
          },
          text: "Фоточки"),
      body: PhotoViewGallery.builder(
          backgroundDecoration: const BoxDecoration(color: Colors.black),
          pageController: _pageController,
          itemCount: game.screenshotList.length,
          builder: (context, index) => PhotoViewGalleryPageOptions(
                imageProvider: NetworkImage(game.screenshotList[index]),
                initialScale: PhotoViewComputedScale.contained * 0.8,
              )),
    );
  }
}
