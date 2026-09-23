import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import '../../core/security/crypto_service.dart';
import '../../core/security/hash_service.dart';
import '../../data/repositories/app_repositories.dart';
import '../../shared/theme/app_theme.dart';
import '../../shared/widgets/widgets.dart';
import 'redact_screen.dart';

class EvidenceScreen extends StatefulWidget {
  const EvidenceScreen({super.key});
  @override
  State<EvidenceScreen> createState() => _EvidenceScreenState();
}

class _EvidenceScreenState extends State<EvidenceScreen> {
  List<Map<String, Object?>> items = [];
  final crypto = CryptoService('local-device-key-v1');

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final r = await context.read<AppRepositories>().evidence();
    setState(() => items = r);
  }

  Future<void> _capture(ImageSource src) async {
    final x = await ImagePicker().pickImage(source: src);
    if (x == null) return;
    final bytes = await x.readAsBytes();
    final hash = HashService.sha256Bytes(bytes);
    final enc = crypto.encryptBytes(bytes);
    final dir = await getApplicationDocumentsDirectory();
    final vault = Directory(p.join(dir.path, 'vault'));
    await vault.create(recursive: true);
    final name = '${DateTime.now().millisecondsSinceEpoch}.bin';
    final file = File(p.join(vault.path, name));
    await file.writeAsBytes(enc, flush: true);
    await context.read<AppRepositories>().addEvidence(
          filename: x.name,
          sha256: hash,
          path: file.path,
          mime: x.mimeType ?? 'image/jpeg',
          size: bytes.length,
        );
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Encrypted locally. SHA-256 $hash')));
      await _load();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('EVIDENCE VAULT')),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text('Originals are hashed then stored encrypted. Redacted copies are separate. Previews stay hidden until you open an item.'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (_, i) {
                final e = items[i];
                return ListTile(
                  leading: const Icon(Icons.lock_outline, color: AppColors.accent),
                  title: Text('${e['filename']}'),
                  subtitle: Text('SHA-256 ${e['sha256']}\n${e['created_at']}', maxLines: 3),
                  isThreeLine: true,
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Expanded(child: PrimaryButton(label: 'Camera', icon: Icons.camera_alt, onTap: () => _capture(ImageSource.camera))),
            const SizedBox(width: 8),
            Expanded(child: PrimaryButton(label: 'Gallery', icon: Icons.photo, onTap: () => _capture(ImageSource.gallery))),
            const SizedBox(width: 8),
            IconButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RedactScreen())), icon: const Icon(Icons.blur_on)),
          ],
        ),
      ),
    );
  }
}
