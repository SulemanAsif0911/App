import 'package:flutter/material.dart';
import '../../shared/theme/app_theme.dart';

class AuditScreen extends StatefulWidget {
  const AuditScreen({super.key});
  @override
  State<AuditScreen> createState() => _AuditScreenState();
}

class _AuditScreenState extends State<AuditScreen> {
  final q = {
    'Is 2FA enabled on important accounts?': false,
    'Are passwords unique (never type them here)?': false,
    'Is recovery email secure?': false,
    'Is recovery phone current?': false,
    'Have privacy settings been reviewed?': false,
    'Have unknown sessions been checked?': false,
    'Are suspicious apps absent?': false,
    'Is device lock enabled?': false,
    'Is backup configured?': false,
    'Is a trusted contact available?': false,
  };

  @override
  Widget build(BuildContext context) {
    final score = q.values.where((e) => e).length;
    return Scaffold(
      appBar: AppBar(title: const Text('SECURITY HEALTH CHECK')),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text('Answers stay on this device. Never enter passwords. Score $score / ${q.length}',
                style: const TextStyle(color: AppColors.muted)),
          ),
          for (final e in q.entries)
            SwitchListTile(
              title: Text(e.key),
              value: e.value,
              onChanged: (v) => setState(() => q[e.key] = v),
            ),
        ],
      ),
    );
  }
}
