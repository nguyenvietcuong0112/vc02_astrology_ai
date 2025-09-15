// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get discoverCosmicPath => 'Discover Your Cosmic Path';

  @override
  String get enterBirthDetails =>
      'Enter your birth details for a personalized horoscope.';

  @override
  String get dateOfBirth => 'Date of Birth';

  @override
  String get dateOfBirthHint => 'E.g., 03/05/2000';

  @override
  String get timeOfBirth => 'Time of Birth';

  @override
  String get timeOfBirthHint => 'E.g., 6:00 AM';

  @override
  String get placeOfBirth => 'Place of Birth';

  @override
  String get placeOfBirthHint => 'E.g., Hanoi, Vietnam';

  @override
  String get revealHoroscope => 'Reveal My Horoscope';

  @override
  String get revealPremiumHoroscope => 'Reveal Premium Horoscope';

  @override
  String get shareHoroscope => 'Share My Horoscope';

  @override
  String get overview => 'Overview';

  @override
  String get love => 'Love';

  @override
  String get career => 'Career';

  @override
  String get finance => 'Finance';

  @override
  String get health => 'Health';

  @override
  String get deeperAnalysis => 'Deeper Analysis';

  @override
  String get advice => 'Advice';

  @override
  String get upgradeToPremium =>
      '👉 For a more detailed analysis, you can upgrade to Premium ✨';

  @override
  String horoscopeResult(
    Object advice,
    Object career,
    Object finance,
    Object love,
    Object overview,
  ) {
    return '🌟 My Horoscope 🌟\n\n💖 *Love:* $love\n\n💼 *Career:* $career\n\n💰 *Finance:* $finance\n\n🧘‍♂️ *Advice:* $advice\n\n$overview';
  }

  @override
  String get errorOccurred =>
      'An error occurred while processing the response. Please try again.';

  @override
  String get enterCompleteBirthInfo =>
      'Please enter your complete birth information.';
}
