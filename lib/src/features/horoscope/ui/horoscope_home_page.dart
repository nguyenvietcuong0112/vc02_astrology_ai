import 'dart:convert';
import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:myapp/src/features/history/services/database_helper.dart';
import 'package:myapp/src/features/horoscope/services/ai_horoscope_service.dart';
import 'package:myapp/src/features/horoscope/ui/horoscope_result_card.dart';
import 'package:myapp/src/features/horoscope/ui/widgets/input_field.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:myapp/main.dart';

import '../../../../l10n/app_localizations.dart';

class HoroscopeHomePage extends StatefulWidget {
  const HoroscopeHomePage({super.key});

  @override
  State<HoroscopeHomePage> createState() => _HoroscopeHomePageState();
}

class _HoroscopeHomePageState extends State<HoroscopeHomePage> {
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
  final _placeController = TextEditingController();
  bool _isLoading = false;
  Map<String, dynamic>? _horoscopeResult;

  final _aiService = AIHoroscopeService(); // Instantiate the service

  @override
  void initState() {
    super.initState();
    _loadBirthInfo();
  }

  @override
  void dispose() {
    _dateController.dispose();
    _timeController.dispose();
    _placeController.dispose();
    super.dispose();
  }

  Future<void> _loadBirthInfo() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _dateController.text = prefs.getString('birth_date') ?? '';
      _timeController.text = prefs.getString('birth_time') ?? '';
      _placeController.text = prefs.getString('birth_place') ?? '';
    });
  }

  Future<void> _saveBirthInfo() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('birth_date', _dateController.text);
    await prefs.setString('birth_time', _timeController.text);
    await prefs.setString('birth_place', _placeController.text);
  }

  Future<void> _getHoroscope({bool isPremium = false}) async {
    final l10n = AppLocalizations.of(context)!;

    if (_dateController.text.isEmpty ||
        _timeController.text.isEmpty ||
        _placeController.text.isEmpty) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.errorMissingInput), // Corrected message
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
      _horoscopeResult = null;
    });

    try {
      final langCode =
          Provider.of<LanguageProvider>(context, listen: false).locale.languageCode;

      // Use the service instance to call the method
      final resultString = await _aiService.getHoroscopeFromAI(
        date: _dateController.text,
        time: _timeController.text,
        place: _placeController.text,
        isPremium: isPremium,
        language: langCode,
      );
      final decodedResult = jsonDecode(resultString);

      // Save to database
      final dbHelper = DatabaseHelper();
      await dbHelper.insertHoroscope({
        'date': _dateController.text,
        'time': _timeController.text,
        'place': _placeController.text,
        'result': resultString, // Save the original JSON string
      });
      developer.log('Successfully saved horoscope to the database.');

      await _saveBirthInfo();

      setState(() {
        _horoscopeResult = decodedResult;
        _isLoading = false;
      });
    } catch (e, s) {
      developer.log('Error getting or saving horoscope', error: e, stackTrace: s);
      setState(() {
        _isLoading = false;
      });
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.errorFetching), // Use generic error message
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      color: Colors.black,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              Text(
                l10n.homePageTitle,
                textAlign: TextAlign.center,
                style: GoogleFonts.playfairDisplay(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                l10n.homePageSubtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.color
                        ?.withOpacity(0.7),
                    fontSize: 16),
              ),
              const SizedBox(height: 40),
              InputField(
                  controller: _dateController,
                  label: l10n.dateOfBirth,
                  hint: l10n.dateOfBirthHint),
              const SizedBox(height: 20),
              InputField(
                  controller: _timeController,
                  label: l10n.timeOfBirth,
                  hint: l10n.timeOfBirthHint),
              const SizedBox(height: 20),
              InputField(
                  controller: _placeController,
                  label: l10n.placeOfBirth,
                  hint: l10n.placeOfBirthHint),
              const SizedBox(height: 40),
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                      children: [
                        ElevatedButton(
                          onPressed: () => _getHoroscope(isPremium: false),
                          child: Text(l10n.getHoroscopeButton),
                        ),
                        const SizedBox(height: 15),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber[700],
                            foregroundColor: Colors.black,
                          ),
                          onPressed: () => _getHoroscope(isPremium: true),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.star, size: 16),
                              const SizedBox(width: 8),
                              Text(l10n.getPremiumHoroscopeButton),
                            ],
                          ),
                        ),
                      ],
                    ),
              if (_horoscopeResult != null)
                HoroscopeResultCard(result: _horoscopeResult!),
            ],
          ),
        ),
      ),
    );
  }
}
