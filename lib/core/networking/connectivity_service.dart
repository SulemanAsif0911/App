import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';

enum NetStatus { online, offline, syncing }

class ConnectivityService extends ChangeNotifier {
  NetStatus status = NetStatus.offline;
  StreamSubscription? _sub;

  void start() {
    _sub = Connectivity().onConnectivityChanged.listen((r) {
      final list = r is List ? r : [r];
      final has = list.any((e) => e != ConnectivityResult.none);
      status = has ? NetStatus.online : NetStatus.offline;
      notifyListeners();
    });
    Connectivity().checkConnectivity().then((r) {
      final list = r is List ? r : [r];
      final has = list.any((e) => e != ConnectivityResult.none);
      status = has ? NetStatus.online : NetStatus.offline;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }
}
