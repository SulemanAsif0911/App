import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPrefs extends ChangeNotifier {
  AppPrefs(this._p);
  final SharedPreferences _p;

  static Future<AppPrefs> init() async {
    final p = await SharedPreferences.getInstance();
    return AppPrefs(p);
  }

  bool get onboardingDone => _p.getBool('onboarding') ?? false;
  Future<void> setOnboardingDone(bool v) async {
    await _p.setBool('onboarding', v);
    notifyListeners();
  }

  String get language => _p.getString('lang') ?? 'en';
  Locale get locale => Locale(language);
  Future<void> setLanguage(String code) async {
    await _p.setString('lang', code);
    notifyListeners();
  }

  double get textScale => _p.getDouble('textScale') ?? 1.0;
  Future<void> setTextScale(double v) async {
    await _p.setDouble('textScale', v);
    notifyListeners();
  }

  bool get highContrast => _p.getBool('hc') ?? false;
  Future<void> setHighContrast(bool v) async {
    await _p.setBool('hc', v);
    notifyListeners();
  }

  bool get reducedMotion => _p.getBool('rm') ?? false;
  Future<void> setReducedMotion(bool v) async {
    await _p.setBool('rm', v);
    notifyListeners();
  }

  bool get pinEnabled => _p.getBool('pinOn') ?? false;
  String? get pinHash => _p.getString('pinHash');
  Future<void> setPin(String? hash) async {
    if (hash == null) {
      await _p.remove('pinHash');
      await _p.setBool('pinOn', false);
    } else {
      await _p.setString('pinHash', hash);
      await _p.setBool('pinOn', true);
    }
    notifyListeners();
  }

  bool get anonymous => _p.getBool('anon') ?? true;
  Future<void> setAnonymous(bool v) async {
    await _p.setBool('anon', v);
    notifyListeners();
  }
}
