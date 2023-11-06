import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:izobility_mobile/feature/auth/bloc/password_recovery/password_recovery_cubit.dart';
import 'package:izobility_mobile/routes/go_routes.dart';
import 'package:izobility_mobile/utils/ui/colors.dart';
import 'package:izobility_mobile/utils/ui/fonts.dart';

import '../../../utils/logic/validators.dart';
import '../../../widgets/button/custom_button.dart';
import '../../../widgets/scaffold/auth_scaffold.dart';
import '../../../widgets/text_field/custom_text_field.dart';

class VerifyRecoveryCodeScreen extends StatefulWidget {
  const VerifyRecoveryCodeScreen({super.key});

  @override
  State<VerifyRecoveryCodeScreen> createState() =>
      _VerifyRecoveryCodeScreenState();
}

class _VerifyRecoveryCodeScreenState extends State<VerifyRecoveryCodeScreen> {
  final TextEditingController codeController = TextEditingController();

  String? fieldError;
  bool buttonActive = false;

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 32,
          ),
          SvgPicture.asset(
            'assets/icons/logo.svg',
            width: 180,
          ),
          const SizedBox(
            height: 32,
          ),
          CustomTextField(
            hintText: 'Код подтверждения',
            keyboardType: TextInputType.number,
            controller: codeController,
            width: double.infinity,
            labelText: "Код подтверждения",
            error: fieldError != null,
            errorText: fieldError,
            onChange: (v) {
              setState(() {
                fieldError = Validator.verifyCodeValidator((v ?? '').trim());
                buttonActive = fieldError == null;
              });
            },
          ),
          const SizedBox(
            height: 16,
          ),
          CustomButton(
              text: 'Подтвердить',
              isActive: buttonActive,
              onTap: () {
                BlocProvider.of<PasswordRecoveryCubit>(context)
                    .checkCode(codeController.text.trim())
                    .then((value) {
                  if (value) {
                    context.push(RouteNames.authPasswordRecoveryChangePassword);
                  } else {
                    setState(() {
                      fieldError = 'Код неверный';
                      codeController.text = '';
                      buttonActive = false;
                    });
                  }
                });
              },
              width: double.infinity),
          const SizedBox(
            height: 16,
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration:  ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9)
              ),
              color: AppColors.primary
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Проверить почту',
                  style: AppTypography.font24w700,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  'Мы отправили письмо для восстановления вашего аккаунта',
                  style: AppTypography.font12w400,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
