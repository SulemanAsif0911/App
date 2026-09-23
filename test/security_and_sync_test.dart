import 'package:cyber_hayat_pk/core/security/crypto_service.dart';
import 'package:cyber_hayat_pk/core/security/log_guard.dart';
import 'package:cyber_hayat_pk/core/sync/content_update.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('AES roundtrip', () {
    final c = CryptoService('unit-test-secret');
    final packed = c.encryptUtf8('evidence-note');
    expect(c.decryptUtf8(packed), 'evidence-note');
    expect(packed.contains('evidence-note'), isFalse);
  });

  test('logs never keep passwords', () {
    expect(LogGuard.isSafe('guide_opened'), isTrue);
    expect(LogGuard.isSafe('user password=secret'), isFalse);
    expect(LogGuard.sanitize('token abc'), '[redacted-log]');
  });

  test('invalid remote content does not replace bundled', () {
    const g = ContentUpdateGuard();
    expect(
      g.selectBundle(
        bundledVersion: '2026.09.01',
        cachedVersion: null,
        cachedValidSignature: false,
        remoteVersion: '2026.10.01',
        remoteValidSignature: false,
      ),
      'bundled',
    );
    expect(
      g.selectBundle(
        bundledVersion: '2026.09.01',
        cachedVersion: '2026.09.15',
        cachedValidSignature: true,
        remoteVersion: '2026.08.01',
        remoteValidSignature: true,
      ),
      'cached',
    );
  });
}
