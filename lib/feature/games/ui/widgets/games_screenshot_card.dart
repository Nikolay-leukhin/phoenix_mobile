import 'package:flutter/material.dart';
import 'package:izobility_mobile/feature/games/ui/widgets/games_screenshot_gallery.dart';

class GamesScreenshotCard extends StatefulWidget {
  final String imagePath;
  final int imageIndex;

  const GamesScreenshotCard(
      {super.key, required this.imagePath, required this.imageIndex});

  @override
  State<GamesScreenshotCard> createState() => GamesScreenshotCardState();
}

class GamesScreenshotCardState extends State<GamesScreenshotCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.sizeOf(context).width * 0.4,
        constraints: const BoxConstraints(maxWidth: 144),
        height: double.infinity,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
        child: Material(
          clipBehavior: Clip.hardEdge,
          borderRadius: BorderRadius.circular(16),
          child: Ink.image(
            fit: BoxFit.cover,
            image: NetworkImage(widget.imagePath),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GamesScreenshotsGallery(
                              indexStart: widget.imageIndex,
                            )));
              },
            ),
          ),
        ));
  }
}
