import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../../core/storage/prefs.dart';
import '../../data/repositories/app_repositories.dart';
import '../../shared/theme/app_theme.dart';
import 'safety_engine.dart';

class AssistantScreen extends StatefulWidget {
  const AssistantScreen({super.key});
  @override
  State<AssistantScreen> createState() => _AssistantScreenState();
}

class _AssistantScreenState extends State<AssistantScreen> {
  final ctrl = TextEditingController();
  final session = const Uuid().v4();
  final messages = <(String, String)>[];
  bool llm = false;

  @override
  void initState() {
    super.initState();
    messages.add((
      'assistant',
      'Offline Cyber Hayat Assistant. Local LLM: unavailable — using safety rules + local knowledge. I never send chats unless you explicitly export them.'
    ));
  }

  Future<void> _send() async {
    final text = ctrl.text.trim();
    if (text.isEmpty) return;
    ctrl.clear();
    setState(() => messages.add(('user', text)));
    final lang = context.read<AppPrefs>().language;
    final r = SafetyEngine.respond(text, lang: lang);
    final kb = await context.read<AppRepositories>().searchKnowledge(text.split(' ').first);
    var extra = '';
    if (kb.isNotEmpty) extra = '\n\nRelated local knowledge source: ${kb.first['title'] ?? 'bundle'}.';
    final reply = r.reply + extra;
    final repos = context.read<AppRepositories>();
    await repos.saveChat(session, 'user', text);
    await repos.saveChat(session, 'assistant', reply);
    setState(() => messages.add(('assistant', reply)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('OFFLINE ASSISTANT')),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            color: AppColors.surface,
            child: Text(llm ? 'Local LLM optional runtime not bundled' : 'Level 1 rules + Level 2 local retrieval  •  chats stay on device',
                textAlign: TextAlign.center, style: const TextStyle(fontSize: 12, color: AppColors.muted)),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: messages.length,
              itemBuilder: (_, i) {
                final m = messages[i];
                final mine = m.$1 == 'user';
                return Align(
                  alignment: mine ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(12),
                    constraints: const BoxConstraints(maxWidth: 320),
                    decoration: BoxDecoration(
                      color: mine ? AppColors.accentDim.withOpacity(0.4) : AppColors.card,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Text(m.$2),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: ctrl,
                    minLines: 1,
                    maxLines: 4,
                    decoration: const InputDecoration(hintText: 'Describe what happened…'),
                    onSubmitted: (_) => _send(),
                  ),
                ),
                IconButton(onPressed: _send, icon: const Icon(Icons.send)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Optional on-device LLM abstraction — never required.
abstract class LocalLlmRuntime {
  Future<bool> get available;
  Future<String?> complete(String prompt);
}

class UnavailableLlm implements LocalLlmRuntime {
  @override
  Future<bool> get available async => false;
  @override
  Future<String?> complete(String prompt) async => null;
}
