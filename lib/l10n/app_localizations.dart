import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_vi.dart';

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
    Locale('vi'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Astrology AI'**
  String get appName;

  /// No description provided for @vietnamese.
  ///
  /// In en, this message translates to:
  /// **'Vietnamese'**
  String get vietnamese;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @homePageTitle.
  ///
  /// In en, this message translates to:
  /// **'Your Personal Horoscope'**
  String get homePageTitle;

  /// No description provided for @homePageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your birth details to reveal your cosmic blueprint.'**
  String get homePageSubtitle;

  /// No description provided for @dateOfBirth.
  ///
  /// In en, this message translates to:
  /// **'Date of Birth'**
  String get dateOfBirth;

  /// No description provided for @dateOfBirthHint.
  ///
  /// In en, this message translates to:
  /// **'DD/MM/YYYY'**
  String get dateOfBirthHint;

  /// No description provided for @timeOfBirth.
  ///
  /// In en, this message translates to:
  /// **'Time of Birth'**
  String get timeOfBirth;

  /// No description provided for @timeOfBirthHint.
  ///
  /// In en, this message translates to:
  /// **'HH:MM (24-hour format)'**
  String get timeOfBirthHint;

  /// No description provided for @placeOfBirth.
  ///
  /// In en, this message translates to:
  /// **'Place of Birth'**
  String get placeOfBirth;

  /// No description provided for @placeOfBirthHint.
  ///
  /// In en, this message translates to:
  /// **'City, Country'**
  String get placeOfBirthHint;

  /// No description provided for @getHoroscopeButton.
  ///
  /// In en, this message translates to:
  /// **'Get Basic Horoscope'**
  String get getHoroscopeButton;

  /// No description provided for @getPremiumHoroscopeButton.
  ///
  /// In en, this message translates to:
  /// **'Get Premium Horoscope'**
  String get getPremiumHoroscopeButton;

  /// No description provided for @horoscopeResults.
  ///
  /// In en, this message translates to:
  /// **'Horoscope Results'**
  String get horoscopeResults;

  /// No description provided for @personality.
  ///
  /// In en, this message translates to:
  /// **'Personality'**
  String get personality;

  /// No description provided for @overview.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get overview;

  /// No description provided for @love.
  ///
  /// In en, this message translates to:
  /// **'Love'**
  String get love;

  /// No description provided for @career.
  ///
  /// In en, this message translates to:
  /// **'Career'**
  String get career;

  /// No description provided for @health.
  ///
  /// In en, this message translates to:
  /// **'Health'**
  String get health;

  /// No description provided for @finance.
  ///
  /// In en, this message translates to:
  /// **'Finance'**
  String get finance;

  /// No description provided for @advice.
  ///
  /// In en, this message translates to:
  /// **'Advice'**
  String get advice;

  /// No description provided for @deeperAnalysis.
  ///
  /// In en, this message translates to:
  /// **'Deeper Analysis'**
  String get deeperAnalysis;

  /// No description provided for @errorHistory.
  ///
  /// In en, this message translates to:
  /// **'Error loading history'**
  String get errorHistory;

  /// No description provided for @noHistory.
  ///
  /// In en, this message translates to:
  /// **'No history found. Get a new horoscope to see it here!'**
  String get noHistory;

  /// No description provided for @birthInfoLabel.
  ///
  /// In en, this message translates to:
  /// **'Birth Info'**
  String get birthInfoLabel;

  /// No description provided for @atLabel.
  ///
  /// In en, this message translates to:
  /// **'At'**
  String get atLabel;

  /// No description provided for @viewedOnLabel.
  ///
  /// In en, this message translates to:
  /// **'Viewed on'**
  String get viewedOnLabel;

  /// No description provided for @refreshHistory.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get refreshHistory;

  /// No description provided for @errorGeneral.
  ///
  /// In en, this message translates to:
  /// **'An unknown error occurred.'**
  String get errorGeneral;

  /// No description provided for @errorMissingInput.
  ///
  /// In en, this message translates to:
  /// **'Please fill in all birth details.'**
  String get errorMissingInput;

  /// No description provided for @errorFetching.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while fetching the reading.'**
  String get errorFetching;

  /// No description provided for @personalNotes.
  ///
  /// In en, this message translates to:
  /// **'Personal Notes'**
  String get personalNotes;

  /// No description provided for @editNote.
  ///
  /// In en, this message translates to:
  /// **'Edit Note'**
  String get editNote;

  /// No description provided for @noteHint.
  ///
  /// In en, this message translates to:
  /// **'Write your thoughts here...'**
  String get noteHint;

  /// No description provided for @saveButton.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get saveButton;

  /// No description provided for @cancelButton.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelButton;

  /// No description provided for @noNotesYet.
  ///
  /// In en, this message translates to:
  /// **'No notes yet. Tap the edit icon to add one!'**
  String get noNotesYet;

  /// No description provided for @shareHoroscope.
  ///
  /// In en, this message translates to:
  /// **'Share Horoscope'**
  String get shareHoroscope;

  /// No description provided for @shareSubject.
  ///
  /// In en, this message translates to:
  /// **'My Horoscope from Astrology AI!'**
  String get shareSubject;

  /// No description provided for @premiumUpgrade.
  ///
  /// In en, this message translates to:
  /// **'This is a basic reading. For a deeper analysis including Health, get a Premium Horoscope!'**
  String get premiumUpgrade;

  /// No description provided for @libraryTitle.
  ///
  /// In en, this message translates to:
  /// **'Astrology Library'**
  String get libraryTitle;

  /// No description provided for @librarySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Explore the mystical terms of astrology. Tap a term to learn more.'**
  String get librarySubtitle;

  /// No description provided for @compatibilityTitle.
  ///
  /// In en, this message translates to:
  /// **'Zodiac Compatibility'**
  String get compatibilityTitle;

  /// No description provided for @compatibilitySubtitle.
  ///
  /// In en, this message translates to:
  /// **'See how well two signs match'**
  String get compatibilitySubtitle;

  /// No description provided for @checkButton.
  ///
  /// In en, this message translates to:
  /// **'Check Compatibility'**
  String get checkButton;

  /// No description provided for @resultsTitle.
  ///
  /// In en, this message translates to:
  /// **'Results'**
  String get resultsTitle;

  /// No description provided for @scoreLabel.
  ///
  /// In en, this message translates to:
  /// **'Score'**
  String get scoreLabel;

  /// No description provided for @summaryLabel.
  ///
  /// In en, this message translates to:
  /// **'Summary'**
  String get summaryLabel;

  /// No description provided for @adviceLabel.
  ///
  /// In en, this message translates to:
  /// **'Advice'**
  String get adviceLabel;

  /// No description provided for @homeTab.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get homeTab;

  /// No description provided for @historyTab.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get historyTab;

  /// No description provided for @libraryTab.
  ///
  /// In en, this message translates to:
  /// **'Library'**
  String get libraryTab;
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
      <String>['en', 'vi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'vi':
      return AppLocalizationsVi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
