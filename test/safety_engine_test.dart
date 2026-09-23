import 'package:flutter_test/flutter_test.dart';
import 'package:cyber_hayat_pk/features/assistant/safety_engine.dart';
import 'package:cyber_hayat_pk/core/security/hash_service.dart';
import 'package:cyber_hayat_pk/core/sync/sync_engine.dart';

void main() {
  test('sextortion intent', () {
    final r = SafetyEngine.respond('Someone is threatening to publish my private pictures.');
    expect(r.intent, 'sextortion');
    expect(r.reply.contains('do not send more'), isTrue);
    expect(r.reply.contains('have not contacted'), isTrue);
  });

  test('physical emergency is short and honest', () {
    final r = SafetyEngine.respond('They are here with a weapon');
    expect(r.emergency, isTrue);
    expect(r.reply.contains('cannot contact police'), isTrue);
  });

  test('never pretends to call FIA', () {
    final r = SafetyEngine.respond('Please contact FIA for me');
    expect(r.needsConnectivity, isTrue);
    expect(r.reply.toLowerCase().contains('cannot'), isTrue);
  });

  test('checklist generation', () {
    final items = ChecklistGenerator.forCategory('Sextortion');
    expect(items, contains('Save payment demand'));
    expect(items, contains('Screenshot profile'));
  });

  test('complaint draft is not a filing', () {
    final t = ComplaintGenerator.build(
      name: 'A',
      city: 'Lahore',
      incidentType: 'Doxing',
      platform: 'X',
      account: '@x',
      date: '2026-01-01',
      summary: 'Leaked address',
      evidence: ['shot1.png'],
    );
    expect(t.contains('not a filed complaint'), isTrue);
  });

  test('sha256 stable', () {
    expect(HashService.sha256String('cyber'), HashService.sha256String('cyber'));
    expect(HashService.sha256String('a') == HashService.sha256String('b'), isFalse);
  });

  test('conflict resolver never silently drops evidence', () {
    expect(ConflictResolver.resolve(localVersion: 1, remoteVersion: 1, isEvidence: true), 'keep_local');
    expect(ConflictResolver.resolve(localVersion: 1, remoteVersion: 2, isEvidence: false), 'keep_remote');
  });
}
