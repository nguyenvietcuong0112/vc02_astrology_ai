// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Astrology AI';

  @override
  String get vietnamese => 'Vietnamese';

  @override
  String get english => 'English';

  @override
  String get homePageTitle => 'Your Personal Horoscope';

  @override
  String get homePageSubtitle =>
      'Enter your birth details to reveal your cosmic blueprint.';

  @override
  String get dateOfBirth => 'Date of Birth';

  @override
  String get dateOfBirthHint => 'DD/MM/YYYY';

  @override
  String get timeOfBirth => 'Time of Birth';

  @override
  String get timeOfBirthHint => 'HH:MM (24-hour format)';

  @override
  String get placeOfBirth => 'Place of Birth';

  @override
  String get placeOfBirthHint => 'City, Country';

  @override
  String get getHoroscopeButton => 'Get Basic Horoscope';

  @override
  String get getPremiumHoroscopeButton => 'Get Premium Horoscope';

  @override
  String get horoscopeResults => 'Horoscope Results';

  @override
  String get personality => 'Personality';

  @override
  String get overview => 'Overview';

  @override
  String get love => 'Love';

  @override
  String get career => 'Career';

  @override
  String get health => 'Health';

  @override
  String get finance => 'Finance';

  @override
  String get advice => 'Advice';

  @override
  String get deeperAnalysis => 'Deeper Analysis';

  @override
  String get errorHistory => 'Error loading history';

  @override
  String get noHistory =>
      'No history found. Get a new horoscope to see it here!';

  @override
  String get birthInfoLabel => 'Birth Info';

  @override
  String get atLabel => 'At';

  @override
  String get viewedOnLabel => 'Viewed on';

  @override
  String get refreshHistory => 'Refresh';

  @override
  String get errorGeneral => 'An unknown error occurred.';

  @override
  String get errorMissingInput => 'Please fill in all birth details.';

  @override
  String get errorFetching => 'An error occurred while fetching the reading.';

  @override
  String get personalNotes => 'Personal Notes';

  @override
  String get editNote => 'Edit Note';

  @override
  String get noteHint => 'Write your thoughts here...';

  @override
  String get saveButton => 'Save';

  @override
  String get cancelButton => 'Cancel';

  @override
  String get noNotesYet => 'No notes yet. Tap the edit icon to add one!';

  @override
  String get shareHoroscope => 'Share Horoscope';

  @override
  String get shareSubject => 'My Horoscope from Astrology AI!';

  @override
  String get premiumUpgrade =>
      'This is a basic reading. For a deeper analysis including Health, get a Premium Horoscope!';

  @override
  String get libraryTitle => 'Astrology Library';

  @override
  String get librarySubtitle =>
      'Explore the mystical terms of astrology. Tap a term to learn more.';

  @override
  String get compatibilityTitle => 'Zodiac Compatibility';

  @override
  String get compatibilitySubtitle => 'See how well two signs match';

  @override
  String get checkButton => 'Check Compatibility';

  @override
  String get resultsTitle => 'Results';

  @override
  String get scoreLabel => 'Score';

  @override
  String get summaryLabel => 'Summary';

  @override
  String get adviceLabel => 'Advice';
}
