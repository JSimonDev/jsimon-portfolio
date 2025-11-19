import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
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
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('hi'),
    Locale('zh')
  ];

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Jonathan Simon'**
  String get name;

  /// No description provided for @roleLarge.
  ///
  /// In en, this message translates to:
  /// **'Software Developer | Tech Enthusiast'**
  String get roleLarge;

  /// No description provided for @roleSmall.
  ///
  /// In en, this message translates to:
  /// **'Software Developer'**
  String get roleSmall;

  /// No description provided for @phrase.
  ///
  /// In en, this message translates to:
  /// **'Welcome to my digital garden 🌱, a space where I cultivate and share my discoveries about developing exceptional products, continually refining myself as a developer, and evolving my career in the vast world of technology.'**
  String get phrase;

  /// No description provided for @contactButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get contactButtonLabel;

  /// No description provided for @expirienceTitle.
  ///
  /// In en, this message translates to:
  /// **'Experience'**
  String get expirienceTitle;

  /// No description provided for @projectsTitle.
  ///
  /// In en, this message translates to:
  /// **'Projects'**
  String get projectsTitle;

  /// No description provided for @technologiesTitle.
  ///
  /// In en, this message translates to:
  /// **'Technologies I have worked with'**
  String get technologiesTitle;

  /// No description provided for @contactTitle.
  ///
  /// In en, this message translates to:
  /// **'Contact Me'**
  String get contactTitle;

  /// No description provided for @cotizameName.
  ///
  /// In en, this message translates to:
  /// **'Cotízame'**
  String get cotizameName;

  /// No description provided for @cotizameRole.
  ///
  /// In en, this message translates to:
  /// **'Mobile Developer (Flutter)'**
  String get cotizameRole;

  /// No description provided for @cotizameTimelapse.
  ///
  /// In en, this message translates to:
  /// **'2023 - Present'**
  String get cotizameTimelapse;

  /// No description provided for @cotizameExperienceDescription.
  ///
  /// In en, this message translates to:
  /// **'In the development of \"Cotízame\", an innovative mobile application that facilitates interaction between buyers and sellers through direct quotation requests, I lead the creation of the user interface and design, using Flutter. My role is fundamental in the conceptualization and execution of an intuitive user experience, significantly contributing to the distinctive character and usability of the application. This project has been an excellent opportunity to delve deeper into Flutter and Dart, strengthening my skills in interface design and collaboration to deliver a revolutionary market solution.'**
  String get cotizameExperienceDescription;

  /// No description provided for @cotizameProjectDescription.
  ///
  /// In en, this message translates to:
  /// **'Cotízame is an innovative mobile application designed in Flutter, specifically aimed, though not exclusively, at the population of the Dominican Republic. Cotizame revolutionizes the way buyers and sellers interact, giving the buyer a more active role in the purchasing process. Through this application, users can draft and send detailed quotation requests specifying the desired product or service and the price they are willing to pay. These requests are sent directly to selected sellers, who can respond with personalized offers. Upon accepting an offer, a purchase order is automatically generated, initiating the payment and delivery process. Cotizame stands out for its modern and user-friendly interface, facilitating intuitive navigation and efficient processing of quotation requests, all within a fast and accessible mobile environment.'**
  String get cotizameProjectDescription;

  /// No description provided for @freelanceName.
  ///
  /// In en, this message translates to:
  /// **'Freelance'**
  String get freelanceName;

  /// No description provided for @freelanceRole.
  ///
  /// In en, this message translates to:
  /// **'Web Developer / Mobile Developer (Ionic, Flutter)'**
  String get freelanceRole;

  /// No description provided for @freelanceTimelapse.
  ///
  /// In en, this message translates to:
  /// **'2022 - 2023'**
  String get freelanceTimelapse;

  /// No description provided for @freelanceExperienceDescription.
  ///
  /// In en, this message translates to:
  /// **'Personal projects and freelance work have been key in expanding development and design skills, facilitating the exploration of innovative solutions independently. These experiences have reinforced the ability to manage projects and solve technical challenges with creativity, without relying on traditional structures.'**
  String get freelanceExperienceDescription;

  /// No description provided for @riveColorModifierProjectName.
  ///
  /// In en, this message translates to:
  /// **'Rive Color Modifier'**
  String get riveColorModifierProjectName;

  /// No description provided for @riveColorModifierProjectDescription.
  ///
  /// In en, this message translates to:
  /// **'Rive Color Modifier is a Flutter package that allows you to dynamically modify the colors of your Rive animations. If you work with animations in your application, this package can be a valuable tool for adjusting colors in real time.\n\nHere are the key details about the package:\n\n- Usage: To use Rive Color Modifier, simply add the dependency to your `pubspec.yaml` file. Then, in your code, you can create instances of `RiveColorModifier` and apply color changes to your Rive animations.\n- Benefits:\n    1. Flexibility: Modify animation colors without altering the original Rive files.\n    2. Interactivity: Adjust colors in real time, useful for customizable themes or dynamic animations.\n    3. Optimization: Avoid duplicating Rive files just to change colors. Making use of RiveRenderObject to apply color changes directly to the Rive animation.'**
  String get riveColorModifierProjectDescription;

  /// No description provided for @cinemapediaName.
  ///
  /// In en, this message translates to:
  /// **'Cinemapedia'**
  String get cinemapediaName;

  /// No description provided for @cinemapediaProjectDescription.
  ///
  /// In en, this message translates to:
  /// **'Cinemapedia is an application developed using Flutter and TheMovieDB API, providing users with a platform to explore detailed information about current movies, upcoming releases, and the most popular ones. The app allows users to mark movies as favorites, view trailers, learn about the cast, and perform searches by name, genre, or keywords. It also offers information on actors, film categories, and movie ratings, enabling users to have a comprehensive and enriching experience in their engagement with cinema.'**
  String get cinemapediaProjectDescription;

  /// No description provided for @frescomaxName.
  ///
  /// In en, this message translates to:
  /// **'Frescomax'**
  String get frescomaxName;

  /// No description provided for @frescomaxRole.
  ///
  /// In en, this message translates to:
  /// **'Full Stack & Cloud Engineer'**
  String get frescomaxRole;

  /// No description provided for @frescomaxTimelapse.
  ///
  /// In en, this message translates to:
  /// **'2025 - Present'**
  String get frescomaxTimelapse;

  /// No description provided for @frescomaxExperienceDescription.
  ///
  /// In en, this message translates to:
  /// **'As the sole developer, I built the entire ecosystem from scratch. I developed both the application (Flutter) and the Backend (API). Designed and deployed the infrastructure on AWS using Elastic Beanstalk, S3, and CloudFront for video streaming. Implemented Clean Architecture with Riverpod, ensuring a scalable and high-performance product on iOS, Android, and Web.'**
  String get frescomaxExperienceDescription;

  /// No description provided for @frescomaxProjectDescription.
  ///
  /// In en, this message translates to:
  /// **'Frescomax is a cross-platform app (iOS, Android, Web) that serves as an interactive catalog and visualization tool for fans. It features a detailed product catalog, advanced customization with real-time color selection, and an AR-like virtual assembly tool to visualize fans in real spaces. Built with Flutter and Clean Architecture, it ensures a premium user experience with smooth animations and a responsive design.'**
  String get frescomaxProjectDescription;

  /// No description provided for @contactDescription.
  ///
  /// In en, this message translates to:
  /// **'If you want to know more about me, my work, or just want to chat, don\'t hesitate to contact me. I\'m always open to new opportunities and collaborations.'**
  String get contactDescription;

  /// No description provided for @licenseButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Licenses'**
  String get licenseButtonLabel;

  /// No description provided for @goToTopButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Go to top'**
  String get goToTopButtonLabel;

  /// No description provided for @goToWebsiteButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Go to website'**
  String get goToWebsiteButtonLabel;

  /// No description provided for @lifePolicies.
  ///
  /// In en, this message translates to:
  /// **'Life Policies'**
  String get lifePolicies;

  /// No description provided for @footerPhrasePart1.
  ///
  /// In en, this message translates to:
  /// **'Made with'**
  String get footerPhrasePart1;

  /// No description provided for @footerPhrasePart2.
  ///
  /// In en, this message translates to:
  /// **'from Dominican Republic'**
  String get footerPhrasePart2;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es', 'hi', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'hi':
      return AppLocalizationsHi();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
