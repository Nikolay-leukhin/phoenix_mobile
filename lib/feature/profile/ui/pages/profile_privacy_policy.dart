import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:izobility_mobile/localization/app_localizations.dart';
import 'package:izobility_mobile/utils/ui/colors.dart';
import 'package:izobility_mobile/utils/ui/fonts.dart';
import 'package:izobility_mobile/widgets/app_bar/custom_app_bar.dart';
import 'package:izobility_mobile/widgets/button/custom_text_button.dart';
import 'package:izobility_mobile/widgets/scaffold/home_scaffold.dart';

class ProfilePrivacyPolicyScreen extends StatefulWidget {
  const ProfilePrivacyPolicyScreen({super.key});

  @override
  State<ProfilePrivacyPolicyScreen> createState() => _ProfilePrivacyPolicyScreenState();
}

class _ProfilePrivacyPolicyScreenState extends State<ProfilePrivacyPolicyScreen> {
  @override
  Widget build(BuildContext context) {
    final localize = AppLocalizations.of(context)!;

    return Container(
      color: Colors.white,
      child: Scaffold(
          backgroundColor: AppColors.purpleBcg,
          appBar: CustomAppBar(
            context: context,
            text: localize.privacy_policy,
            isBack: true,
            onTap: () {
              context.pop();
            },
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 70,
                    child: Image.asset(
                      "assets/images/logo.png",
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Text(
                    """
EMERALD VERSE  
Privacy Policy
Effective date: 05/05/ 2022
We are the EMERALD VERSE company . We provide the EMERALD VERSE augmented reality platform designed to enable you to interact with other participants in shared virtual worlds organically blended with the real world. To do this, we need some information about you. Protecting your privacy is very important to us. We use your data exclusively for legal reasons. This Privacy Policy will help you understand what information we collect, how we use it, and what choices you have when you play our game or visit our website (collectively, the "Services").
1.     What information we collect about you and how we use it
This Privacy Policy defines how we use any information that may or could be used to identify you ("Personal Data"). It does not apply to information that cannot be used to identify you ("Depersonalized Data").
We need to collect and use certain Personal Data in order to provide you with Services and fulfill our promises given by us in the User Agreement:
•        When you subscribe to the Services, you provide us with your Personal Data voluntarily, for example, when creating an account. We collect and use such data to enable your authentication when logging into your account and using the Services, to make sure that you have legitimate access to the Services, as well as to receive timely information about updates. Such data includes the user name that you choose to use on our Services (in the @username format), as well as the internal identifiers of your account assigned by us, and the phone number specified during registration.
We collect and use information about the location of your device when you use our Services, including your movements and events occurring during the game. Our Services include a location-based game, the main function of which is to provide a game reality tied to your location in the real world, so we need to know where you are in order to customize the game for you and plan the locations of game resources. We determine your location using various technologies, including GPS, WiFi access points that you connect to when using the Services, as well as the location of mobile or cellular repeater towers.
•        We also collect and use data about your actions and achievements in the game, as well as certain information about your mobile device (including device identifiers, device operating system, its model, configuration and settings), which allows us to adjust the operation of the Services to your requirements and personalize your gameplay and user interface.
•        We also use the above information to show in-game locations of sponsors that are located close to you as part of the gameplay.
•        In addition, we use the above information to provide you with technical and customer support.
•        You also provide us with Personal Data when you subscribe to our publications, participate in competitions, or communicate with us. Depending on which of the Services you use, you can specify in your Personal Account your name, phone number, country of permanent residence, city, date of birth (when it is necessary to establish your right to admission), gender, email address and upload your photo. We use this information to provide you with these Services and to provide you with related customer support.
In addition, we rely on a legitimate interest in using your Personal Data for the following purposes:
•        Your IP address, browser type, your operating system, web pages that you visited before switching to our Services, pages of our Services that you viewed or the functions you used, as well as the time you spent on these pages or functions, links to our Services that you activated, identifiers devices and advertising networks, as well as your actions in the game, your in–game user settings and preferences and your in-game microtransactions - in order to understand who uses our Services and how.
•        Your contact information, namely, your email address – in order to contact you for technical and customer support.

•        Your email address and information about your device – to share updates and news with you directly in the game or by email. You can unsubscribe from this at any time using your device or app settings.
•        Analysis of your actions and achievements in the game – to show you gifts, promotions and other offers related to our Services, personalized for your personal user experience. You can opt out of this and a number of other types of processing of your Personal Data by performing the actions described below in section 6.
•        To provide social features in our games so that you can interact and play with other players, including saving your correspondence with these players, finding your friends and allowing other players to find you, as well as sharing your gaming experience and achievements with friends.
•        To provide augmented reality functionality. To do this, EMERALD VERSE needs to receive geospatial data from your device's camera. Such data is then processed by the EMERALD VERSE servers in such a way as to allow you and other players to interact surrounded by the same virtual objects at the same time in a common physical space.
•        To offer new or additional features of our Services.
•        To organize and conduct in-person events dedicated to our games or based on them. Please note that when you participate in in-person events, your in-game actions and achievements, user name, your avatar, your team name and other attributes of your in-game profile will be visible to other participants of the event and to an unlimited number of people (for example, on banners displayed at the event and online).
•        Data about your actions and achievements in games, as well as certain information about your mobile device (including device identifiers, operating system of a device, its model, configuration and settings, as well as third–party applications and programs installed on it) - to implement measures to counter fraud and cheating – actions prohibited by our User Agreement in order to be sure that we provide equal gaming opportunities to all participants of the game.
•        To disclose information when required by law, as well as when it is necessary to make claims, exercise rights or protect against claims of third parties.
For the following purposes, we will use your Personal Data only with your consent:
•        We will send you marketing materials by email or via app notifications. You can unsubscribe from this at any time using your device or app settings.
2.     Who do we share information with
We will not disclose any Personal Data received from or about you, except in the following cases:
Communication of information to our service providers. We involve third-party service providers to work with us to administer and provide Services. As part of this process, they will process your Personal Data on our behalf. Such third-party service providers will have access to your Personal Data only to provide services on our behalf and in accordance with this Privacy Policy. We make sure that each of the service providers is bound by contractual obligations not to disclose or use your Personal Data for any other purpose. The service providers whose services we use help us:
•        launch, administer and maintain our Services using third-party platforms and software tools;
•        perform content moderation and failure analysis;
•        conduct e-mail and mobile messaging campaigns;
•        conduct gaming and marketing analytics;
•        provide measurement and targeted advertising services (You can unsubscribe from the mailing list through the notification settings in the App);
•        conduct in-person events, competitions, including registration of players, management of registration and attendance of participants, verification of the eligibility of attendance at the event;
•        determine the origin of payments;
•        provide technical and customer support; and
•        process payments for tickets to in-person events and for other purchases.

Some third-party service providers may also collect information directly from you (for example, a payment acceptance operator may request your billing or financial information) as third-party actors in accordance with their own rules for the protection of such information. Such third-party service providers do not share your financial information with EMERALD VERSE, such as your credit card number, but may provide us with a limited amount of information related to your purchases, such as your zip code. We do not store your financial information, but transfer it to the payment service provider.
Communication of information to other players. When you use the Services, in particular when you play our games, use social functions in them (including cross-game functions) or participate in in-person events, we will share your Personal Data with other players. Such Personal Data includes your in-game profile data (such as your user name, your avatar, your online status and your team), your in-game actions and achievements, the location in the real world of the resources with which you interact in the game, and your public messages in the game. In addition, the game contains links to third-party services through which you can share information outside of the Services; EMERALD VERSE does not control and is not responsible for the operation of such third-party functionality for information exchange.
Information communicated to third parties. We exchange depersonalized data with third parties for the purposes of industry and market analysis. We may share data with our third-party publishing partners for their direct marketing activities, but only with your direct consent. We do not share Personal Data with any other third parties for direct marketing purposes.
Information disclosed for our protection and protection of other persons. We provide assistance to government and law enforcement agencies or private organizations in ensuring compliance with the law. We disclose information about you to government and law enforcement agencies or private organizations when, in our reasonable judgment, it is necessary or appropriate: (a) to respond to claims, procedural documents (including subpoenas and warrants); (b) to protect and ensure the safety and security of our property and our rights, as well as the safety of third parties individuals or society as a whole; and (c) to detect and stop any actions that we consider illegal, unethical or giving grounds for prosecution.
Information disclosed in connection with deals. The information we receive from our users, including Personal Data, is a business asset. If we are acquired by a third party as a result of a deal such as a merger, acquisition or purchase of a property complex, or if our assets are acquired by a third party in the event of our going out of business or bankruptcy proceedings, some or all of our assets, including your Personal Data, will be disclosed or transferred to the acquirer in connection with such a deal.
3.     How your Personal Data is transmitted
EMERALD VERSE provides its Services all over the world. It is highly likely that your Personal Data will be transferred outside of your country and stored in another country, including the United States, for the purposes specified in this Privacy Policy, if permitted by applicable law. The legislation of these countries on protection of personal data may differ from the legislation of your country.
If we transfer your Personal Data from EEA countries to other countries, including the USA, we will ensure that the level of protection of your Personal Data is similar to that in force in the EEA, making sure that at least one of the following conditions is met:
•        The country to which your Personal Data is transferred, in the opinion of the European Commission, provides an adequate level of Personal Data protection, as in the EEA.
•        When engaging service providers, we use special contracts in the form approved by the European Commission, which provide the same protection of Personal Data that they use in Europe.

•        If we involve service providers from the USA, they will be subject to the EU-US Data Protection Agreement, which requires them to provide your Personal Data with the same protection that they enjoy in the EEA.
4.     How we protect your Personal Data
We use appropriate legal, organizational and technical security measures to protect your Personal Data from accidental loss, unauthorized use or access, improper modification or disclosure. We also provide access to your Personal Data only to those employees, agents, contractors and other third parties who need it for their work. They will process your Personal Data only on the basis of our instructions and are bound by confidentiality obligations. We have implemented procedures that establish the course for actions in case of suspicion of a breach of confidentiality (leak) of Personal data. If we have such an obligation under the law, we will notify you and the competent supervisory authority of such a leak.
5.     How long we store your Personal Data
We store your Personal Data for the entire period of providing you with the Services and until the goals specified in this Privacy Policy are achieved. This also applies to everyone with whom we share your information and who provides services on our behalf.
When we no longer need to use your Personal Data and store it in accordance with our legal obligations, we will either delete them from our systems or anonymize them in such a way that they can no longer be associated with you. When deleting Personal Data, we will take commercially and technically appropriate measures to ensure that it is impossible to restore or reproduce such Personal Data.
6.     Your rights and choices opportunities
You have certain rights with respect to your Personal Data. To exercise these rights, please contact us via support@z-boom.com
You can:
•        request access to your Personal Data that we have by sending an e-mail request to support@
•        delete or correct your Personal Data. The easiest way to update your account data is to change the information in your account or in your app settings. You can also do this by sending a request to our customer support service@
•        request us to stop processing your Personal Data, including for advertising and marketing purposes, such as personalized awards, promotions and other offers, by emailing us at info@
•        keep in mind that sometimes we need your Personal Data to provide you with Services;
•        request to transfer your Personal Data to another organization (if technically possible);
•        file a complaint with the competent supervisory authority. We would like to be able to solve problems directly with you, so we would prefer that you contact us first. However, if you are located in an EEA country and believe that we do not comply with data protection legislation, you can file a complaint with your local competent supervisory authority.
The law provides for exceptions to these rights in certain circumstances. When you are unable to exercise any of these rights due to the effect of such an exception, we will explain the reason to you.
We offer you a choice regarding the collection, use and transfer of your Personal Data and we will respect your choice. Please note: if you decide not to provide us with the Personal Data we request, you will not be able to access all the functions of the Services.
After you contact us, you can receive an email with the purpose of verifying the authenticity of the appeal. We will strive to provide you with information or fulfill your other request within 30 days or within a shorter period provided for by the legislation of your country.
7.     Children
Unless otherwise specified for a particular Service, children are not allowed to use the Services, and we do not collect their Personal Data. We define the concept of "children" as follows:
•        EEA residents: persons under the age of 16 or the age from which a person can provide consent to the processing of personal data in a relevant country;

•        Residents of the Republic of Korea: persons under the age of 14;
•        residents of other regions: persons under the age of 13 or the age from which a person can provide consent to the processing of personal data in a relevant country.
If we find out that we have received a child's Personal Data without parental consent, we will take steps to delete such information from our files as soon as possible.
If you have any questions about how we handle children's personal data, please contact us by email at support@
8.     Changes to this Privacy Policy
Any Personal Data we collect is subject to the Privacy Policy as amended at the time of its collection. We may make changes to this Privacy Policy from time to time. You will be duly notified of any material change.
9.     Third parties
When using our Services, you may access links to sites and services owned or operated by third parties (each such service is a "Third–Party Service"). Any information provided by you to a Third-Party Service or on a Third-Party Service or collected through a Third-Party Service is provided directly to the owner or operator of the Third-Party Service, and its privacy regime is determined by the policy of such owner or operator. We are not responsible for the content, security or reliability of any Third-Party Services and for the methods and policies used by them to protect information. In order to protect your information, we recommend that you carefully read the privacy policy of any Third-Party Service that you access.
10.  Special disclosure requirements about persons with permanent residence in the State of California
California law requires us to disclose certain information about you. We do not sell your Personal Data. The information listed in section 2 falls under the following categories of the California Consumer Privacy Act (CCPA): identifiers, commercial information, information about activity on the Internet or other electronic networks, geolocation data and video information.
11.  Disclosure of information for specific games
Additional Privacy information for EMERALD VERSE
Children's accounts. We comply with the requirements for obtaining parental consent prescribed by the US Children’s Online Privacy Protection Act (COPPA), European data protection legislation (including, but not limited to the General Data Protection Regulation (GDPR)) and the applicable data protection legislation of your country, using verification tools.
Parents have the right to refuse the subsequent collection, use and (or) disclosure of their Child's Personal Data by sending us a corresponding notification. As a Parent, you understand that EMERALD LTD has a legitimate interest in disclosing information about your Child obtained through the Services to third-party providers for the sole purpose of administering or providing the Services, as described in section 3 of this Privacy Policy. """,
                    style:
                        AppTypography.font14w400.copyWith(color: Colors.black),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
