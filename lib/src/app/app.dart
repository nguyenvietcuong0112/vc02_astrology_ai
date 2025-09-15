import 'package:flutter/material.dart';
import 'package:myapp/src/core/theme/app_theme.dart';
import 'package:myapp/src/features/horoscope/ui/horoscope_home_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AstrologyApp extends StatelessWidget {
  const AstrologyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Astrology AI Assistant',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeProvider.themeMode,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const HoroscopeHomePage(),
        );
      },
    );
  }
}
