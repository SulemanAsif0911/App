import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/security/app_lock_controller.dart';
import 'core/storage/prefs.dart';
import 'shared/theme/app_theme.dart';
import 'features/shell/app_shell.dart';
import 'features/onboarding/onboarding_screen.dart';
import 'features/splash/splash_screen.dart';
import 'features/settings/pin_lock_screen.dart';

class CyberHayatApp extends StatelessWidget {
  const CyberHayatApp({super.key});

  @override
  Widget build(BuildContext context) {
    final prefs = context.watch<AppPrefs>();
    final lock = context.watch<AppLockController>();
    return MaterialApp(
      title: 'CYBER HAYAT PK',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      locale: prefs.locale,
      builder: (context, child) {
        const rtlLangs = {'ur', 'pa', 'sd', 'ps'};
        final rtl = rtlLangs.contains(prefs.locale.languageCode);
        return Directionality(
          textDirection: rtl ? TextDirection.rtl : TextDirection.ltr,
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaler: TextScaler.linear(prefs.textScale),
            ),
            child: child ?? const SizedBox.shrink(),
          ),
        );
      },
      home: _Root(prefs: prefs, lock: lock),
    );
  }
}

class _Root extends StatefulWidget {
  const _Root({required this.prefs, required this.lock});
  final AppPrefs prefs;
  final AppLockController lock;
  @override
  State<_Root> createState() => _RootState();
}

class _RootState extends State<_Root> {
  bool _splash = true;

  @override
  Widget build(BuildContext context) {
    if (_splash) {
      return SplashScreen(onDone: () => setState(() => _splash = false));
    }
    if (!widget.prefs.onboardingDone) {
      return OnboardingScreen(onFinished: () => widget.prefs.setOnboardingDone(true));
    }
    if (widget.lock.requiresUnlock) {
      return PinLockScreen(controller: widget.lock);
    }
    return const AppShell();
  }
}


