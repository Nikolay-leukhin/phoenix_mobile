import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:izobility_mobile/feature/auth/bloc/password_recovery/password_recovery_cubit.dart';
import 'package:izobility_mobile/routes/go_routes.dart';
import 'package:izobility_mobile/widgets/scaffold/auth_scaffold.dart';

import '../../../utils/ui/animations.dart';
import '../../../utils/ui/dialogs.dart';
import '../../../utils/logic/validators.dart';
import '../../../widgets/button/custom_button.dart';
import '../../../widgets/text_field/custom_text_field.dart';

class PasswordRecoveryEmailScreen extends StatefulWidget {
  const PasswordRecoveryEmailScreen({super.key});

  @override
  State<PasswordRecoveryEmailScreen> createState() =>
      _PasswordRecoveryEmailScreenState();
}

class _PasswordRecoveryEmailScreenState
    extends State<PasswordRecoveryEmailScreen> {
  final TextEditingController emailController = TextEditingController();

  bool buttonActive = false;

  String? fieldError;

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 100, 16, 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              'assets/icons/logo.svg',
              width: 180,
            ),
            const SizedBox(
              height: 32,
            ),
            Column(
              children: [
                CustomTextField(
                  labelText: "Почта для восстановления",
                  keyboardType: TextInputType.emailAddress,
                  errorText: fieldError,
                  error: fieldError != null,
                  controller: emailController,
                  width: double.infinity,
                  onChange: (v) {
                    fieldError = Validator.emailValidator(v);
                    if (fieldError == null) {
                      buttonActive = true;
                      log((v ?? "").isNotEmpty.toString());
                    } else {
                      buttonActive = false;
                    }
                    log(fieldError.toString());
                    setState(() {});
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                BlocListener<PasswordRecoveryCubit, PasswordRecoveryState>(
                  listener: (context, state) {
                    if (state is PasswordRecoveryProcessState) {
                      Dialogs.showModal(
                          context,
                          const Center(
                            child: AppAnimations.circularProgressIndicator,
                          ));
                    } else {
                      Dialogs.hide(context);
                    }
                    if (state is PasswordRecoveryEmailSent) {
                      context
                          .push(RouteNames.authPasswordRecoveryVerifyCode);
                    }
                  },
                  child: CustomButton(
                      text: 'Восстановить',
                      onTap: () {
                        // BlocProvider.of<PasswordRecoveryCubit>(context)
                        //     .sendRecoveryEmail(emailController.text.trim());
                      },
                      isActive: buttonActive,
                      width: double.infinity),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
