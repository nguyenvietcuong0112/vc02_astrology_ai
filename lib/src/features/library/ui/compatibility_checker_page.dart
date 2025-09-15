import 'dart:convert';
import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/src/features/horoscope/services/ai_horoscope_service.dart';

import '../../../../l10n/app_localizations.dart';

class CompatibilityCheckerPage extends StatefulWidget {
  const CompatibilityCheckerPage({super.key});

  @override
  State<CompatibilityCheckerPage> createState() => _CompatibilityCheckerPageState();
}

class _CompatibilityCheckerPageState extends State<CompatibilityCheckerPage> {
  // List of the 12 Zodiac Signs - kept in Vietnamese as the AI prompt expects them this way for now.
  final List<String> _zodiacSigns = [
    'Bạch Dương', 'Kim Ngưu', 'Song Tử', 'Cự Giải', 'Sư Tử', 'Xử Nữ',
    'Thiên Bình', 'Bọ Cạp', 'Nhân Mã', 'Ma Kết', 'Bảo Bình', 'Song Ngư'
  ];

  String? _selectedSign1;
  String? _selectedSign2;
  bool _isLoading = false;
  Map<String, dynamic>? _compatibilityResult;

  final _aiService = AIHoroscopeService();

  @override
  void initState() {
    super.initState();
    _selectedSign1 = _zodiacSigns.first;
    _selectedSign2 = _zodiacSigns[1];
  }

  Future<void> _getCompatibility() async {
    if (_selectedSign1 == null || _selectedSign2 == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.errorMissingInput)), // Using localized string
      );
      return;
    }

    setState(() {
      _isLoading = true;
      _compatibilityResult = null;
    });

    final lang = Localizations.localeOf(context).languageCode;

    try {
      final resultJson = await _aiService.getZodiacCompatibility(_selectedSign1!, _selectedSign2!, lang);
      setState(() {
        _compatibilityResult = jsonDecode(resultJson);
      });
    } catch (e, s) {
      developer.log('Failed to get compatibility', name: 'CompatibilityChecker', error: e, stackTrace: s);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${AppLocalizations.of(context)!.errorFetching} ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.compatibilityTitle),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildZodiacSelectors(),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _isLoading ? null : _getCompatibility,
              child: _isLoading
                  ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 3))
                  : Text(l10n.checkButton),
            ),
            const SizedBox(height: 30),
            if (_compatibilityResult != null)
              _buildResultDisplay(_compatibilityResult!, l10n),
          ],
        ),
      ),
    );
  }

  Widget _buildZodiacSelectors() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildZodiacDropdown(_selectedSign1, (newValue) {
          setState(() => _selectedSign1 = newValue);
        }),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Icon(Icons.favorite, color: Colors.pink, size: 30),
        ),
        _buildZodiacDropdown(_selectedSign2, (newValue) {
          setState(() => _selectedSign2 = newValue);
        }),
      ],
    );
  }

  Widget _buildZodiacDropdown(String? selectedValue, ValueChanged<String?> onChanged) {
    return DropdownButton<String>(
      value: selectedValue,
      onChanged: onChanged,
      items: _zodiacSigns.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value, style: Theme.of(context).textTheme.titleMedium),
        );
      }).toList(),
    );
  }

  Widget _buildResultDisplay(Map<String, dynamic> result, AppLocalizations l10n) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              result['title'] ?? l10n.resultsTitle,
              style: GoogleFonts.playfairDisplay(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              '${result['score'] ?? '??'}/10',
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
            ),
            const SizedBox(height: 16),
            _buildSection(context, l10n.summaryLabel, result['summary'] ?? 'N/A'),
            const SizedBox(height: 16),
            _buildSection(context, l10n.adviceLabel, result['advice'] ?? 'N/A'),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(content, style: const TextStyle(height: 1.5)),
      ],
    );
  }
}
