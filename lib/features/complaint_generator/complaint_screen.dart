import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';
import '../assistant/safety_engine.dart';
import '../../shared/widgets/widgets.dart';

class ComplaintScreen extends StatefulWidget {
  const ComplaintScreen({super.key});
  @override
  State<ComplaintScreen> createState() => _ComplaintScreenState();
}

class _ComplaintScreenState extends State<ComplaintScreen> {
  final name = TextEditingController();
  final city = TextEditingController();
  final type = TextEditingController(text: 'Cyber harassment');
  final platform = TextEditingController();
  final account = TextEditingController();
  final date = TextEditingController();
  final summary = TextEditingController();
  String? draft;

  void _gen() {
    setState(() {
      draft = ComplaintGenerator.build(
        name: name.text,
        city: city.text,
        incidentType: type.text,
        platform: platform.text,
        account: account.text,
        date: date.text,
        summary: summary.text,
        evidence: const ['See Evidence Vault hashes on device'],
      );
    });
  }

  Future<void> _share({required bool pdf}) async {
    if (draft == null) return;
    final dir = await getTemporaryDirectory();
    if (pdf) {
      final doc = pw.Document();
      doc.addPage(pw.Page(build: (_) => pw.Text(draft!)));
      final f = File('${dir.path}/complaint_draft.pdf');
      await f.writeAsBytes(await doc.save());
      await Share.shareXFiles([XFile(f.path)], text: 'Draft only — not submitted');
    } else {
      final f = File('${dir.path}/complaint_draft.txt');
      await f.writeAsString(draft!);
      await Share.shareXFiles([XFile(f.path)], text: 'Draft only — not submitted');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('COMPLAINT DRAFT')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('Review before sharing. Generation is offline. Nothing is submitted.'),
          TextField(controller: name, decoration: const InputDecoration(labelText: 'Name')),
          TextField(controller: city, decoration: const InputDecoration(labelText: 'City')),
          TextField(controller: type, decoration: const InputDecoration(labelText: 'Incident type')),
          TextField(controller: platform, decoration: const InputDecoration(labelText: 'Platform')),
          TextField(controller: account, decoration: const InputDecoration(labelText: 'Account / number')),
          TextField(controller: date, decoration: const InputDecoration(labelText: 'Date')),
          TextField(controller: summary, decoration: const InputDecoration(labelText: 'Summary'), maxLines: 4),
          const SizedBox(height: 12),
          PrimaryButton(label: 'Generate draft', onTap: _gen),
          if (draft != null) ...[
            const SizedBox(height: 12),
            SelectableText(draft!),
            Row(children: [
              TextButton(onPressed: () => _share(pdf: false), child: const Text('Share TXT')),
              TextButton(onPressed: () => _share(pdf: true), child: const Text('Share PDF')),
            ]),
          ],
        ],
      ),
    );
  }
}
