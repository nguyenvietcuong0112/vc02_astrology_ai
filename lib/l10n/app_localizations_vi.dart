// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get discoverCosmicPath => 'Khám phá Con đường Vũ trụ của Bạn';

  @override
  String get enterBirthDetails =>
      'Nhập thông tin ngày sinh của bạn để nhận lá số tử vi được cá nhân hóa.';

  @override
  String get dateOfBirth => 'Ngày sinh';

  @override
  String get dateOfBirthHint => 'Ví dụ: 03/05/2000';

  @override
  String get timeOfBirth => 'Giờ sinh';

  @override
  String get timeOfBirthHint => 'Ví dụ: 6:00 SA';

  @override
  String get placeOfBirth => 'Nơi sinh';

  @override
  String get placeOfBirthHint => 'Ví dụ: Hà Nội, Việt Nam';

  @override
  String get revealHoroscope => 'Tiết lộ Lá số Tử vi của Tôi';

  @override
  String get revealPremiumHoroscope => 'Tiết lộ Lá số Tử vi Cao cấp';

  @override
  String get shareHoroscope => 'Chia sẻ Lá số Tử vi của Tôi';

  @override
  String get overview => 'Tổng quan';

  @override
  String get love => 'Tình yêu';

  @override
  String get career => 'Sự nghiệp';

  @override
  String get finance => 'Tài chính';

  @override
  String get health => 'Sức khỏe';

  @override
  String get deeperAnalysis => 'Phân tích sâu hơn';

  @override
  String get advice => 'Lời khuyên';

  @override
  String get upgradeToPremium =>
      '👉 Để có phân tích chi tiết hơn, bạn có thể nâng cấp lên Premium ✨';

  @override
  String horoscopeResult(
    Object advice,
    Object career,
    Object finance,
    Object love,
    Object overview,
  ) {
    return '🌟 Lá số Tử vi của Tôi 🌟\n\n💖 *Tình yêu:* $love\n\n💼 *Sự nghiệp:* $career\n\n💰 *Tài chính:* $finance\n\n🧘‍♂️ *Lời khuyên:* $advice\n\n$overview';
  }

  @override
  String get errorOccurred =>
      'Đã xảy ra lỗi khi xử lý phản hồi. Vui lòng thử lại.';

  @override
  String get enterCompleteBirthInfo =>
      'Vui lòng nhập đầy đủ thông tin ngày sinh của bạn.';
}
