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
  /// In vi, this message translates to:
  /// **'Chiêm Tinh AI'**
  String get appName;

  /// No description provided for @homePageTitle.
  ///
  /// In vi, this message translates to:
  /// **'Tử Vi Của Bạn'**
  String get homePageTitle;

  /// No description provided for @homePageSubtitle.
  ///
  /// In vi, this message translates to:
  /// **'Nhập thông tin ngày sinh của bạn để có được lá số tử vi được cá nhân hóa.'**
  String get homePageSubtitle;

  /// No description provided for @dateOfBirth.
  ///
  /// In vi, this message translates to:
  /// **'Ngày sinh'**
  String get dateOfBirth;

  /// No description provided for @dateOfBirthHint.
  ///
  /// In vi, this message translates to:
  /// **'DD/MM/YYYY'**
  String get dateOfBirthHint;

  /// No description provided for @timeOfBirth.
  ///
  /// In vi, this message translates to:
  /// **'Giờ sinh'**
  String get timeOfBirth;

  /// No description provided for @timeOfBirthHint.
  ///
  /// In vi, this message translates to:
  /// **'HH:MM'**
  String get timeOfBirthHint;

  /// No description provided for @placeOfBirth.
  ///
  /// In vi, this message translates to:
  /// **'Nơi sinh'**
  String get placeOfBirth;

  /// No description provided for @placeOfBirthHint.
  ///
  /// In vi, this message translates to:
  /// **'Thành phố, Quốc gia'**
  String get placeOfBirthHint;

  /// No description provided for @getHoroscopeButton.
  ///
  /// In vi, this message translates to:
  /// **'Xem Tử Vi'**
  String get getHoroscopeButton;

  /// No description provided for @language.
  ///
  /// In vi, this message translates to:
  /// **'Ngôn ngữ'**
  String get language;

  /// No description provided for @vietnamese.
  ///
  /// In vi, this message translates to:
  /// **'Tiếng Việt'**
  String get vietnamese;

  /// No description provided for @english.
  ///
  /// In vi, this message translates to:
  /// **'Tiếng Anh'**
  String get english;

  /// No description provided for @shareHoroscope.
  ///
  /// In vi, this message translates to:
  /// **'Chia sẻ Tử Vi'**
  String get shareHoroscope;

  /// No description provided for @shareSubject.
  ///
  /// In vi, this message translates to:
  /// **'Tử vi hàng ngày của tôi!'**
  String get shareSubject;

  /// No description provided for @overview.
  ///
  /// In vi, this message translates to:
  /// **'Tổng quan'**
  String get overview;

  /// No description provided for @love.
  ///
  /// In vi, this message translates to:
  /// **'Tình yêu'**
  String get love;

  /// No description provided for @career.
  ///
  /// In vi, this message translates to:
  /// **'Sự nghiệp'**
  String get career;

  /// No description provided for @finance.
  ///
  /// In vi, this message translates to:
  /// **'Tài chính'**
  String get finance;

  /// No description provided for @advice.
  ///
  /// In vi, this message translates to:
  /// **'Lời khuyên'**
  String get advice;

  /// No description provided for @health.
  ///
  /// In vi, this message translates to:
  /// **'Sức khỏe'**
  String get health;

  /// No description provided for @deeperAnalysis.
  ///
  /// In vi, this message translates to:
  /// **'Phân tích chuyên sâu'**
  String get deeperAnalysis;

  /// No description provided for @premiumUpgrade.
  ///
  /// In vi, this message translates to:
  /// **'Nâng cấp lên Premium để có phân tích sâu hơn về sức khỏe và các khía cạnh khác!'**
  String get premiumUpgrade;
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
