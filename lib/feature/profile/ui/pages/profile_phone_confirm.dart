import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:izobility_mobile/feature/profile/bloc/profile_phone/profile_phone_change_cubit.dart';
import 'package:izobility_mobile/localization/app_localizations.dart';
import 'package:izobility_mobile/routes/go_routes.dart';
import 'package:izobility_mobile/utils/logic/mask_text_field.dart';
import 'package:izobility_mobile/utils/ui/dialogs.dart';
import 'package:izobility_mobile/widgets/app_bar/custom_app_bar.dart';
import 'package:izobility_mobile/widgets/button/custom_button.dart';
import 'package:izobility_mobile/widgets/scaffold/home_scaffold.dart';
import 'package:izobility_mobile/widgets/text_field/custom_text_field.dart';

import '../../../../widgets/snack_bar/custom_snack_bar.dart';

class ProfilePhoneConfirm extends StatefulWidget {
  const ProfilePhoneConfirm({super.key});

  @override
  State<ProfilePhoneConfirm> createState() => _ProfilePhoneConfirmState();
}

class _ProfilePhoneConfirmState extends State<ProfilePhoneConfirm> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final localize = AppLocalizations.of(context)!;
    final size = MediaQuery.sizeOf(context);
    return BlocListener<ProfilePhoneChangeCubit, ProfilePhoneChangeState>(
      listener: (context, state) {
        if (state is ProfilePhoneChangeCodeFailure) {
          context.pop();

          ScaffoldMessenger.of(context)
              .showSnackBar(CustomSnackBar.errorSnackBar(state.errorText));
        } else if (state is ProfilePhoneChangeCodeLoading) {
          Dialogs.show(
              context,
              const Center(
                child: CircularProgressIndicator.adaptive(),
              ));
        } else if (state is ProfilePhoneChangeCodeSuccess) {
          context.pop();

          ScaffoldMessenger.of(context).showSnackBar(
              CustomSnackBar.successSnackBar("Успешная верификация"));
        }
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: CustomAppBar(
            context: context,
            text: "Code",
            isBack: true,
            onTap: () {
              context.pop();
            },
          ),
          body: Container(
            padding: const EdgeInsets.all(16).copyWith(bottom: 16),
            child: Column(
              children: [
                CustomTextField(
                    mask: AppMask.maskVerificationCodeFormatter,
                    backgroundColor: Colors.white,
                    hintText: "Last 4 digits of TN",
                    keyboardType: TextInputType.phone,
                    controller: controller,
                    width: size.width),
                const SizedBox(
                  height: 16,
                ),
                CustomButton(
                    text: localize.next,
                    onTap: () => {
                          context
                              .read<ProfilePhoneChangeCubit>()
                              .validatePhoneCode(controller.text)
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
