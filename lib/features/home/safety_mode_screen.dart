import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/security/app_lock_controller.dart';
import '../../shared/theme/app_theme.dart';
import '../../shared/widgets/widgets.dart';
import '../assistant/assistant_screen.dart';
import '../evidence/evidence_screen.dart';
import '../helplines/helplines_screen.dart';

class SafetyModeScreen extends StatelessWidget {
  const SafetyModeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SAFETY MODE')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: const [
          Text('Immediate safety', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
          SizedBox(height: 8),
          GlassCard(child: Text('If you are in physical danger, go to a safer place or a trusted nearby person. This app cannot dispatch emergency services.')),
          SizedBox(height: 12),
          GlassCard(child: Text('Do not send more money or intimate content. Do not delete conversations before you copy them.')),
          SizedBox(height: 12),
          Text('Available offline', style: TextStyle(color: AppColors.muted)),
          SizedBox(height: 8),
          Text('• Safety instructions\n• Cached helpline numbers (dialer still needs a signal)\n• Evidence preservation\n• Offline assistant\n• Local case notes'),
          SizedBox(height: 12),
          Text('Needs connectivity', style: TextStyle(color: AppColors.muted)),
          SizedBox(height: 8),
          Text('• Actual phone calls\n• Official portals\n• Sync / support submission\n• Live case status from any agency'),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            PrimaryButton(label: 'Offline assistant', icon: Icons.chat, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AssistantScreen()))),
            const SizedBox(height: 8),
            PrimaryButton(label: 'Quick evidence capture', icon: Icons.camera_alt_outlined, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const EvidenceScreen()))),
            const SizedBox(height: 8),
            PrimaryButton(label: 'Cached helplines', icon: Icons.phone_outlined, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const HelplinesScreen()))),
            const SizedBox(height: 8),
            OutlinedButton(
              onPressed: () {
                context.read<AppLockController>().lockNow();
                Navigator.pop(context);
              },
              child: const Text('Exit / lock'),
            ),
          ],
        ),
      ),
    );
  }
}
