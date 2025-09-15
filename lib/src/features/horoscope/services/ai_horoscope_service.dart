import 'dart:convert';
import 'package:firebase_ai/firebase_ai.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// A map to translate language codes to full language names for the AI prompt
const Map<String, String> _languageMap = {
  'en': 'English',
  'vi': 'Vietnamese',
};

// --- AI Persona & Gemini API Call ---

Future<String> getHoroscopeFromAI(
    {required String date,
      required String time,
      required String place,
      required String language, // The missing parameter is now added
      bool isPremium = false}) async {

  final fullLanguage = _languageMap[language] ?? 'English';

  // 1. Define the AI's persona and the request.
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


  try {
    // 2. Initialize the Gemini model (keeping the original implementation as requested)
    final googleAI = FirebaseAI.googleAI(auth: FirebaseAuth.instance);
    final model = googleAI.generativeModel(model: 'gemini-2.5-flash');

    // 3. Generate the content
    final response = await model.generateContent([Content.text(prompt)]);

    // 4. Return the raw JSON string
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
    return jsonEncode({
      "error": "Sorry, the stars are currently clouded. Could not generate your horoscope right now. Please try again later.",
      "details": e.toString()
    });
  }
}
