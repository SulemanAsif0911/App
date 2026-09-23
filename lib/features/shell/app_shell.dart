import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/storage/prefs.dart';
import '../../core/localization/app_strings.dart';
import '../home/home_screen.dart';
import '../guide/guide_screen.dart';
import '../assistant/assistant_screen.dart';
import '../cases/cases_screen.dart';
import '../settings/more_screen.dart';
import '../home/safety_mode_screen.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});
  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int index = 0;
  final s = AppStrings();

  @override
  Widget build(BuildContext context) {
    final lang = context.watch<AppPrefs>().language;
    final pages = [
      const HomeScreen(),
      const GuideScreen(),
      const AssistantScreen(),
      const CasesScreen(),
      const MoreScreen(),
    ];
    return Scaffold(
      body: pages[index],
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SafetyModeScreen())),
        label: const Text('Safety Mode'),
        icon: const Icon(Icons.health_and_safety_outlined),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (i) => setState(() => index = i),
        destinations: [
          NavigationDestination(icon: const Icon(Icons.home_outlined), label: s.of(lang, 'home')),
          NavigationDestination(icon: const Icon(Icons.menu_book_outlined), label: s.of(lang, 'guide')),
          NavigationDestination(icon: const Icon(Icons.chat_bubble_outline), label: s.of(lang, 'assistant')),
          NavigationDestination(icon: const Icon(Icons.folder_open_outlined), label: s.of(lang, 'cases')),
          NavigationDestination(icon: const Icon(Icons.more_horiz), label: s.of(lang, 'more')),
        ],
      ),
    );
  }
}
