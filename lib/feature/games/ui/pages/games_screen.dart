import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:phoenix_mobile/feature/auth/bloc/app/app_cubit.dart';
import 'package:phoenix_mobile/feature/profile/data/user_repository.dart';
import 'package:phoenix_mobile/feature/wallet/data/wallet_repository.dart';
import 'package:phoenix_mobile/localization/app_localizations.dart';
import 'package:phoenix_mobile/routes/go_routes.dart';
import 'package:phoenix_mobile/utils/ui/colors.dart';
import 'package:phoenix_mobile/utils/ui/fonts.dart';
import 'package:phoenix_mobile/utils/ui/gradients.dart';
import 'package:phoenix_mobile/widgets/banners/game_banner.dart';

class GamesScreen extends StatefulWidget {
  const GamesScreen({super.key});

  @override
  State<GamesScreen> createState() => _GamesScreenState();
}

class _GamesScreenState extends State<GamesScreen> {
  void loadUnity() async {
    const String channel = 'unity_activity';
    const platform = MethodChannel(channel);

    final Future<Map<String, dynamic>> userBalances =
    RepositoryProvider.of<WalletRepository>(context).getUnityBalances();
    final Future<Map<String, dynamic>> userData =
    RepositoryProvider.of<UserRepository>(context).getUserJson();

    Future.wait([userData, userBalances]).then((value) async {
      final json = {}
        ..addAll(value[0])
        ..addAll(value[1]);
      try {
        BlocProvider.of<AppCubit>(context).runUnity();
        log('trying to start');
        final data = await platform.invokeMethod('startUnity', {'user': jsonEncode(json)});
        log(data.toString());
      } catch (e) {
        log(e.toString());
      }

    });
  }

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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.5, vertical: 8),
                    decoration: BoxDecoration(
                        image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/images/bridge.png")),
                        borderRadius: BorderRadius.circular(16)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Улучши свой город",
                          style: AppTypography.font20w700
                              .copyWith(color: Colors.white),
                        ),
                        Text(
                          "Помоги городу стать лучше и зарабатывай",
                          style: AppTypography.font14w400
                              .copyWith(color: AppColors.backgroundGrey),
                        ),
                        Container(
                          constraints: const BoxConstraints(maxHeight: 400),
                          height: MediaQuery.sizeOf(context).height * 0.23,
                        ),
                        InkWell(
                          onTap: () {
                            context.go(RouteNames.cityMain);
                          },
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 26, vertical: 4),
                            decoration: BoxDecoration(
                              gradient: AppGradients.purple,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Начать",
                                  style: AppTypography.font14w700
                                      .copyWith(color: Colors.white),
                                ),
                                const Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                  size: 14,
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ))),
              const SliverToBoxAdapter(
                child: SizedBox(height: 16),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverToBoxAdapter(
                  child: GameBanner(
                    onClick: () {
                      // IVAN
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
