import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/src/app/main_screen.dart';
import 'package:myapp/src/features/history/ui/history_page.dart';
import 'package:myapp/src/features/horoscope/ui/horoscope_home_page.dart';
import 'package:myapp/src/features/library/ui/library_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const MainScreen(); // <-- load MainScreen luôn
        },
      ),
    ],
  );
}
