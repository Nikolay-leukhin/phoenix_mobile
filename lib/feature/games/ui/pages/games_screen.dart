import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:izobility_mobile/feature/games/ui/widgets/games_card.dart';
import 'package:izobility_mobile/localization/app_localizations.dart';
import 'package:izobility_mobile/models/game.dart';
import 'package:izobility_mobile/utils/ui/colors.dart';
import 'package:izobility_mobile/utils/ui/fonts.dart';
import 'package:izobility_mobile/utils/ui/gradients.dart';
import 'package:izobility_mobile/widgets/button/custom_button.dart';

class GamesScreen extends StatefulWidget {
  const GamesScreen({super.key});

  @override
  State<GamesScreen> createState() => _GamesScreenState();
}

class _GamesScreenState extends State<GamesScreen> {
  @override
  Widget build(BuildContext context) {
    final localize = AppLocalizations.of(context)!;

    return Container(
      color: AppColors.purpleBcg,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: CustomScrollView(
            physics: const BouncingScrollPhysics(
                decelerationRate: ScrollDecelerationRate.fast),
            slivers: [
              SliverAppBar(
                backgroundColor: AppColors.purpleBcg,
                surfaceTintColor: Colors.transparent,
                pinned: true,
                floating: false,
                centerTitle: true,
                title: Text(
                  localize.gaming,
                  style: AppTypography.font16w700.copyWith(color: Colors.black),
                ),
              ),

              SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverToBoxAdapter(
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          gradient: AppGradients.gradientBlackGrey),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 300,
                            child: Stack(
                              children: [
                                Positioned.fill(
                                    child: Image.asset(
                                  "assets/images/activity_man.jpg",
                                  fit: BoxFit.cover,
                                )),

                                Positioned.fill(child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Colors.black.withOpacity(0.4),
                                        Colors.transparent
                                      ]
                                    )
                                  ),
                                )),
                                Positioned(
                                  top: 0,
                                  left: 0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(16)
                                        .copyWith(bottom: 0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          "Активности",
                                          style: AppTypography.font18w700
                                              .copyWith(color: Colors.white),
                                        ),
                                        Text(
                                          "AR, QR, игры и т.д.",
                                          style: AppTypography.font12w400
                                              .copyWith(color: Colors.white),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Что внутри?",
                                  style: AppTypography.font20w700
                                      .copyWith(color: Colors.white),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      "assets/icons/qrscaner.svg",
                                      color: Colors.white,
                                      width: 24,
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      "QR Сканер",
                                      style: AppTypography.font14w400
                                          .copyWith(color: Colors.white),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      "assets/icons/aritem.svg",
                                      color: Colors.white,
                                      width: 24,
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      "AR Сканер",
                                      style: AppTypography.font14w400
                                          .copyWith(color: Colors.white),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      "assets/icons/armap.svg",
                                      color: Colors.white,
                                      width: 24,
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      "AR Карта",
                                      style: AppTypography.font14w400
                                          .copyWith(color: Colors.white),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 24,),
                                CustomButton(
                                    gradient: AppGradients.gradientGreenWhite,
                                    textColor: Colors.black,
                                    fontSize: 18,
                                    text: "Использовать",
                                    onTap: () {},
                                    width: double.infinity)
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
