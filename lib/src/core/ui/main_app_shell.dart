import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/l10n/app_localizations.dart';

class MainAppShell extends StatefulWidget {
  final Widget child;

  const MainAppShell({super.key, required this.child});

  @override
  State<MainAppShell> createState() => _MainAppShellState();
}

class _MainAppShellState extends State<MainAppShell> {
  int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();
    if (location.startsWith('/history')) {
      return 1;
    }
    if (location.startsWith('/library')) {
      return 2;
    }
    return 0;
  }

  void _onTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/history');
        break;
      case 2:
        context.go('/library');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _calculateSelectedIndex(context),
        onTap: (index) => _onTap(context, index),
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.wb_sunny_outlined),
            activeIcon: const Icon(Icons.wb_sunny),
            label: l10n.horoscopeTitle,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.history_outlined),
            activeIcon: const Icon(Icons.history),
            label: l10n.historyTitle,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.menu_book_outlined),
            activeIcon: const Icon(Icons.menu_book),
            label: l10n.libraryTitle,
          ),
        ],
      ),
    );
  }
}
