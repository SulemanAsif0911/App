import '../../data/database/app_database.dart';
import '../networking/api_client.dart';

class SyncEngine {
  SyncEngine(this.db, this.api);
  final AppDatabase db;
  final ApiClient api;

  Future<SyncResult> attemptSync() async {
    final ok = await api.health();
    if (!ok) {
      return SyncResult(false, 'Server unavailable. Items remain in the local queue.');
    }
    return SyncResult(false, 'Backend not configured. Queue preserved.');
  }
}

class SyncResult {
  SyncResult(this.synced, this.message);
  final bool synced;
  final String message;
}

class ConflictResolver {
  static String resolve({
    required int localVersion,
    required int remoteVersion,
    required bool isEvidence,
  }) {
    if (isEvidence && localVersion == remoteVersion) return 'keep_local';
    if (remoteVersion > localVersion) return 'keep_remote';
    return 'keep_local';
  }
}
