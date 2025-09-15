import 'package:flutter/material.dart';
import 'package:myapp/src/app/main_screen.dart';
import 'package:myapp/src/core/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:myapp/main.dart';
import 'package:myapp/l10n/app_localizations.dart';


class AstrologyApp extends StatelessWidget {
  const AstrologyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeProvider, LanguageProvider>(
      builder: (context, themeProvider, languageProvider, child) {
        return MaterialApp(
          title: 'Astrology AI Assistant',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeProvider.themeMode,
          locale: languageProvider.locale,
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          home: const MainScreen(),
        );
      },
    );
  }
}
