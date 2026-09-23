import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';

enum NetStatus { online, offline, syncing }

class ConnectivityService extends ChangeNotifier {
  NetStatus status = NetStatus.offline;
  StreamSubscription<List<ConnectivityResult>>? _sub;

  void start() {
    _sub = Connectivity().onConnectivityChanged.listen(_apply);
    Connectivity().checkConnectivity().then(_apply);
  }

  void _apply(List<ConnectivityResult> results) {
    final has = results.any((e) => e != ConnectivityResult.none);
    status = has ? NetStatus.online : NetStatus.offline;
    notifyListeners();
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }
}
