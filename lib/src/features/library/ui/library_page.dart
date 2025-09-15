import 'dart:convert';
import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/src/features/horoscope/services/ai_horoscope_service.dart';
import 'package:myapp/src/features/library/ui/compatibility_checker_page.dart';

import '../../../../l10n/app_localizations.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  bool _isLoadingExplanation = false;

  final List<String> _astrologyTerms = [
    'Cung Mọc (Ascendant)',
    'Cung Lặn (Descendant)',
    'Thiên Đỉnh (Midheaven)',
    'Thiên Để (Imum Coeli)',
    'Sao Thủy nghịch hành',
    'Sao Kim nghịch hành',
    'Góc hợp tam hợp (Trine)',
    'Góc hợp đối đỉnh (Opposition)',
    'Nhà 1 trong Chiêm tinh',
    'Mặt Trăng trong Sư Tử',
  ];

  Future<void> _getTermExplanation(String term) async {
    setState(() => _isLoadingExplanation = true);
    _showLoadingDialog();

    final aiService = AIHoroscopeService();
    final lang = Localizations.localeOf(context).languageCode;

    try {
      final resultJson = await aiService.getAstrologyTermExplanation(term, lang);
      final resultData = jsonDecode(resultJson);

      if (mounted) {
        Navigator.pop(context);
        _showExplanationDialog(resultData);
      }
    } catch (e, s) {
      developer.log('Failed to get explanation', name: 'LibraryPage', error: e, stackTrace: s);
      if (mounted) {
        Navigator.pop(context);
        _showErrorDialog(e.toString());
      }
    } finally {
      if (mounted) {
        setState(() => _isLoadingExplanation = false);
      }
    }
  }

  void _showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Material(
        color: Colors.transparent,
        child: Center(child: CircularProgressIndicator()),
      ),
    );
  }

  void _showErrorDialog(String error) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.errorFetching),
        content: SingleChildScrollView(child: Text(error)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancelButton),
          ),
        ],
      ),
    );
  }

  void _showExplanationDialog(Map<String, dynamic> data) {
    final title = data['title'] ?? 'N/A';
    final explanation = data['explanation'] ?? 'N/A';
    final example = data['example'] ?? 'N/A';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title, style: GoogleFonts.playfairDisplay(fontWeight: FontWeight.bold)),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(explanation, style: const TextStyle(height: 1.5)),
              const SizedBox(height: 16),
              Text('Ví dụ:', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic)),
              const SizedBox(height: 4),
              Text(example, style: const TextStyle(fontStyle: FontStyle.italic)),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Đã hiểu')),
        ],
      ),
    );
  }

  void _navigateToCompatibilityChecker() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const CompatibilityCheckerPage()));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(l10n.libraryTitle, style: GoogleFonts.playfairDisplay(fontWeight: FontWeight.bold)),
            centerTitle: true,
            floating: true,
            snap: true,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Card(
                elevation: 3,
                child: ListTile(
                  leading: const Icon(Icons.favorite_border, color: Colors.pinkAccent),
                  title: Text(l10n.compatibilityTitle, style: Theme.of(context).textTheme.titleMedium),
                  subtitle: Text(l10n.compatibilitySubtitle),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: _navigateToCompatibilityChecker,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
              child: Text(
                l10n.librarySubtitle,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final term = _astrologyTerms[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  child: ListTile(
                    title: Text(term),
                    trailing: _isLoadingExplanation
                        ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                        : const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: _isLoadingExplanation ? null : () => _getTermExplanation(term),
                  ),
                );
              },
              childCount: _astrologyTerms.length,
            ),
          ),
        ],
      ),
    );
  }
}
