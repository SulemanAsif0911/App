import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/localization/app_strings.dart';
import '../../shared/theme/app_theme.dart';
import '../../shared/widgets/widgets.dart';

class LegalScreen extends StatelessWidget {
  const LegalScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('LEGAL RIGHTS')),
      body: FutureBuilder(
        future: rootBundle.loadString('assets/knowledge/legal/legal_en.json'),
        builder: (c, snap) {
          if (!snap.hasData) return const Center(child: CircularProgressIndicator());
          final data = jsonDecode(snap.data!) as Map<String, dynamic>;
          final docs = data['documents'] as List;
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              GlassCard(child: Text(AppStrings().of('en', 'legalDisclaimer'))),
              const SizedBox(height: 12),
              for (final d in docs)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: GlassCard(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(d['title'], style: const TextStyle(fontWeight: FontWeight.w700)),
                      Text('source: ${d['source_name']}  v${d['content_version']}  PK', style: const TextStyle(color: AppColors.muted, fontSize: 12)),
                      const SizedBox(height: 8),
                      Text(d['body']),
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
