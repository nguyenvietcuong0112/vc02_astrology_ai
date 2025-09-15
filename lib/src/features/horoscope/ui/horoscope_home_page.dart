import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myapp/src/features/horoscope/services/ai_horoscope_service.dart';
import 'package:myapp/src/features/horoscope/ui/horoscope_result_card.dart';
import 'package:myapp/src/features/horoscope/ui/widgets/input_field.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    if (_dateController.text.isEmpty ||
        _timeController.text.isEmpty ||
        _placeController.text.isEmpty) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Vui lòng nhập đầy đủ thông tin ngày sinh."),
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
            content: Text(decodedResult['error'] ?? 'Đã xảy ra lỗi không xác định.'),
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
        const SnackBar(
          content: Text("Đã xảy ra lỗi. Vui lòng thử lại."),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Trợ lý Chiêm tinh AI',
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
                "Khám phá con đường vũ trụ của bạn",
                textAlign: TextAlign.center,
                style: GoogleFonts.playfairDisplay(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Nhập thông tin ngày sinh của bạn để có được lá số tử vi được cá nhân hóa.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
              const SizedBox(height: 40),
              InputField(
                  controller: _dateController, label: "Ngày sinh", hint: "DD/MM/YYYY"),
              const SizedBox(height: 20),
              InputField(
                  controller: _timeController, label: "Giờ sinh", hint: "HH:MM"),
              const SizedBox(height: 20),
              InputField(
                  controller: _placeController, label: "Nơi sinh", hint: "Thành phố, Quốc gia"),
              const SizedBox(height: 40),
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                      children: [
                        ElevatedButton(
                          onPressed: () => _getHoroscope(isPremium: false),
                          child: const Text("Xem lá số tử vi"),
                        ),
                        const SizedBox(height: 15),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber[700],
                            foregroundColor: Colors.black,
                          ),
                          onPressed: () => _getHoroscope(isPremium: true),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.star, size: 16),
                              SizedBox(width: 8),
                              Text("Xem lá số tử vi cao cấp"),
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
