import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:izobility_mobile/feature/profile/ui/widgets/profile_text_with_checkbox.dart';
import 'package:izobility_mobile/localization/app_localizations.dart';
import 'package:izobility_mobile/main.dart';
import 'package:izobility_mobile/utils/ui/colors.dart';
import 'package:izobility_mobile/widgets/app_bar/custom_app_bar.dart';

class ProfileLanguageScreen extends StatefulWidget {
  const ProfileLanguageScreen({super.key});

  @override
  State<ProfileLanguageScreen> createState() => _ProfileLanguageScreenState();
}

class _ProfileLanguageScreenState extends State<ProfileLanguageScreen> {
  Locale locale = const Locale('en');

  @override
  Widget build(BuildContext context) {
    locale = Locale(AppLocalizations.of(context)!.localeName);

    final localize = AppLocalizations.of(context)!;

    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.purpleBcg,
          appBar: CustomAppBar(
            context: context,
            text: localize.switch_language,
            isBack: true,
            onTap: () {
              context.pop();
            },
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                SizedBox(height: 10,),
                TextWithCheckBox(
                  value: locale.languageCode == 'ru',
                  onTap: () {
                    MyApp.setLocale(context, const Locale('ru'));
                    setState(() {});
                  },
                  title: 'Русский',
                ),
                SizedBox(height: 10,),
                TextWithCheckBox(
                  value: locale.languageCode == 'en',
                  onTap: () {
                    MyApp.setLocale(context, const Locale('en'));
                    setState(() {});
                  },
                  title: 'English',
                ),
                SizedBox(height: 10,),
                TextWithCheckBox(
                  value: locale.languageCode == 'es',
                  onTap: () {
                    MyApp.setLocale(context, const Locale('es'));
                    setState(() {});
                  },
                  title: 'Spanish',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
