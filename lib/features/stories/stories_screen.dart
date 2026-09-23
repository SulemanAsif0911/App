import 'package:flutter/material.dart';
import '../../shared/widgets/widgets.dart';

class StoriesScreen extends StatefulWidget {
  const StoriesScreen({super.key});
  @override
  State<StoriesScreen> createState() => _StoriesScreenState();
}

class _StoriesScreenState extends State<StoriesScreen> {
  final drafts = <String>[];
  final c = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('LOCAL STORY DRAFTS')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const GlassCard(child: Text('Stories stay on this device. They are not published and not sent to a server in this build.')),
          TextField(controller: c, maxLines: 5, decoration: const InputDecoration(labelText: 'Anonymous draft')),
          PrimaryButton(label: 'Save locally', onTap: () {
            if (c.text.trim().isEmpty) return;
            setState(() {
              drafts.add(c.text.trim());
              c.clear();
            });
          }),
          for (final d in drafts) Padding(padding: const EdgeInsets.only(top: 8), child: GlassCard(child: Text(d))),
        ],
      ),
    );
  }
}
