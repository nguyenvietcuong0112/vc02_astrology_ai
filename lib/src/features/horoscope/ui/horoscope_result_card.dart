import 'package:flutter/material.dart';
import 'package:myapp/src/features/horoscope/ui/widgets/result_section.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HoroscopeResultCard extends StatelessWidget {
  final Map<String, dynamic> result;

  const HoroscopeResultCard({super.key, required this.result});

  void _shareHoroscope(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final String overview = result['overview'] ?? '';
    final String love = result['love'] ?? '';
    final String career = result['career'] ?? '';
    final String finance = result['finance'] ?? '';
    final String advice = result['advice'] ?? '';

    final String shareText = l10n.horoscopeResult(
      love: love,
      career: career,
      finance: finance,
      advice: advice,
      overview: overview,
    );

    Share.share(shareText);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
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
            ResultSection(title: '🌟 ${l10n.overview}', content: result['overview'] ?? '...'),
            ResultSection(title: '💖 ${l10n.love}', content: result['love'] ?? '...'),
            ResultSection(title: '💼 ${l10n.career}', content: result['career'] ?? '...'),
            ResultSection(title: '💰 ${l10n.finance}', content: result['finance'] ?? '...'),
            if (isPremiumResult)
              ResultSection(title: '⚕️ ${l10n.health}', content: result['health'] ?? '...'),
            if (isPremiumResult)
              ResultSection(title: '🔮 ${l10n.deeperAnalysis}', content: result['deeper_analysis'] ?? '...'),
            ResultSection(title: '🧘‍♂️ ${l10n.advice}', content: result['advice'] ?? '...'),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                onPressed: () => _shareHoroscope(context),
                icon: const Icon(Icons.share, size: 16),
                label: Text(l10n.shareHoroscope),
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
                  l10n.upgradeToPremium,
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
