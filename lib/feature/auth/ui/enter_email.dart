import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:izobility_mobile/routes/go_routes.dart';
import 'package:izobility_mobile/utils/ui/animations.dart';
import 'package:izobility_mobile/utils/ui/colors.dart';
import 'package:izobility_mobile/utils/ui/dialogs.dart';
import 'package:izobility_mobile/utils/logic/validators.dart';
import 'package:izobility_mobile/widgets/button/custom_button.dart';
import 'package:izobility_mobile/widgets/text_field/custom_text_field.dart';

import '../bloc/auth/auth_cubit.dart';

class EnterEmailScreen extends StatefulWidget {
  const EnterEmailScreen({super.key});

  @override
  State<EnterEmailScreen> createState() => _EnterEmailScreenState();
}

class _EnterEmailScreenState extends State<EnterEmailScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController referalCodeController = TextEditingController();

  bool buttonActive = false;

  String? fieldError;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () async {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: false,
          body: Padding(
            padding: const EdgeInsets.fromLTRB(16, 100, 16, 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/emerald_logo.png',
                  width: 160,
                  fit: BoxFit.fitWidth,
                ),
                const SizedBox(
                  height: 32,
                ),
                Column(
                  children: [
                    CustomTextField(
                      labelText: "Ваша почта",
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
                    CustomTextField.withOneIcon(
                      obscured: false,
                      labelText: "Реферальный код",
                      controller: referalCodeController,
                      width: double.infinity,
                      suffixIconCallback: () {
                        context.push(RouteNames.mainQr, extra: {
                          'onFound': (f) {
                            referalCodeController.text = f.code.toString();
                          }
                        });
                      },
                      suffixIconChild: SvgPicture.asset(
                        'assets/icons/scaner.svg',
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomButton(
                        text: 'Далее',
                        onTap: () {
                          Dialogs.showModal(
                              context,
                              const Center(
                                child: AppAnimations.circularProgressIndicator,
                              ));

                          BlocProvider.of<AuthCubit>(context)
                              .checkEmail(emailController.text.trim(),
                                  referalCodeController.text)
                              .then((accountState) {
                            context.push(RouteNames.authEnterPassword);

                            Dialogs.hide(context);
                          });
                        },
                        isActive: buttonActive,
                        width: double.infinity),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
