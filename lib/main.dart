
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myapp/src/core/router/app_router.dart';
import 'package:myapp/src/core/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

// --- Language Provider ---
class LanguageProvider with ChangeNotifier {
  Locale _locale = const Locale('vi');
  Locale get locale => _locale;

  void setLocale(Locale locale) {
    if (!AppLocalizations.supportedLocales.contains(locale)) return;
    _locale = locale;
    notifyListeners();
  }
}


// --- Handlers ---

// Must be a top-level function (not a class method)
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  print('Handling a background message: ${message.messageId}');
  print('Message data: ${message.data}');
  print('Message notification: ${message.notification?.title}');
}

// Handles notification taps when the app is opened from a terminated state
void _handleMessageTerminated(RemoteMessage? message) {
  if (message == null) return;

  print('App opened from terminated state by a notification!');
  print('Message data: ${message.data}');
  // Here you could navigate to a specific page based on the message data
}


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // --- Authentication ---
  await FirebaseAuth.instance.signInAnonymously();

  // --- Messaging Setup ---
  final fcm = FirebaseMessaging.instance;

  // 1. Handle background messages
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // 2. Handle terminated state messages
  final initialMessage = await fcm.getInitialMessage();
  _handleMessageTerminated(initialMessage);

  // 3. Handle foreground messages
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });

  // 4. Handle notification taps when app is in background
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('App opened from background by a notification!');
    print('Message data: ${message.data}');
    // Here you could navigate to a specific page
  });

  // --- Permissions ---
  await fcm.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  await fcm.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  // --- Topic Subscription ---
  const topic = 'daily_horoscope';
  await fcm.subscribeToTopic(topic);
  print('Subscribed to topic: $topic');


  // --- FCM Token (Optional for topic-based sending) ---
  final fcmToken = await fcm.getToken();
  print('FCM Token: $fcmToken');


  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => LanguageProvider()),
      ],
      child: const AstrologyApp(),
    ),
  );
}

class AstrologyApp extends StatelessWidget {
  const AstrologyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final languageProvider = Provider.of<LanguageProvider>(context);

    return MaterialApp.router(
      title: 'Chiêm Tinh AI',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.themeMode,
      locale: languageProvider.locale,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: AppRouter.router,
    );
  }
}
