import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../shared/theme/app_theme.dart';
import '../../shared/widgets/widgets.dart';

class GuideScreen extends StatefulWidget {
  const GuideScreen({super.key, this.initialStep = 0});
  final int initialStep;
  @override
  State<GuideScreen> createState() => _GuideScreenState();
}

class _GuideScreenState extends State<GuideScreen> {
  Map<String, dynamic>? data;
  late int step;

  @override
  void initState() {
    super.initState();
    step = widget.initialStep;
    rootBundle.loadString('assets/knowledge/guide/guide_en.json').then((raw) {
      setState(() => data = jsonDecode(raw) as Map<String, dynamic>);
    });
  }

  @override
  Widget build(BuildContext context) {
    final steps = (data?['steps'] as List?)?.cast<dynamic>() ?? [];
    return Scaffold(
      appBar: AppBar(title: const Text('GUIDE')),
      body: data == null
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Text('Version ${data!['version']}  •  ${data!['jurisdiction']}', style: const TextStyle(color: AppColors.muted, fontSize: 12)),
                const SizedBox(height: 12),
                for (var i = 0; i < steps.length; i++)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: GlassCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(steps[i]['title'], style: TextStyle(color: i == step ? AppColors.accent : AppColors.text, fontWeight: FontWeight.w700)),
                          const SizedBox(height: 8),
                          Text(steps[i]['body'], style: const TextStyle(height: 1.4, color: AppColors.muted)),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
    );
  }
}
