import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/repositories/app_repositories.dart';
import '../../shared/theme/app_theme.dart';
import '../../shared/widgets/widgets.dart';

class CasesScreen extends StatefulWidget {
  const CasesScreen({super.key, this.create = false});
  final bool create;
  @override
  State<CasesScreen> createState() => _CasesScreenState();
}

class _CasesScreenState extends State<CasesScreen> {
  List<Map<String, Object?>> items = [];

  @override
  void initState() {
    super.initState();
    _load();
    if (widget.create) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _new());
    }
  }

  Future<void> _load() async {
    final r = await context.read<AppRepositories>().cases();
    setState(() => items = r);
  }

  Future<void> _new() async {
    final type = TextEditingController(text: 'Cyber Stalking');
    final platform = TextEditingController();
    final desc = TextEditingController();
    final ok = await showDialog<bool>(
      context: context,
      builder: (c) => AlertDialog(
        title: const Text('New private case'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(controller: type, decoration: const InputDecoration(labelText: 'Incident type')),
              TextField(controller: platform, decoration: const InputDecoration(labelText: 'Platform')),
              TextField(controller: desc, decoration: const InputDecoration(labelText: 'Description'), maxLines: 4),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(c, false), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(c, true), child: const Text('Save offline')),
        ],
      ),
    );
    if (ok == true && mounted) {
      await context.read<AppRepositories>().createCase({
        'incident_type': type.text,
        'platform': platform.text,
        'description': desc.text,
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Saved Offline. Not submitted to any authority.')));
        await _load();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MY CASES'), actions: [IconButton(onPressed: _new, icon: const Icon(Icons.add))]),
      body: items.isEmpty
          ? const Center(child: Text('No local cases yet. You can create one fully offline.'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: items.length,
              itemBuilder: (_, i) {
                final c = items[i];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: GlassCard(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text('${c['incident_type']}', style: const TextStyle(fontWeight: FontWeight.w700)),
                      Text('Status: ${c['status']}  •  ${c['platform']}', style: const TextStyle(color: AppColors.muted, fontSize: 12)),
                      const SizedBox(height: 6),
                      Text('${c['description'] ?? ''}'),
                      Text('ID ${c['id']}', style: const TextStyle(fontSize: 11, color: AppColors.muted)),
                    ]),
                  ),
                );
              },
            ),
    );
  }
}
