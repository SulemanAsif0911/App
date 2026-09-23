import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/storage/prefs.dart';
import '../../shared/theme/app_theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, required this.onDone});
  final VoidCallback onDone;
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late final AnimationController c;
  @override
  void initState() {
    super.initState();
    c = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final reduce = context.read<AppPrefs>().reducedMotion;
      if (reduce) {
        widget.onDone();
      } else {
        c.forward().whenComplete(widget.onDone);
      }
    });
  }

  @override
  void dispose() {
    c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: AnimatedBuilder(
        animation: c,
        builder: (_, __) {
          final t = c.value;
          return Stack(
            fit: StackFit.expand,
            children: [
              CustomPaint(painter: _GridPainter(t)),
              Center(
                child: Opacity(
                  opacity: t.clamp(0, 1),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset('assets/branding/emblem.png', width: 120, height: 120, errorBuilder: (_, __, ___) {
                        return const Icon(Icons.shield_outlined, size: 88, color: AppColors.accent);
                      }),
                      const SizedBox(height: 20),
                      const Text('CYBER HAYAT PK', style: TextStyle(letterSpacing: 3, fontWeight: FontWeight.w700, fontSize: 20)),
                      const SizedBox(height: 8),
                      Opacity(
                        opacity: (t - 0.4).clamp(0, 1),
                        child: const Text('Digital Safety • Support • Awareness', style: TextStyle(color: AppColors.muted, fontSize: 13)),
                      ),
                      const SizedBox(height: 16),
                      Opacity(
                        opacity: (t - 0.7).clamp(0, 1),
                        child: const Text('● OFFLINE READY', style: TextStyle(color: AppColors.ok, letterSpacing: 2, fontSize: 12)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  _GridPainter(this.t);
  final double t;
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = AppColors.accent.withOpacity(0.05 * t)
      ..strokeWidth = 1;
    const step = 28.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), p);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), p);
    }
    final sweep = Paint()
      ..shader = LinearGradient(
        colors: [Colors.transparent, AppColors.accent.withOpacity(0.25), Colors.transparent],
      ).createShader(Rect.fromLTWH(0, size.height * t - 40, size.width, 80));
    canvas.drawRect(Rect.fromLTWH(0, size.height * t - 40, size.width, 80), sweep);
  }

  @override
  bool shouldRepaint(covariant _GridPainter old) => old.t != t;
}
