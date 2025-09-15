// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Astro AI';

  @override
  String get homePageTitle => 'Your Horoscope';

  @override
  String get homePageSubtitle =>
      'Enter your birth information to get your personalized horoscope.';

  @override
  String get dateOfBirth => 'Date of Birth';

  @override
  String get dateOfBirthHint => 'DD/MM/YYYY';

  @override
  String get timeOfBirth => 'Time of Birth';

  @override
  String get timeOfBirthHint => 'HH:MM';

  @override
  String get placeOfBirth => 'Place of Birth';

  @override
  String get placeOfBirthHint => 'City, Country';

  @override
  String get getHoroscopeButton => 'Get Horoscope';

  @override
  String get language => 'Language';

  @override
  String get vietnamese => 'Vietnamese';

  @override
  String get english => 'English';

  @override
  String get shareHoroscope => 'Share Horoscope';

  @override
  String get shareSubject => 'My daily horoscope!';

  @override
  String get overview => 'Overview';

  @override
  String get love => 'Love';

  @override
  String get career => 'Career';

  @override
  String get finance => 'Finance';

  @override
  String get advice => 'Advice';

  @override
  String get health => 'Health';

  @override
  String get deeperAnalysis => 'Deeper Analysis';

  @override
  String get premiumUpgrade =>
      'Upgrade to Premium for deeper analysis on health and other aspects!';
}
