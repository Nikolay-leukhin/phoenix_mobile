import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:izobility_mobile/feature/profile/bloc/profile/profile_cubit.dart';
import 'package:izobility_mobile/feature/profile/data/user_repository.dart';
import 'package:izobility_mobile/localization/app_localizations.dart';
import 'package:izobility_mobile/routes/go_routes.dart';
import 'package:izobility_mobile/utils/ui/colors.dart';
import 'package:izobility_mobile/utils/ui/fonts.dart';
import 'package:izobility_mobile/widgets/app_bar/custom_app_bar.dart';
import 'package:izobility_mobile/widgets/popup/popup_logout.dart';
import 'package:izobility_mobile/widgets/text_field/custom_text_field.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    loadData();
    super.initState();
  }

  Future<void> loadData() async {
    final userRepository = context.read<UserRepository>();

    _nameController.text = userRepository.user.details?.name ?? "";
    _surnameController.text = userRepository.user.details?.fam ?? "";
    _emailController.text = userRepository.user.email ?? "";
    if (userRepository.user.details != null &&
        userRepository.user.details!.phone != null) {
      _phoneController.text =
          "+${userRepository.user.details!.phoneCountry}${userRepository.user.details!.phone}";
    }

    if (userRepository.user.details != null &&
        userRepository.user.details!.birthday != null) {
      _birthdayController.text =
          "${userRepository.user.details!.birthday!.day}.${userRepository.user.details!.birthday!.month}.${userRepository.user.details!.birthday!.year}";
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _surnameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _birthdayController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localize = AppLocalizations.of(context)!;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        color: Colors.white,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: AppColors.purpleBcg,
            appBar: CustomAppBar(
              actions: [
                Material(
                  child: InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: ((context) => PopupChoose(
                              label: localize.save_chages,
                              description: localize.loose_data,
                              onAccept: () async {
                                if (_nameController.text == "" ||
                                    _surnameController.text == "") {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              "Вы не можете изменить ФИ имя на пустые")));
                                  context.pop();
                                  _nameController.text ==
                                      context
                                          .read<UserRepository>()
                                          .user
                                          .details!
                                          .name;
                                } else {
                                  context.read<ProfileCubit>().updateUserData(
                                        birthday: _birthdayController.text,
                                        gender: context
                                            .read<UserRepository>()
                                            .user
                                            .details!
                                            .gender!,
                                        name: _nameController.text,
                                        surname: _surnameController.text,
                                      );

                                  context.pop();
                                }
                              },
                              onDecline: () => context.pop())));
                    },
                    child: Container(
                        width: 45,
                        height: double.infinity,
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.check,
                          size: 25,
                          weight: 700,
                        )),
                  ),
                )
              ],
              context: context,
              text: localize.profile_code,
              isBack: true,
              onTap: () {
                context.pop();
              },
            ),
            body: BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, state) {
                if (state is ProfileWaiting || state is ProfileInitial) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                } else if (state is ProfileSuccessState) {
                  return buildUserDetialsInfo();
                } else {
                  return const Center(
                    child: Text('Ошибочка на сервере('),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget buildUserDetialsInfo() {
    final user = context.read<UserRepository>().user;
    final localize = AppLocalizations.of(context)!;

    Map<int, String> gender = {0: localize.man, 1: localize.woman};

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16).copyWith(bottom: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomTextField(
                backgroundColor: Colors.white,
                labelText: localize.name,
                hintText: user.details?.name ?? localize.name,
                controller: _nameController,
                width: double.infinity),
            const SizedBox(
              height: 16,
            ),
            CustomTextField(
                backgroundColor: Colors.white,
                labelText: localize.surname,
                hintText: localize.surname,
                controller: _surnameController,
                width: double.infinity),
            const SizedBox(
              height: 16,
            ),
            CustomTextField(
                backgroundColor: Colors.white,
                labelText: 'email',
                hintText: "Почта",
                controller: _emailController,
                width: double.infinity),
            const SizedBox(
              height: 16,
            ),
            Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (context) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 36, vertical: 16),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16)),
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                ProfileGenderChooseCard(
                                  genderIndex: 0,
                                  text: localize.man,
                                ),
                                ProfileGenderChooseCard(
                                  genderIndex: 1,
                                  text: localize.woman,
                                ),
                                ProfileGenderChooseCard(
                                  genderIndex: 2,
                                  text: localize.another,
                                )
                              ]),
                        );
                      });
                },
                child: Container(
                  height: 56,
                  padding: const EdgeInsets.only(right: 5, left: 16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.transparent,
                      border:
                          Border.all(width: 1, color: AppColors.disableButton)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      gender[user.details?.gender] == null
                          ? Text(
                              localize.sex,
                              style: AppTypography.font16w400
                                  .copyWith(color: AppColors.hintText),
                            )
                          : Text(
                              gender[user.details?.gender]!,
                              style: AppTypography.font16w400
                                  .copyWith(color: Colors.black),
                            ),
                      const Icon(
                        Icons.arrow_drop_down_outlined,
                        size: 20,
                        color: Colors.black,
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            CustomTextField.withOneIcon(
              readOnly: true,
              backgroundColor: Colors.white,
              labelText: localize.birthday,
              hintText: localize.birthday,
              controller: _birthdayController,
              width: double.infinity,
              obscured: false,
              suffixIconChild: const Icon(
                Icons.date_range_outlined,
                size: 20,
                color: Colors.black,
              ),
              suffixIconCallback: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(200),
                  lastDate: DateTime(2100),
                );
                if (date != null) {
                  _birthdayController.text =
                      "${date.day}.${date.month}.${date.year}";
                }
              },
            ),
            const SizedBox(
              height: 16,
            ),
            CustomTextField.withOneIcon(
                suffixIconCallback: () {
                  context.push(RouteNames.profilePhone);
                },
                obscured: false,
                suffixIconChild: const Icon(
                  Icons.navigate_next_rounded,
                  size: 24,
                  color: Colors.black,
                ),
                readOnly: true,
                backgroundColor: Colors.white,
                labelText: localize.telephone,
                hintText: localize.telephone,
                controller: _phoneController,
                width: double.infinity),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileGenderChooseCard extends StatelessWidget {
  final String text;
  final int genderIndex;

  const ProfileGenderChooseCard({
    super.key,
    required this.text,
    required this.genderIndex,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<ProfileCubit>().changeUserGender(genderIndex);
        context.pop();
      },
      child: Row(
        children: [
          Checkbox.adaptive(
            value: context.read<UserRepository>().user.details?.gender ==
                genderIndex,
            onChanged: (_) {
              context.read<ProfileCubit>().changeUserGender(genderIndex);
              context.pop();
            },
          ),
          const SizedBox(
            width: 0,
          ),
          Text(
            text,
            style: AppTypography.font16w400.copyWith(color: Colors.black),
          )
        ],
      ),
    );
  }
}
