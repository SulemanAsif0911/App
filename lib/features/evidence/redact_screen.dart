import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import '../../shared/theme/app_theme.dart';

class RedactScreen extends StatefulWidget {
  const RedactScreen({super.key});
  @override
  State<RedactScreen> createState() => _RedactScreenState();
}

class _RedactScreenState extends State<RedactScreen> {
  Uint8List? copy;
  String note = 'Pick an image to create a redacted COPY. The original is never modified.';

  Future<void> _pick() async {
    final x = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (x == null) return;
    final bytes = await x.readAsBytes();
    final decoded = img.decodeImage(bytes);
    if (decoded == null) return;
    img.fillRect(decoded, x1: 8, y1: 8, x2: decoded.width ~/ 3, y2: 40, color: img.ColorRgb8(0, 0, 0));
    final out = Uint8List.fromList(img.encodeJpg(decoded));
    setState(() {
      copy = out;
      note = 'Black-box applied to a copy only. Export this copy if needed. Original file untouched.';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('REDACTION COPY')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(note, style: const TextStyle(color: AppColors.muted)),
          const SizedBox(height: 12),
          if (copy != null) Image.memory(copy!),
          FilledButton(onPressed: _pick, child: const Text('Create redacted copy')),
        ],
      ),
    );
  }
}
