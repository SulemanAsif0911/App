import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../data/repositories/app_repositories.dart';
import '../../shared/theme/app_theme.dart';
import '../../shared/widgets/widgets.dart';

class HelplinesScreen extends StatelessWidget {
  const HelplinesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('HELPLINES')),
      body: FutureBuilder(
        future: context.read<AppRepositories>().helplines(),
        builder: (c, snap) {
          final items = snap.data ?? [];
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const GlassCard(child: Text('Numbers are versioned bundled data. Verify before relying on them in an emergency. Tapping Call opens the Android dialer — the app does not place or confirm the call.')),
              const SizedBox(height: 12),
              for (final h in items)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: GlassCard(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text('${h['organization']}', style: const TextStyle(fontWeight: FontWeight.w700)),
                      Text('${h['category']}  •  ${h['jurisdiction']}', style: const TextStyle(color: AppColors.muted, fontSize: 12)),
                      Text('Phone: ${h['phone']}'),
                      Text('Last verified: ${h['last_verified']}  Source: ${h['source']}', style: const TextStyle(fontSize: 11, color: AppColors.muted)),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () async {
                            final uri = Uri(scheme: 'tel', path: '${h['phone']}'.replaceAll(' ', ''));
                            await launchUrl(uri);
                            if (c.mounted) {
                              ScaffoldMessenger.of(c).showSnackBar(const SnackBar(content: Text('Dialer opened. Call success is unknown.')));
                            }
                          },
                          child: const Text('Call'),
                        ),
                      ),
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
