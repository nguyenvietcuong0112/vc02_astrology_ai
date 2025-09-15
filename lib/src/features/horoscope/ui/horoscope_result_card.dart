import 'package:flutter/material.dart';
import 'package:myapp/src/features/horoscope/ui/widgets/result_section.dart';
import 'package:share_plus/share_plus.dart';

class HoroscopeResultCard extends StatelessWidget {
  final Map<String, dynamic> result;

  const HoroscopeResultCard({super.key, required this.result});

  void _shareHoroscope(BuildContext context) {
    final String overview = result['overview'] ?? '';
    final String love = result['love'] ?? '';
    final String career = result['career'] ?? '';
    final String finance = result['finance'] ?? '';
    final String advice = result['advice'] ?? '';

    final String shareText = """
    🌟 Tổng quan: $overview

    💖 Tình yêu: $love

    💼 Sự nghiệp: $career

    💰 Tài chính: $finance

    🧘‍♂️ Lời khuyên: $advice
    """;

    Share.share(shareText);
  }

  @override
  Widget build(BuildContext context) {
    final bool isPremiumResult = result.containsKey('health');

    return Card(
      margin: const EdgeInsets.only(top: 30),
      color: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: isPremiumResult ? BorderSide(color: Colors.amber[700]!, width: 2) : BorderSide.none,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ResultSection(title: '🌟 Tổng quan', content: result['overview'] ?? '...'),
            ResultSection(title: '💖 Tình yêu', content: result['love'] ?? '...'),
            ResultSection(title: '💼 Sự nghiệp', content: result['career'] ?? '...'),
            ResultSection(title: '💰 Tài chính', content: result['finance'] ?? '...'),
            if (isPremiumResult)
              ResultSection(title: '⚕️ Sức khỏe', content: result['health'] ?? '...'),
            if (isPremiumResult)
              ResultSection(title: '🔮 Phân tích chuyên sâu', content: result['deeper_analysis'] ?? '...'),
            ResultSection(title: '🧘‍♂️ Lời khuyên', content: result['advice'] ?? '...'),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                onPressed: () => _shareHoroscope(context),
                icon: const Icon(Icons.share, size: 16),
                label: const Text("Chia sẻ lá số"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurpleAccent,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
            if (!isPremiumResult) ...[
              const SizedBox(height: 15),
              Center(
                child: Text(
                  "Nâng cấp lên Premium để có phân tích sâu hơn về sức khỏe và các khía cạnh khác!",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.deepPurpleAccent[100], fontSize: 14),
                ),
              )
            ]
          ],
        ),
      ),
    );
  }
}
