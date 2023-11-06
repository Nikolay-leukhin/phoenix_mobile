import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:izobility_mobile/bloc_injector.dart';
import 'package:izobility_mobile/feature/auth/bloc/app/app_cubit.dart';
import 'package:izobility_mobile/feature/profile/data/user_repository.dart';
import 'package:izobility_mobile/localization/app_localizations.dart';
import 'package:izobility_mobile/utils/utils.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_lib.dart';

import 'services/locale/export_locale_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  StreamAuthNotifier notifier = StreamAuthNotifier();

  Bloc.observer = CustomBlocObserver(authNotifier: notifier);

  await dotenv.load();
  TrustWalletCoreLib.init();

  runApp(MyRepositoryProviders(
    notifier: notifier,
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  Locale? _locale;

  setLocale(Locale locale) async{
    final repos = RepositoryProvider.of<UserRepository>(context);

    repos.setLanguage(locale.languageCode);

    setState(() {
      _locale = locale;
    });    
  }

  getLocal() async {
    _locale = Locale(
        await RepositoryProvider.of<UserRepository>(context).getLanguage());

    setState(() {
      
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);

    getLocal();

    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    log(state.toString());

    if (state == AppLifecycleState.paused) {
      BlocProvider.of<AppCubit>(context).pauseApp();
    } else if (state == AppLifecycleState.resumed) {
      BlocProvider.of<AppCubit>(context).resumeApp();
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: _locale,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: CustomGoRoutes.router,
      builder: (context, child) {
        return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: child!);
      },
    );
  }
}
