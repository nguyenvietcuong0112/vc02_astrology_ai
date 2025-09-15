import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myapp/src/features/horoscope/services/ai_horoscope_service.dart';
import 'package:myapp/src/features/horoscope/ui/horoscope_result_card.dart';
import 'package:myapp/src/features/horoscope/ui/widgets/input_field.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
          content: Text(l10n.enterCompleteBirthInfo),
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
      final resultString = await getHoroscopeFromAI(
        date: _dateController.text,
        time: _timeController.text,
        place: _placeController.text,
        isPremium: isPremium,
      );
      final decodedResult = jsonDecode(resultString);

      if (decodedResult.containsKey('error')) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(decodedResult['error'] ?? 'An unknown error occurred.'),
            backgroundColor: Colors.redAccent,
          ),
        );
        setState(() {
          _isLoading = false;
        });
        return;
      }

      await _saveBirthInfo(); // Save the info on success

      setState(() {
        _horoscopeResult = decodedResult;
        _isLoading = false;
      });
    } catch (e) {
      // This catches errors from jsonDecode or other synchronous issues
      setState(() {
        _isLoading = false;
      });
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.errorOccurred),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Astrology AI Assistant',
          style: GoogleFonts.sacramento(
            fontSize: 32,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              Text(
                l10n.discoverCosmicPath,
                textAlign: TextAlign.center,
                style: GoogleFonts.playfairDisplay(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                l10n.enterBirthDetails,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white70, fontSize: 16),
              ),
              const SizedBox(height: 40),
              InputField(
                  controller: _dateController, label: l10n.dateOfBirth, hint: l10n.dateOfBirthHint),
              const SizedBox(height: 20),
              InputField(
                  controller: _timeController, label: l10n.timeOfBirth, hint: l10n.timeOfBirthHint),
              const SizedBox(height: 20),
              InputField(
                  controller: _placeController, label: l10n.placeOfBirth, hint: l10n.placeOfBirthHint),
              const SizedBox(height: 40),
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                      children: [
                        ElevatedButton(
                          onPressed: () => _getHoroscope(isPremium: false),
                          child: Text(l10n.revealHoroscope),
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
                              Text(l10n.revealPremiumHoroscope),
                            ],
                          ),
                        ),
                      ],
                    ),
              if (_horoscopeResult != null) HoroscopeResultCard(result: _horoscopeResult!),
            ],
          ),
        ),
      ),
    );
  }
}
