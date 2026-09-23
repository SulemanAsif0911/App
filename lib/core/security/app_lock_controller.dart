import 'package:flutter/foundation.dart';
import '../storage/prefs.dart';
import 'hash_service.dart';

class AppLockController extends ChangeNotifier {
  AppLockController(this.prefs) {
    locked = prefs.pinEnabled;
  }
  final AppPrefs prefs;
  bool locked = false;

  bool get requiresUnlock => prefs.pinEnabled && locked;

  bool unlock(String pin) {
    final h = HashService.sha256String('chpk|$pin');
    if (h == prefs.pinHash) {
      locked = false;
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> enablePin(String pin) async {
    await prefs.setPin(HashService.sha256String('chpk|$pin'));
    locked = false;
    notifyListeners();
  }

  Future<void> disablePin() async {
    await prefs.setPin(null);
    locked = false;
    notifyListeners();
  }

  void lockNow() {
    if (prefs.pinEnabled) {
      locked = true;
      notifyListeners();
    }
  }
}
