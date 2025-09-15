import 'dart:convert';
import 'package:firebase_ai/firebase_ai.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

// A map to translate language codes to full language names for the AI prompt
const Map<String, String> _languageMap = {
  'en': 'English',
  'vi': 'Vietnamese',
};

class AIHoroscopeService {

  // Reverted to the user's specified implementation
  Future<String> _generateContent(String prompt) async {
    try {
      final googleAI = FirebaseAI.googleAI(auth: FirebaseAuth.instance);
      final model = googleAI.generativeModel(model: 'gemini-1.5-flash');

      final response = await model.generateContent([Content.text(prompt)]);
      final cleanResponse = response.text?.replaceAll('```json', '').replaceAll('```', '').trim();

      if (cleanResponse == null || cleanResponse.isEmpty) {
        throw Exception('Empty response from AI model.');
      }

      // Validate that it's valid JSON before returning
      jsonDecode(cleanResponse);
      return cleanResponse;
    } catch (e) {
      debugPrint('Error calling Gemini API: $e');
      // Provide a structured error message
      throw Exception(
          'Sorry, the stars are currently clouded. Could not generate your reading right now. Details: ${e.toString()}');
    }
  }

  Future<String> getHoroscopeFromAI(
      {required String date,
      required String time,
      required String place,
      required String language,
      bool isPremium = false}) async {
    final fullLanguage = _languageMap[language] ?? 'English';

    var prompt = '''
    YOU ARE a professional, mystical astrologer named "Celestia".
    Your background: you have studied ancient astrological texts for decades.
    Your tone: insightful, mystical, empathetic, and a bit mysterious.
    Your task: Provide a detailed horoscope for the user based on their birth information.

    **DO NOT** use Markdown in your response.
    **ONLY** reply with a valid JSON object, with no other text.
    **IMPORTANT**: The entire response, including all text values in the JSON, MUST be in $fullLanguage.

    User's birth information:
    - Date: $date
    - Time: $time
    - Place: $place

    Based on this information, create a horoscope that includes the following sections:

    1.  `overview`: An overview paragraph (around 50-70 words).
    2.  `love`: A paragraph about love and relationships (around 40-60 words).
    3.  `career`: A paragraph about career and work (around 40-60 words).
    4.  `finance`: A paragraph about finances (around 40-60 words).
    5.  `advice`: A short, actionable piece of advice (1-2 sentences).
    ''';

    if (isPremium) {
      prompt += '''
    6. `health`: A paragraph about health and wellness (around 40-60 words).
    7. `deeper_analysis`: A more in-depth analysis paragraph (around 70-90 words), synthesizing various aspects of the horoscope.

    Ensure your response is structured exactly like this JSON format (and translated to $fullLanguage):
    {
      "overview": "(your content here)",
      "love": "(your content here)",
      "career": "(your content here)",
      "finance": "(your content here)",
      "advice": "(your content here)",
      "health": "(your content here)",
      "deeper_analysis": "(your content here)"
    }
    ''';
    } else {
      prompt += '''
    Ensure your response is structured exactly like this JSON format (and translated to $fullLanguage):
    {
      "overview": "(your content here)",
      "love": "(your content here)",
      "career": "(your content here)",
      "finance": "(your content here)",
      "advice": "(your content here)"
    }
    ''';
    }

    return _generateContent(prompt);
  }

  Future<String> getAstrologyTermExplanation(String term, String language) async {
    final fullLanguage = _languageMap[language] ?? 'English';

    final prompt = '''
      YOU ARE a professional, mystical astrologer named "Celestia".
      Your background: you have studied ancient astrological texts for decades.
      Your tone: insightful, wise, and like a patient teacher explaining a complex concept to a curious student.
      Your task: Provide a clear and concise explanation for the given astrological term.

      IMPORTANT INSTRUCTIONS:
      1.  The entire response MUST be a valid JSON object.
      2.  Do NOT include any text, backticks, or formatting outside of the JSON structure.
      3.  All text values within the JSON MUST be translated into the requested language.
      4.  The explanation must be easy for a beginner to understand. Avoid overly technical jargon where possible, or explain it simply.

      User's request:
      - Term to explain: "$term"
      - Language: "$fullLanguage"

      Based on this term, create an explanation with the following structure.

      Ensure your response is structured exactly like this JSON format (and translated to the requested language):
      {
        "term": "$term",
        "title": "[A short, catchy title for the explanation]",
        "explanation": "[A detailed but easy-to-understand explanation]",
        "example": "[A simple, practical example]"
      }
      ''';

    return _generateContent(prompt);
  }

  Future<String> getZodiacCompatibility(String sign1, String sign2, String language) async {
    final fullLanguage = _languageMap[language] ?? 'English';

    final prompt = '''
      YOU ARE a professional, mystical astrologer named "Celestia".
      Your background: you have studied ancient astrological texts for decades.
      Your tone: insightful, encouraging, and balanced. You see both the strengths and challenges in any pairing.
      Your task: Provide a compatibility analysis for two Zodiac signs.

      IMPORTANT INSTRUCTIONS:
      1.  The entire response MUST be a valid JSON object.
      2.  Do NOT include any text, backticks, or formatting outside of the JSON structure.
      3.  All text values within the JSON MUST be translated into the requested language.
      4.  The `score` MUST be an integer between 1 and 10.

      User's request:
      - Zodiac Sign 1: "$sign1"
      - Zodiac Sign 2: "$sign2"
      - Language: "$fullLanguage"

      Based on this pair, create a compatibility analysis with the following structure.

      Ensure your response is structured exactly like this JSON format (and translated to the requested language):
      {
        "title": "$sign1 & $sign2",
        "score": [An integer score from 1 (least compatible) to 10 (most compatible)],
        "summary": "[A summary of the relationship dynamics, highlighting key strengths and challenges (60-80 words)]",
        "advice": "[A short, actionable piece of advice for this pairing to improve their relationship (30-50 words)]"
      }
      ''';

    return _generateContent(prompt);
  }
}
