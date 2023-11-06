import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:izobility_mobile/feature/auth/bloc/auth/auth_cubit.dart';
import 'package:izobility_mobile/feature/profile/bloc/profile/profile_cubit.dart';
import 'package:izobility_mobile/feature/profile/bloc/profile_links/profile_links_cubit.dart';
import 'package:izobility_mobile/feature/profile/data/user_repository.dart';
import 'package:izobility_mobile/feature/profile/ui/widgets/profile_action_square.dart';
import 'package:izobility_mobile/feature/profile/ui/widgets/profile_actione_tile.dart';
import 'package:izobility_mobile/feature/profile/ui/widgets/profile_bloc_label.dart';
import 'package:izobility_mobile/feature/profile/ui/widgets/profile_card.dart';
import 'package:izobility_mobile/feature/store/bloc/store_user_items/store_user_items_cubit.dart';
import 'package:izobility_mobile/feature/store/data/store_repository.dart';
import 'package:izobility_mobile/localization/app_localizations.dart';
import 'package:izobility_mobile/routes/go_routes.dart';
import 'package:izobility_mobile/services/remote/constants/api_constants.dart';
import 'package:izobility_mobile/utils/ui/colors.dart';
import 'package:izobility_mobile/utils/ui/dialogs.dart';
import 'package:izobility_mobile/utils/ui/fonts.dart';
import 'package:izobility_mobile/utils/ui/gradients.dart';
import 'package:izobility_mobile/widgets/app_bar/custom_app_bar.dart';
import 'package:izobility_mobile/widgets/button_sheet/bottom_sheets.dart';
import 'package:izobility_mobile/widgets/popup/popup_logout.dart';
import 'package:izobility_mobile/widgets/snack_bar/custom_snack_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final localize = AppLocalizations.of(context)!;

    return BlocListener<ProfileLinksCubit, ProfileLinksState>(
      listener: (context, state) {
        if (state is ProfileLinksFail) {
          context.pop();
          ScaffoldMessenger.of(context)
              .showSnackBar(CustomSnackBar.errorSnackBar("Попробуйте позже"));
        } else if (state is ProfileLinksLoading) {
          Dialogs.show(
              context,
              const Center(
                child: CircularProgressIndicator(),
              ));
        } else {
          context.pop();
        }
      },
      child: Container(
        color: Colors.white,
        child: Scaffold(
            backgroundColor: AppColors.purpleBcg,
            appBar: CustomAppBar(
              context: context,
              text: localize.profile,
              isBack: false,
            ),
            body: RefreshIndicator(
              onRefresh: () async {
                await context.read<UserRepository>().loadUserDetailsInfo();
                await context.read<StoreRepository>().getUserProductList();
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16).copyWith(bottom: 0),
                      color: AppColors.purpleBcg,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          BlocBuilder<ProfileCubit, ProfileState>(
                            builder: (context, state) {
                              if (context
                                          .read<UserRepository>()
                                          .user
                                          .details
                                          ?.phone !=
                                      null &&
                                  context
                                          .read<UserRepository>()
                                          .user
                                          .details
                                          ?.phone !=
                                      "") {
                                return Container();
                              } else {
                                return Container(
                                  padding: const EdgeInsets.all(16),
                                  margin: const EdgeInsets.only(bottom: 16),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      gradient: AppGradients.gradientGreenDark,
                                      borderRadius: BorderRadius.circular(16)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Подтвердите номер телефона",
                                        style: AppTypography.font18w700
                                            .copyWith(color: Colors.white),
                                        textAlign: TextAlign.left,
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        "Без подтверждения номера телефона, у вас не будут доступны многие функции приложения",
                                        style: AppTypography.font12w400
                                            .copyWith(color: Colors.white),
                                      )
                                    ],
                                  ),
                                );
                              }
                            },
                          ),
                          Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16)),
                              child: const Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ProfileCard(),
                                ],
                              )),
                          const SizedBox(
                            height: 16,
                          ),
                          Wrap(
                            direction: Axis.horizontal,
                            alignment: WrapAlignment.spaceBetween,
                            runAlignment: WrapAlignment.start,
                            runSpacing: 10,
                            children: [
                              ProfileActionContainer(
                                label: localize.abstract_programm,
                                description: "",
                                onTap: () {
                                  context.push(RouteNames.profileReferal);
                                },
                              ),
                              ProfileActionContainer(
                                label: "Партнёрская программа",
                                description: "Стандартный партнёр",
                                onTap: () {
                                  context.push(RouteNames.develop);
                                },
                              ),
                              ProfileActionContainer(
                                label: localize.inventory,
                                description: '- предметов',
                                onTap: () {
                                  context.push(RouteNames.develop);
                                },
                              ),
                              ProfileActionContainer(
                                label: localize.cards,
                                description: 'Мои банковские карты',
                                onTap: () {
                                  context.push(RouteNames.develop);
                                },
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 16, right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Мои покупки",
                                  style: AppTypography.font16w400
                                      .copyWith(color: AppColors.textPrimary),
                                ),
                                IconButton(
                                    onPressed: () {
                                      context
                                          .push(RouteNames.storeUserProducts);
                                    },
                                    icon: const Icon(
                                      Icons.arrow_forward_ios_outlined,
                                      size: 16,
                                      color: Colors.black,
                                    ))
                              ],
                            ),
                          ),
                          BlocBuilder<StoreUserItemsCubit, StoreUserItemsState>(
                            builder: (context, state) {
                              if (state is StoreUserItemsLoading) {
                                return buildLoadingUserProducts();
                              } else if (state is StoreUserItemsSuccess) {
                                if (context
                                    .read<StoreRepository>()
                                    .userProductList
                                    .isNotEmpty) {
                                  return buildLoadedUserProducts();
                                }
                              }

                              return Container();
                            },
                          ),
                          PorfileBlocLabel(
                            text: localize.account,
                          ),
                          ProfileActionTile(
                            onTap: () {
                              context.push(RouteNames.profileEdit);
                            },
                            label: localize.account_data,
                            iconPath: 'assets/icons/profile.svg',
                          ),
                          ProfileActionTile(
                            onTap: () {
                              context.push(RouteNames.profileLanguage);
                            },
                            label: localize.switch_language,
                            iconPath: 'assets/icons/world.svg',
                          ),
                          PorfileBlocLabel(
                            text: localize.social_net_em,
                          ),
                          ProfileActionTile(
                            onTap: () async{
                              context
                                  .read<ProfileLinksCubit>()
                                  .loadLink(urlTikTOk);

                              await launchUrl(Uri.parse(urlTikTOk));
                            },
                            label: 'TikTok',
                            iconPath: 'assets/icons/tiktok.svg',
                          ),
                          ProfileActionTile(
                            onTap: () {
                              context
                                  .read<ProfileLinksCubit>()
                                  .loadLink(urlTelegram);
                            },
                            label: 'Telegram',
                            iconPath: 'assets/icons/tg.svg',
                          ),
                          PorfileBlocLabel(
                            text: localize.general,
                          ),
                          ProfileActionTile(
                            onTap: () {
                              context.push(RouteNames.profileAbout);
                            },
                            label: localize.about_app,
                            iconPath: 'assets/icons/question.svg',
                          ),
                          ProfileActionTile(
                            onTap: () {
                              context.push(RouteNames.profilePrivacyPolicy);
                            },
                            label: localize.privacy_policy,
                            iconPath: 'assets/icons/safe.svg',
                          ),
                          ProfileActionTile(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => PopupChoose(
                                        label: localize.confirm_logout,
                                        onAccept: () {
                                          context.read<ProfileCubit>().logout();
                                          context
                                              .read<AuthCubit>()
                                              .checkLogin();
                                        },
                                        onDecline: () {
                                          context.pop();
                                        },
                                      ));
                            },
                            label: localize.logout,
                            iconPath: 'assets/icons/logout.svg',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }

  Widget buildLoadedUserProducts() {
    final storeRepository = context.read<StoreRepository>();

    return SizedBox(
      height: 190,
      child: ListView.builder(
        itemCount: storeRepository.userProductList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
            constraints: const BoxConstraints(maxWidth: 250),
            width: MediaQuery.sizeOf(context).width * 0.38,
            margin: const EdgeInsets.only(left: 16),
            height: 190,
            child: Material(
              child: Ink.image(
                fit: BoxFit.cover,
                image: NetworkImage(
                  storeRepository.userProductList[index].product.images[0],
                ),
                child: InkWell(
                  onTap: () {
                    AppBottomSheets.showProductInfo(
                        context, storeRepository.userProductList[index]);
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildLoadingUserProducts() {
    return SizedBox(
      height: 190,
      child: ListView.separated(
        itemCount: 5,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => const SizedBox(
          width: 8,
        ),
        itemBuilder: (context, index) {
          return Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
            constraints: const BoxConstraints(maxWidth: 250),
            width: MediaQuery.sizeOf(context).width * 0.38,
            height: 190,
            child: Container(
              decoration: BoxDecoration(
                  gradient: AppGradients.gradientGreenWhite,
                  borderRadius: BorderRadius.circular(16)),
            ),
          );
        },
      ),
    );
  }
}
