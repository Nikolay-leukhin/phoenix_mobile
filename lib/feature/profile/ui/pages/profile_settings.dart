import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:izobility_mobile/feature/profile/ui/widgets/profile_aspect.dart';
import 'package:izobility_mobile/feature/profile/ui/widgets/profile_bloc_label.dart';
import 'package:izobility_mobile/feature/profile/ui/widgets/profile_switch_card.dart';
import 'package:izobility_mobile/localization/app_localizations.dart';
import 'package:izobility_mobile/widgets/app_bar/custom_app_bar.dart';
import 'package:izobility_mobile/widgets/scaffold/home_scaffold.dart';

class ProfileSettingsScreen extends StatefulWidget {
  const ProfileSettingsScreen({super.key});

  @override
  State<ProfileSettingsScreen> createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  @override
  Widget build(BuildContext context) {

    return HomeScaffold(
        appBar: CustomAppBar(
          context: context,
          text: 'Настройки',
          isBack: true,
          onTap: () {
            context.pop();
          },
        ),
        body: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //
              PorfileBlocLabel(text: "Память"),
              ProfileAspect(
                  label: 'Место хранения файлов контента', text: "жопа/да"),
              //
              PorfileBlocLabel(text: "Безопасность"),
              ProfileSwitchCard(
                  label: "2FA Двухфакторная аутентификация",
                  description:
                      "Подтверждения входа или действий в приложении"),
              ProfileSwitchCard(
                  label: "Отправка данных",
                  description:
                      "Отправка данных для аналитики и улучшения работоспособности приложения"),
              ProfileSwitchCard(
                  label: "Скрыть реальное имя",
                  description: "В вашем профиле будет указан ID *user576767"),
              //
              PorfileBlocLabel(text: "Персонализация"),
              ProfileAspect(label: 'Язык', text: "Русский"),
              ProfileAspect(
                  label: 'Конвертация валюты', text: "Российский рубль"),
              //
              PorfileBlocLabel(text: "Уведомления"),
              ProfileSwitchCard(
                  label: "Пуш уведомления",
                  description:
                      "Описанието криптовалюта, которая поддерживает экосистему Binance Chain."),
              ProfileSwitchCard(
                  label: "Умные уведомления",
                  description:
                      "Описанието криптовалюта, которая поддерживает экосистему Binance Chain."),
              ProfileSwitchCard(
                  label: "Умные уведомления",
                  description:
                      "Описанието криптовалюта, которая поддерживает экосистему Binance Chain."),
              ProfileSwitchCard(
                  label: "Уведомления с конфиденциальными данными",
                  description:
                      "Описанието криптовалюта, которая поддерживает экосистему Binance Chain."),
            ],
          ),
        ));
  }
}
