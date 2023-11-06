import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_ru.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'localization/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('ru')
  ];

  /// No description provided for @incorrect_code.
  ///
  /// In en, this message translates to:
  /// **'* Incorrect code'**
  String get incorrect_code;

  /// No description provided for @incorrect_email.
  ///
  /// In en, this message translates to:
  /// **'* The mail is incorrect'**
  String get incorrect_email;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// No description provided for @your_access_code.
  ///
  /// In en, this message translates to:
  /// **'Your access code'**
  String get your_access_code;

  /// No description provided for @your_promo.
  ///
  /// In en, this message translates to:
  /// **'Your promo code'**
  String get your_promo;

  /// No description provided for @enter_seed.
  ///
  /// In en, this message translates to:
  /// **'Enter Seed-Phot'**
  String get enter_seed;

  /// No description provided for @auth_by_seed.
  ///
  /// In en, this message translates to:
  /// **'Enter the Seed-Phot'**
  String get auth_by_seed;

  /// No description provided for @confirm_logout.
  ///
  /// In en, this message translates to:
  /// **'Do you definitely want to go out?'**
  String get confirm_logout;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logout;

  /// No description provided for @main.
  ///
  /// In en, this message translates to:
  /// **'home'**
  String get main;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Further'**
  String get next;

  /// No description provided for @account_data.
  ///
  /// In en, this message translates to:
  /// **'Account data'**
  String get account_data;

  /// No description provided for @birthday.
  ///
  /// In en, this message translates to:
  /// **'Date of Birth'**
  String get birthday;

  /// No description provided for @have_to_get.
  ///
  /// In en, this message translates to:
  /// **'For receipt is not going'**
  String get have_to_get;

  /// No description provided for @another.
  ///
  /// In en, this message translates to:
  /// **'Another'**
  String get another;

  /// No description provided for @woman.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get woman;

  /// No description provided for @gaming.
  ///
  /// In en, this message translates to:
  /// **'Gaming'**
  String get gaming;

  /// No description provided for @game.
  ///
  /// In en, this message translates to:
  /// **'Game'**
  String get game;

  /// No description provided for @from.
  ///
  /// In en, this message translates to:
  /// **'from'**
  String get from;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @loose_data.
  ///
  /// In en, this message translates to:
  /// **'Otherwise you will lose the changes you have made'**
  String get loose_data;

  /// No description provided for @inventory.
  ///
  /// In en, this message translates to:
  /// **'Inventory'**
  String get inventory;

  /// No description provided for @no_enough.
  ///
  /// In en, this message translates to:
  /// **'It seems that something is missing here!'**
  String get no_enough;

  /// No description provided for @wallet.
  ///
  /// In en, this message translates to:
  /// **'Wallet'**
  String get wallet;

  /// No description provided for @buy.
  ///
  /// In en, this message translates to:
  /// **'Buy'**
  String get buy;

  /// No description provided for @buy_coins.
  ///
  /// In en, this message translates to:
  /// **'Buy coins'**
  String get buy_coins;

  /// No description provided for @shop.
  ///
  /// In en, this message translates to:
  /// **'Shop'**
  String get shop;

  /// No description provided for @my_seed.
  ///
  /// In en, this message translates to:
  /// **'My Seed-Phot'**
  String get my_seed;

  /// No description provided for @man.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get man;

  /// No description provided for @auth_code_sended.
  ///
  /// In en, this message translates to:
  /// **'We sent the code for authorization to the application'**
  String get auth_code_sended;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @nickname.
  ///
  /// In en, this message translates to:
  /// **'Nick'**
  String get nickname;

  /// No description provided for @about_give_back.
  ///
  /// In en, this message translates to:
  /// **'About the return'**
  String get about_give_back;

  /// No description provided for @about_company.
  ///
  /// In en, this message translates to:
  /// **'About company'**
  String get about_company;

  /// No description provided for @about_app.
  ///
  /// In en, this message translates to:
  /// **'About the appendix'**
  String get about_app;

  /// No description provided for @about_sale.
  ///
  /// In en, this message translates to:
  /// **'About the action'**
  String get about_sale;

  /// No description provided for @general.
  ///
  /// In en, this message translates to:
  /// **'Are common'**
  String get general;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @remain.
  ///
  /// In en, this message translates to:
  /// **'Left'**
  String get remain;

  /// No description provided for @send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get send;

  /// No description provided for @send_again.
  ///
  /// In en, this message translates to:
  /// **'Send again'**
  String get send_again;

  /// No description provided for @grades.
  ///
  /// In en, this message translates to:
  /// **'Assessments'**
  String get grades;

  /// No description provided for @gifts.
  ///
  /// In en, this message translates to:
  /// **'Present'**
  String get gifts;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// No description provided for @sex.
  ///
  /// In en, this message translates to:
  /// **'Floor'**
  String get sex;

  /// No description provided for @privacy_policy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacy_policy;

  /// No description provided for @get.
  ///
  /// In en, this message translates to:
  /// **'Get'**
  String get get;

  /// No description provided for @replenish.
  ///
  /// In en, this message translates to:
  /// **'Replenish'**
  String get replenish;

  /// No description provided for @mail.
  ///
  /// In en, this message translates to:
  /// **'Mail'**
  String get mail;

  /// No description provided for @hello.
  ///
  /// In en, this message translates to:
  /// **'Hello'**
  String get hello;

  /// No description provided for @check_email.
  ///
  /// In en, this message translates to:
  /// **'Check the mail'**
  String get check_email;

  /// No description provided for @promo_codes.
  ///
  /// In en, this message translates to:
  /// **'Promo codes'**
  String get promo_codes;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @public_offer.
  ///
  /// In en, this message translates to:
  /// **'Public offer'**
  String get public_offer;

  /// No description provided for @size.
  ///
  /// In en, this message translates to:
  /// **'Size'**
  String get size;

  /// No description provided for @profile_code.
  ///
  /// In en, this message translates to:
  /// **'Profile editing'**
  String get profile_code;

  /// No description provided for @reference_code.
  ///
  /// In en, this message translates to:
  /// **'Reference code'**
  String get reference_code;

  /// No description provided for @abstract_programm.
  ///
  /// In en, this message translates to:
  /// **'Referal program'**
  String get abstract_programm;

  /// No description provided for @swap.
  ///
  /// In en, this message translates to:
  /// **'Swap'**
  String get swap;

  /// No description provided for @download.
  ///
  /// In en, this message translates to:
  /// **'Download'**
  String get download;

  /// No description provided for @download_quantity.
  ///
  /// In en, this message translates to:
  /// **'Downloads'**
  String get download_quantity;

  /// No description provided for @copulated.
  ///
  /// In en, this message translates to:
  /// **'Copulated!'**
  String get copulated;

  /// No description provided for @copy.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get copy;

  /// No description provided for @create_wallet.
  ///
  /// In en, this message translates to:
  /// **'Create a wallet'**
  String get create_wallet;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @save_chages.
  ///
  /// In en, this message translates to:
  /// **'Save changes?'**
  String get save_chages;

  /// No description provided for @social_net_em.
  ///
  /// In en, this message translates to:
  /// **'Social networks Emerald'**
  String get social_net_em;

  /// No description provided for @telephone.
  ///
  /// In en, this message translates to:
  /// **'Telephone'**
  String get telephone;

  /// No description provided for @product_and_nft.
  ///
  /// In en, this message translates to:
  /// **'Products and NFT'**
  String get product_and_nft;

  /// No description provided for @tokens.
  ///
  /// In en, this message translates to:
  /// **'Tokens'**
  String get tokens;

  /// No description provided for @you_have.
  ///
  /// In en, this message translates to:
  /// **'You have'**
  String get you_have;

  /// No description provided for @oops.
  ///
  /// In en, this message translates to:
  /// **'Oops...'**
  String get oops;

  /// No description provided for @surname.
  ///
  /// In en, this message translates to:
  /// **'Surname'**
  String get surname;

  /// No description provided for @develop.
  ///
  /// In en, this message translates to:
  /// **'This functionality is under development! Our developers, designers and managers work 24/7 to roll out new chips!'**
  String get develop;

  /// No description provided for @apllication_languahe.
  ///
  /// In en, this message translates to:
  /// **'Application language'**
  String get apllication_languahe;

  /// No description provided for @ar_scanner.
  ///
  /// In en, this message translates to:
  /// **'Ar \n Scanner'**
  String get ar_scanner;

  /// No description provided for @qr_scanner.
  ///
  /// In en, this message translates to:
  /// **'QR \n scanner'**
  String get qr_scanner;

  /// No description provided for @ar_map.
  ///
  /// In en, this message translates to:
  /// **'Ar \n Map'**
  String get ar_map;

  /// No description provided for @switch_language.
  ///
  /// In en, this message translates to:
  /// **'Switch language'**
  String get switch_language;

  /// No description provided for @activate.
  ///
  /// In en, this message translates to:
  /// **'Activate'**
  String get activate;

  /// No description provided for @more.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get more;

  /// No description provided for @new_.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get new_;

  /// No description provided for @contract.
  ///
  /// In en, this message translates to:
  /// **'Contacts'**
  String get contract;

  /// No description provided for @cards.
  ///
  /// In en, this message translates to:
  /// **'Cards'**
  String get cards;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'es', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'es': return AppLocalizationsEs();
    case 'ru': return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
