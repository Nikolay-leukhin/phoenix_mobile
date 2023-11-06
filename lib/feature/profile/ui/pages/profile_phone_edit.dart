import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:izobility_mobile/feature/profile/bloc/profile_phone/profile_phone_change_cubit.dart';
import 'package:izobility_mobile/localization/app_localizations.dart';
import 'package:izobility_mobile/routes/go_routes.dart';
import 'package:izobility_mobile/utils/logic/mask_text_field.dart';
import 'package:izobility_mobile/utils/logic/validators.dart';
import 'package:izobility_mobile/utils/ui/dialogs.dart';
import 'package:izobility_mobile/widgets/app_bar/custom_app_bar.dart';
import 'package:izobility_mobile/widgets/button/custom_button.dart';
import 'package:izobility_mobile/widgets/scaffold/home_scaffold.dart';
import 'package:izobility_mobile/widgets/snack_bar/custom_snack_bar.dart';
import 'package:izobility_mobile/widgets/text_field/custom_text_field.dart';

class ProfilePhoneEdit extends StatefulWidget {
  const ProfilePhoneEdit({super.key});

  @override
  State<ProfilePhoneEdit> createState() => _ProfilePhoneEditState();
}

class _ProfilePhoneEditState extends State<ProfilePhoneEdit> {
  TextEditingController controller = TextEditingController();

  String? errorText;
  bool buttonActive = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localize = AppLocalizations.of(context)!;
    final size = MediaQuery.sizeOf(context);
    return BlocListener<ProfilePhoneChangeCubit, ProfilePhoneChangeState>(
      listener: (context, state) {
        ScaffoldMessenger.of(context).clearSnackBars();

        if (state is ProfilePhoneChangeFailure) {
          context.pop();

          ScaffoldMessenger.of(context).showSnackBar(
              CustomSnackBar.errorSnackBar(state.errorText));
        } else if (state is ProfilePhoneChangeLoading) {
          Dialogs.show(
              context,
              const Center(
                child: CircularProgressIndicator.adaptive(),
              ));
        } else if (state is ProfilePhoneChangeSuccess) {
          context.pop();

          context.pushReplacement(RouteNames.profilePhoneConfirm);
        }
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: CustomAppBar(
            context: context,
            text: "Подтвержение номера",
            isBack: true,
            onTap: () {
              context.pop();
            },
          ),
          body: Container(
            padding: const EdgeInsets.all(16).copyWith(bottom: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextField(
                  backgroundColor: Colors.white,
                  hintText: "+79997774122",
                  error: errorText != null,
                  errorText: errorText,
                  controller: controller,
                  width: size.width,
                  onChange: (phone) {
                    final validationResult = Validator.verifyPhone(phone ?? "");
                    if (validationResult == null) {
                      errorText = null;
                      buttonActive = true;
                    } else {
                      errorText = validationResult;
                      buttonActive = false;
                    }

                    setState(() {});
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomButton(
                    isActive: buttonActive,
                    text: localize.next,
                    onTap: () async {
                      final phoneNumber = controller.text;
                      await context
                          .read<ProfilePhoneChangeCubit>()
                          .verifyUserPhone(
                              countryCode: phoneNumber.substring(
                                0,
                                phoneNumber.length - 10,
                              ),
                              phoneNumber: phoneNumber.substring(
                                  phoneNumber.length - 10, phoneNumber.length));
                      // context.push(RouteNames.profilePhoneConfirm);
                    },
                    width: size.width)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
