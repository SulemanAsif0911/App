import 'package:flutter/material.dart';
import '../../core/security/app_lock_controller.dart';
import '../../shared/widgets/widgets.dart';

class PinLockScreen extends StatefulWidget {
  const PinLockScreen({super.key, required this.controller});
  final AppLockController controller;
  @override
  State<PinLockScreen> createState() => _PinLockScreenState();
}

class _PinLockScreenState extends State<PinLockScreen> {
  final c = TextEditingController();
  String? err;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Unlock Cyber Hayat PK', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
            TextField(controller: c, obscureText: true, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'PIN')),
            if (err != null) Text(err!, style: const TextStyle(color: Colors.redAccent)),
            PrimaryButton(
              label: 'Unlock',
              onTap: () {
                if (!widget.controller.unlock(c.text)) setState(() => err = 'Incorrect PIN');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class PinSetupScreen extends StatefulWidget {
  const PinSetupScreen({super.key, required this.controller});
  final AppLockController controller;
  @override
  State<PinSetupScreen> createState() => _PinSetupScreenState();
}

class _PinSetupScreenState extends State<PinSetupScreen> {
  final c = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('APP PIN')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: c, obscureText: true, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: '4+ digit PIN')),
            PrimaryButton(label: 'Save PIN', onTap: () async {
              await widget.controller.enablePin(c.text);
              if (context.mounted) Navigator.pop(context);
            }),
            TextButton(onPressed: () async {
              await widget.controller.disablePin();
              if (context.mounted) Navigator.pop(context);
            }, child: const Text('Disable PIN')),
          ],
        ),
      ),
    );
  }
}
