import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:izobility_mobile/feature/auth/bloc/app/app_cubit.dart';
import 'package:izobility_mobile/utils/utils.dart';
import 'package:izobility_mobile/widgets/button/text_button_without_background.dart';
import 'package:izobility_mobile/widgets/keyboards/pin_keyboard.dart';
import 'package:izobility_mobile/widgets/scaffold/auth_scaffold.dart';

class CreatePinScreen extends StatefulWidget {
  const CreatePinScreen({super.key});

  @override
  State<CreatePinScreen> createState() => _CreatePinScreenState();
}

class _CreatePinScreenState extends State<CreatePinScreen> {
  String firstPin = '';
  static const String createPin = 'Придумайте код доступа';
  static const String repeatPin = 'Повторите код доступа';
  static const String doNotMatch = 'ПИН коды не совпадают';
  String message = createPin;

  void setPin(List<int> pin) async {
    log(firstPin.toString());
    if (firstPin.isEmpty) {
      firstPin = pin.join();
      message = repeatPin;
      log(firstPin.toString());
      setState(() {});
    } else {
      if (firstPin != pin.join()) {
        setState(() {
          message = doNotMatch;
        });
        await Future.delayed(const Duration(milliseconds: 1200));
        message = createPin;
        firstPin = '';
        setState(() {});
      } else {
        BlocProvider.of<AppCubit>(context).createPin(firstPin);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: AuthScaffold(
        isAppBar: false,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(width: double.infinity, height: 30),
            Image.asset(
              'assets/images/emerald_logo.png',
              width: 160,
              fit: BoxFit.fitWidth,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              message,
              style:
                  AppTypography.font14w700.copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(
              height: 12,
            ),
            PinKeyboard(
              commitDuration: const Duration(milliseconds: 150),
              commitCallback: setPin,
              isFinger: false,
            ),
            const SizedBox(
              height: 25,
            ),
            TextButtonWithoutBackground(onTap: () {}, text: 'Поддержка')
          ],
        ),
      ),
    );
  }
}
