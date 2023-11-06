import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:izobility_mobile/feature/profile/bloc/profile_referals/profile_referals_cubit.dart';
import 'package:izobility_mobile/feature/profile/data/user_repository.dart';
import 'package:izobility_mobile/models/referal.dart';
import 'package:izobility_mobile/utils/ui/colors.dart';
import 'package:izobility_mobile/utils/ui/fonts.dart';
import 'package:izobility_mobile/utils/ui/gradients.dart';
import 'package:izobility_mobile/widgets/app_bar/custom_app_bar.dart';
import 'package:izobility_mobile/widgets/button/custom_button.dart';
import 'package:izobility_mobile/widgets/popup/popup_qr.dart';
import 'package:izobility_mobile/widgets/scaffold/home_scaffold.dart';
import 'package:izobility_mobile/widgets/snack_bar/custom_snack_bar.dart';
import 'package:rxdart/rxdart.dart';
import 'package:share_plus/share_plus.dart';

class ProfileReferalScreen extends StatefulWidget {
  const ProfileReferalScreen({super.key});

  @override
  State<ProfileReferalScreen> createState() => ProfileReferalScreenState();
}

class ProfileReferalScreenState extends State<ProfileReferalScreen> {
  @override
  void initState() {
    context.read<ProfileReferalsCubit>().loadReferalList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return HomeScaffold(
      appBar: CustomAppBar(
        context: context,
        text: "Рефералы",
        isBack: true,
        onTap: () {
          context.pop();
        },
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await context.read<ProfileReferalsCubit>().loadReferalList();
        },
        child: Container(
          padding: const EdgeInsets.all(8).copyWith(bottom: 0),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  height: 75,
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  decoration: BoxDecoration(
                      color: AppColors.purpleBcg,
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: (size.width - 73) * 0.49,
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 15,
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                BlocBuilder<ProfileReferalsCubit,
                                    ProfileReferalsState>(
                                  builder: (context, state) {
                                    if (state is ProfileReferalsLoading) {
                                      return Container(
                                        height: 18,
                                        width: 30,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            gradient: AppGradients.accentGreen),
                                      );
                                    } else if (state
                                        is ProfileReferalsSuccess) {
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            context
                                                    .read<UserRepository>()
                                                    .referalList
                                                    .isNotEmpty
                                                ? (List.generate(
                                                        context
                                                            .read<UserRepository>()
                                                            .referalList
                                                            .length,
                                                        (index) => (context
                                                            .read<UserRepository>()
                                                            .referalList[index]
                                                            .sum)))
                                                    .reduce((a, b) => a + b)
                                                    .toString()
                                                : "0",
                                            style: AppTypography.font18w700
                                                .copyWith(color: Colors.black),
                                          ),
                                          const SizedBox(
                                            width: 4,
                                          ),
                                          Image.asset(
                                            "assets/images/logo_coint_emrld.png",
                                            width: 20,
                                            fit: BoxFit.fitWidth,
                                          )
                                        ],
                                      );
                                    }

                                    return Container(
                                      height: 10,
                                    );
                                  },
                                ),
                                Text(
                                  "Доход",
                                  style: AppTypography.font12w400
                                      .copyWith(color: AppColors.grey500),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 1,
                        color: AppColors.grey500,
                        height: double.infinity,
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        width: (size.width - 73) * 0.5,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            BlocBuilder<ProfileReferalsCubit,
                                ProfileReferalsState>(
                              builder: (context, state) {
                                if (state is ProfileReferalsLoading) {
                                  return Container(
                                    height: 18,
                                    width: 30,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        gradient: AppGradients.accentGreen),
                                  );
                                } else if (state is ProfileReferalsSuccess) {
                                  return Text(
                                    context
                                        .read<UserRepository>()
                                        .referalList
                                        .length
                                        .toString(),
                                    style: AppTypography.font18w700
                                        .copyWith(color: Colors.black),
                                  );
                                }

                                return Container(
                                  height: 18,
                                );
                              },
                            ),
                            Text(
                              "Присоединилось",
                              style: AppTypography.font12w400
                                  .copyWith(color: AppColors.grey500),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  height: 140,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: AppGradients.shrek,
                  ),
                  child: Stack(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            width: (size.width - 85) * 0.55,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                FittedBox(
                                  child: Text(
                                    "Получайте деньги\nза реферал",
                                    style: AppTypography.font20w700.copyWith(
                                        color: Colors.white, letterSpacing: 0),
                                  ),
                                ),
                                CustomButton(
                                    gradient: AppGradients.accentGreen,
                                    textColor: Colors.black,
                                    fontSize: 14,
                                    height: 28,
                                    text: "Скопировать код",
                                    onTap: () {
                                      Clipboard.setData(ClipboardData(
                                          text: context
                                              .read<UserRepository>()
                                              .user
                                              .details!
                                              .referalcode!));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                              CustomSnackBar.snackBarCopied);
                                    },
                                    width: double.infinity),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(bottom: 16),
                            width: (size.width - 85) * 0.4654545454,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/images/sky_money.png",
                                  fit: BoxFit.fitHeight,
                                  height: 96,
                                ),
                                CustomButton(
                                    withBorder: false,
                                    color: Colors.black,
                                    textColor: Colors.white,
                                    height: 28,
                                    text: "Поделиться",
                                    onTap: () async {
                                      await Share.share(context
                                          .read<UserRepository>()
                                          .user
                                          .details!
                                          .referalcode!);
                                    },
                                    width: double.infinity),
                              ],
                            ),
                          )
                        ],
                      ),
                      Positioned(
                          top: 16,
                          right: 16,
                          child: Material(
                            borderRadius: BorderRadius.circular(6),
                            color: Colors.white,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(6),
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => const PopupQr());
                              },
                              child: Container(
                                padding: const EdgeInsets.all(3),
                                child: SvgPicture.asset(
                                  "assets/icons/qr.svg",
                                  width: 24,
                                ),
                              ),
                            ),
                          ))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Мои рефералы",
                        textAlign: TextAlign.start,
                        style: AppTypography.font20w700
                            .copyWith(color: Colors.black),
                      ),
                      BlocBuilder<ProfileReferalsCubit, ProfileReferalsState>(
                        builder: (context, state) {
                          if (state is ProfileReferalsLoading) {
                            return const Center(
                              child: CircularProgressIndicator.adaptive(),
                            );
                          } else if (state is ProfileReferalsSuccess ||
                              state is ProfileReferalsInitial) {
                            if (context
                                .read<UserRepository>()
                                .referalList
                                .isEmpty) {
                              return Text("У вас пока нет рефералов :(");
                            } else {
                              return Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: Column(
                                  children: buildReferalListWidget(),
                                ),
                              );
                            }
                          }

                          return Container();
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> buildReferalListWidget() {
    final userRepository = context.read<UserRepository>();

    return userRepository.referalList
        .map((e) => ReferalCard(
              referal: e,
            ))
        .toList();
  }
}

class ReferalCard extends StatelessWidget {
  final ReferalModel referal;

  const ReferalCard({super.key, required this.referal});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                clipBehavior: Clip.hardEdge,
                width: 32,
                height: 32,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: AppGradients.gradientGreenWhite),
                child: referal.photo == null
                    ? SvgPicture.asset(
                        "assets/icons/profile.svg",
                        width: 26,
                      )
                    : Image.network(
                        "https://api.z-boom.ru/user/photo/${referal.id}"),
              ),
              const SizedBox(
                width: 12,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    referal.name == null ? referal.email : referal.name!,
                    style:
                        AppTypography.font16w400.copyWith(color: Colors.black),
                  ),
                  Text(
                    "Уровень: ${referal.referalLevel}",
                    style: AppTypography.font12w400
                        .copyWith(color: AppColors.grey500),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "+${referal.sum}",
                style: AppTypography.font16w700.copyWith(
                    color: referal.sum == 0
                        ? AppColors.grey500
                        : AppColors.green600),
              ),
              const SizedBox(
                width: 4,
              ),
              Image.asset(
                "assets/images/logo_coint_emrld.png",
                width: 24,
                fit: BoxFit.fitWidth,
              )
            ],
          )
        ],
      ),
    );
  }
}
