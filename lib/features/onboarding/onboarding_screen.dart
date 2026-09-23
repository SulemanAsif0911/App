import 'package:flutter/material.dart';
import '../../shared/theme/app_theme.dart';
import '../../shared/widgets/widgets.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key, required this.onFinished});
  final VoidCallback onFinished;
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int i = 0;
  final pages = const [
    ('CYBER HAYAT PK', 'Your digital safety companion.'),
    ('WORKS OFFLINE', 'Core safety guidance, resources, checklists and assistance remain available without internet.'),
    ('YOUR PRIVACY MATTERS', 'Sensitive information can remain on your device unless you choose to share it.'),
    ('READY WHEN YOU NEED IT', 'Cyber Hayat PK is ready to help you understand, preserve evidence and find the right next step.'),
  ];

  @override
  Widget build(BuildContext context) {
    final p = pages[i];
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(onPressed: widget.onFinished, child: const Text('Skip')),
              ),
              const Spacer(),
              Text(p.$1, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w700, letterSpacing: 1)),
              const SizedBox(height: 16),
              Text(p.$2, style: const TextStyle(color: AppColors.muted, fontSize: 16, height: 1.4)),
              const Spacer(),
              PrimaryButton(
                label: i == pages.length - 1 ? 'Get Started' : 'Continue',
                onTap: () {
                  if (i == pages.length - 1) {
                    widget.onFinished();
                  } else {
                    setState(() => i++);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
