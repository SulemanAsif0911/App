import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/localization/app_strings.dart';
import '../../core/networking/connectivity_service.dart';
import '../../core/storage/prefs.dart';
import '../../data/repositories/app_repositories.dart';
import '../../shared/theme/app_theme.dart';
import '../../shared/widgets/widgets.dart';
import '../assistant/assistant_screen.dart';
import '../guide/guide_screen.dart';
import '../evidence/evidence_screen.dart';
import '../cases/cases_screen.dart';
import 'safety_mode_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final net = context.watch<ConnectivityService>().status;
    final prefs = context.watch<AppPrefs>();
    final s = AppStrings();
    final label = switch (net) {
      NetStatus.online => 'ONLINE',
      NetStatus.syncing => 'SYNCING',
      NetStatus.offline => 'OFFLINE READY',
    };
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Row(
            children: [
              Image.asset('assets/branding/emblem.png', width: 40, height: 40, errorBuilder: (_, __, ___) => const Icon(Icons.shield_outlined, color: AppColors.accent)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(s.of(prefs.language, 'app'), style: const TextStyle(letterSpacing: 2, fontWeight: FontWeight.w700)),
                  Text(s.of(prefs.language, 'tag'), style: const TextStyle(color: AppColors.muted, fontSize: 12)),
                ]),
              ),
              StatusPill(label: label, ok: net != NetStatus.online),
            ],
          ),
          const SizedBox(height: 20),
          const Text('What should I do right now?', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          GlassCard(
            child: Text(s.of(prefs.language, 'disclaimer'), style: const TextStyle(color: AppColors.muted, height: 1.35)),
          ),
          const SizedBox(height: 16),
          _Action(Icons.health_and_safety, 'Emergency / Get Help', () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SafetyModeScreen()))),
          _Action(Icons.chat_bubble_outline, 'Talk to Assistant', () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AssistantScreen()))),
          _Action(Icons.photo_library_outlined, 'Save Evidence', () => Navigator.push(context, MaterialPageRoute(builder: (_) => const EvidenceScreen()))),
          _Action(Icons.lock_outline, 'Secure Account', () => Navigator.push(context, MaterialPageRoute(builder: (_) => const GuideScreen(initialStep: 1)))),
          _Action(Icons.report_gmailerrorred_outlined, 'Report Incident', () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CasesScreen(create: true)))),
          const SizedBox(height: 8),
          FutureBuilder(
            future: context.read<AppRepositories>().cases(),
            builder: (c, snap) {
              final n = snap.data?.length ?? 0;
              return GlassCard(child: Text('Recent cases on this device: $n  •  Status is only what you saved locally.'));
            },
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children: ['en', 'ur', 'pa', 'sd', 'ps'].map((code) {
              final sel = prefs.language == code;
              return ChoiceChip(
                label: Text(code.toUpperCase()),
                selected: sel,
                onSelected: (_) => prefs.setLanguage(code),
              );
            }).toList(),
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}

class _Action extends StatelessWidget {
  const _Action(this.icon, this.label, this.onTap);
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        onTap: onTap,
        tileColor: AppColors.card,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14), side: const BorderSide(color: AppColors.border)),
        leading: Icon(icon, color: AppColors.accent),
        title: Text(label),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}
