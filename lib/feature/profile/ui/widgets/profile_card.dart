import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:izobility_mobile/feature/profile/bloc/profile/profile_cubit.dart';
import 'package:izobility_mobile/feature/profile/data/user_repository.dart';
import 'package:izobility_mobile/models/user.dart';
import 'package:izobility_mobile/utils/utils.dart';

class ProfileCard extends StatefulWidget {
  const ProfileCard({
    super.key,
  });

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Material(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(100000),
            child: InkWell(
              borderRadius: BorderRadius.circular(100000),
              onTap: () {
                showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (context) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 32),
                        decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(16)),
                            color: Color(0xffF6F6F6)),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () async {
                                  final image =
                                      await getImageFromCameraInBase64();
                                  await context
                                      .read<UserRepository>()
                                      .updatePhoto(image);
                                },
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      "assets/icons/camera.svg",
                                      width: 24,
                                    ),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Text('Сделать фото',
                                        style: AppTypography.font18w600
                                            .copyWith(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w400))
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () async {
                                  final image =
                                      await getImageFromGalleryInBase64();
                                  await context
                                      .read<UserRepository>()
                                      .updatePhoto(image);
                                },
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      "assets/icons/folder.svg",
                                      width: 24,
                                    ),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Text(
                                      'Выбрать из галереи',
                                      style: AppTypography.font18w600.copyWith(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            )
                          ],
                        ),
                      );
                    });
              },
              child: Container(
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  clipBehavior: Clip.hardEdge,
                  width: 64,
                  height: 64,
                  alignment: Alignment.center,
                  child: BlocBuilder<ProfileCubit, ProfileState>(
                    builder: (context, state) {
                      if (state is ProfileSuccessState) {
                        return context
                                    .read<UserRepository>()
                                    .user
                                    .details
                                    ?.photo !=
                                null
                            ? Image.network(
                                'https://api.z-boom.ru/media/${context.read<UserRepository>().user.details!.photo}')
                            : const Icon(
                                Icons.camera_alt_outlined,
                                color: Colors.white,
                                size: 23,
                              );
                      } else if (state is ProfileWaiting) {
                        return const Center(
                        );
                      }

                      return Container();
                    },
                  )),
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              if (state is ProfileWaiting) {
                return const Center(
                );
              } else if (state is ProfileSuccessState) {
                final user = context.read<UserRepository>().user;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.details?.name == null || user.details?.name == ""
                          ? "Ваше имя"
                          : user.details!.name!,
                      style: AppTypography.font18w700
                          .copyWith(color: AppColors.textPrimary, height: 1),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                      user.email ?? "email",
                      style: AppTypography.font12w400
                          .copyWith(color: AppColors.textPrimary, height: 1),
                    ),
                  ],
                );
              }

              return Container();
            },
          ),
        ]);
  }

  Future<dynamic> getImageFromGalleryInBase64() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image == null) {
      return null;
    }

    final byteImage = await image.readAsBytes();
    final base64Image = base64Encode(byteImage.toList());
    return base64Image;
  }

  Future<dynamic> getImageFromCameraInBase64() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);

    if (image == null) {
      return null;
    }

    final byteImage = await image.readAsBytes();
    final base64Image = base64Encode(byteImage.toList());
    return base64Image;
  }
}
