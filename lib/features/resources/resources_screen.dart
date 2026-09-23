import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../shared/theme/app_theme.dart';
import '../../shared/widgets/widgets.dart';
import '../security_audit/audit_screen.dart';
import '../complaint_generator/complaint_screen.dart';
import '../assistant/safety_engine.dart';

class ResourcesScreen extends StatelessWidget {
  const ResourcesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('RESOURCES')),
      body: FutureBuilder(
        future: rootBundle.loadString('assets/knowledge/harassment/library_en.json'),
        builder: (c, snap) {
          final articles = snap.hasData ? (jsonDecode(snap.data!)['articles'] as List) : [];
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              ListTile(
                title: const Text('Security Health Check'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AuditScreen())),
              ),
              ListTile(
                title: const Text('Complaint generator'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ComplaintScreen())),
              ),
              ListTile(
                title: const Text('Evidence checklist'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ChecklistScreen())),
              ),
              const Divider(),
              const Text('Harassment library', style: TextStyle(fontWeight: FontWeight.w700)),
              for (final a in articles)
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: GlassCard(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(a['title'], style: const TextStyle(fontWeight: FontWeight.w700)),
                      Text('v${a['version']}  reviewed ${a['last_reviewed']}  •  ${a['source']}', style: const TextStyle(color: AppColors.muted, fontSize: 11)),
                      const SizedBox(height: 8),
                      Text('What it means\n${a['what_it_means']}'),
                      Text('\nWarning signs\n${a['warning_signs']}'),
                      Text('\nWhat to save\n${a['what_to_save']}'),
                      Text('\nWhat NOT to do\n${a['what_not_to_do']}'),
                      Text('\nAccount safety\n${a['account_safety']}'),
                      Text('\nReporting\n${a['reporting']}'),
                      Text('\nUrgent help\n${a['urgent']}'),
                      Text('\n${a['disclaimer']}', style: const TextStyle(color: AppColors.muted, fontSize: 12)),
                    ]),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class ChecklistScreen extends StatefulWidget {
  const ChecklistScreen({super.key});
  @override
  State<ChecklistScreen> createState() => _ChecklistScreenState();
}

class _ChecklistScreenState extends State<ChecklistScreen> {
  String cat = 'Sextortion';
  final done = <String>{};
  @override
  Widget build(BuildContext context) {
    final items = ChecklistGenerator.forCategory(cat);
    return Scaffold(
      appBar: AppBar(title: const Text('EVIDENCE CHECKLIST')),
      body: ListView(
        children: [
          DropdownButton<String>(
            value: cat,
            isExpanded: true,
            items: ['Cyber Stalking', 'Doxing', 'Sextortion', 'Impersonation', 'Hate Speech', 'Disinformation', 'Bullying', 'Extortion', 'Other']
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: (v) => setState(() {
              cat = v!;
              done.clear();
            }),
          ),
          for (final i in items)
            CheckboxListTile(
              value: done.contains(i),
              title: Text(i),
              onChanged: (v) => setState(() {
                if (v == true) {
                  done.add(i);
                } else {
                  done.remove(i);
                }
              }),
            ),
        ],
      ),
    );
  }
}
