import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/security/app_lock_controller.dart';
import '../../core/storage/prefs.dart';
import '../../core/sync/sync_engine.dart';
import '../../core/networking/api_client.dart';
import '../../data/repositories/app_repositories.dart';
import '../resources/resources_screen.dart';
import '../helplines/helplines_screen.dart';
import '../evidence/evidence_screen.dart';
import '../legal/legal_screen.dart';
import '../security_audit/audit_screen.dart';
import '../complaint_generator/complaint_screen.dart';
import '../stories/stories_screen.dart';
import 'pin_lock_screen.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final prefs = context.watch<AppPrefs>();
    return Scaffold(
      appBar: AppBar(title: const Text('MORE')),
      body: ListView(
        children: [
          _go(context, 'Resources', const ResourcesScreen()),
          _go(context, 'Helplines', const HelplinesScreen()),
          _go(context, 'Evidence Vault', const EvidenceScreen()),
          _go(context, 'Security Audit', const AuditScreen()),
          _go(context, 'Complaint Generator', const ComplaintScreen()),
          _go(context, 'Legal Rights', const LegalScreen()),
          _go(context, 'Anonymous stories (local drafts)', const StoriesScreen()),
          const Divider(),
          SwitchListTile(
            title: const Text('Anonymous mode'),
            subtitle: const Text('Core features work without an account'),
            value: prefs.anonymous,
            onChanged: prefs.setAnonymous,
          ),
          SwitchListTile(
            title: const Text('Reduced motion'),
            value: prefs.reducedMotion,
            onChanged: prefs.setReducedMotion,
          ),
          ListTile(
            title: const Text('Text size'),
            subtitle: Slider(value: prefs.textScale, min: 0.9, max: 1.4, onChanged: prefs.setTextScale),
          ),
          ListTile(
            title: Text(prefs.pinEnabled ? 'Change / disable PIN' : 'Enable app PIN'),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => PinSetupScreen(controller: context.read<AppLockController>()))),
          ),
          ListTile(
            title: const Text('Attempt sync'),
            subtitle: const Text('Will not pretend success if the server is down'),
            onTap: () async {
              final db = context.read<AppRepositories>().db;
              final r = await SyncEngine(db, ApiClient()).attemptSync();
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(r.message)));
              }
            },
          ),
          const ListTile(
            title: Text('Privacy'),
            subtitle: Text('No ads. No hidden tracking. Chats and evidence stay on device unless you export them. No production secrets in the APK.'),
          ),
        ],
      ),
    );
  }

  Widget _go(BuildContext c, String t, Widget w) => ListTile(
        title: Text(t),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => Navigator.push(c, MaterialPageRoute(builder: (_) => w)),
      );
}
