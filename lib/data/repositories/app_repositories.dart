import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';
import '../database/app_database.dart';

class AppRepositories {
  AppRepositories(this.db);
  final AppDatabase db;
  final _uuid = const Uuid();

  Future<void> seedIfNeeded() async {
    final count = firstInt(await db.db.rawQuery('SELECT COUNT(*) c FROM helplines'));
    if (count == 0) {
      final raw = await rootBundle.loadString('assets/knowledge/helplines/helplines_en.json');
      final map = jsonDecode(raw) as Map<String, dynamic>;
      for (final item in (map['items'] as List)) {
        final m = Map<String, dynamic>.from(item as Map);
        await db.db.insert('helplines', {
          'id': m['id'],
          'organization': m['organization'],
          'category': m['category'],
          'phone': m['phone'],
          'website': m['website'],
          'availability': m['availability'],
          'jurisdiction': m['jurisdiction'],
          'last_verified': m['last_verified'],
          'source': m['source'],
        });
      }
    }
    final kcount = firstInt(await db.db.rawQuery('SELECT COUNT(*) c FROM knowledge_chunks'));
    if (kcount == 0) {
      await _indexAsset('assets/knowledge/guide/guide_en.json', 'guide');
      await _indexAsset('assets/knowledge/faq/faq_en.json', 'faq');
      await _indexAsset('assets/knowledge/harassment/library_en.json', 'harassment');
      await _indexAsset('assets/knowledge/legal/legal_en.json', 'legal');
    }
  }

  Future<void> _indexAsset(String path, String source) async {
    final raw = await rootBundle.loadString(path);
    final id = _uuid.v4();
    await db.db.insert('knowledge_chunks', {
      'id': id,
      'source': source,
      'title': source,
      'body': raw,
    });
    try {
      await db.db.insert('knowledge_fts', {'title': source, 'body': raw});
    } catch (_) {}
  }

  Future<List<Map<String, Object?>>> helplines() => db.db.query('helplines');

  Future<List<Map<String, Object?>>> cases() =>
      db.db.query('cases', orderBy: 'updated_at DESC');

  Future<String> createCase(Map<String, dynamic> fields) async {
    final id = _uuid.v4();
    final now = DateTime.now().toIso8601String();
    await db.db.insert('cases', {
      'id': id,
      'incident_type': fields['incident_type'] ?? 'Other',
      'platform': fields['platform'] ?? '',
      'approx_date': fields['approx_date'] ?? '',
      'description': fields['description'] ?? '',
      'username': fields['username'] ?? '',
      'profile_url': fields['profile_url'] ?? '',
      'contact': fields['contact'] ?? '',
      'threat_level': fields['threat_level'] ?? 'unspecified',
      'evidence_count': fields['evidence_count'] ?? 0,
      'notes': fields['notes'] ?? '',
      'status': 'Saved Offline',
      'created_at': now,
      'updated_at': now,
      'version': 1,
      'official_ref': '',
      'org': '',
      'follow_up': '',
    });
    await db.enqueueSync('cases', id, 'create', jsonEncode({'id': id}));
    await db.audit('case_created');
    return id;
  }

  Future<void> addEvidence({
    required String filename,
    required String sha256,
    required String path,
    required String mime,
    required int size,
    String? caseId,
    String notes = '',
    String platform = '',
    String tags = '',
  }) async {
    final id = _uuid.v4();
    final now = DateTime.now().toIso8601String();
    await db.db.insert('evidence', {
      'id': id,
      'filename': filename,
      'sha256': sha256,
      'created_at': now,
      'captured_at': now,
      'platform': platform,
      'case_id': caseId,
      'mime_type': mime,
      'size': size,
      'notes': notes,
      'path': path,
      'tags': tags,
    });
    await db.enqueueSync('evidence', id, 'create', jsonEncode({'id': id, 'sha256': sha256}));
  }

  Future<List<Map<String, Object?>>> evidence() =>
      db.db.query('evidence', orderBy: 'created_at DESC');

  Future<String> saveChat(String sessionId, String role, String body) async {
    final id = _uuid.v4();
    await db.db.insert('chat_messages', {
      'id': id,
      'session_id': sessionId,
      'role': role,
      'body': body,
      'created_at': DateTime.now().toIso8601String(),
    });
    return id;
  }

  Future<List<Map<String, Object?>>> chat(String sessionId) => db.db.query(
        'chat_messages',
        where: 'session_id=?',
        whereArgs: [sessionId],
        orderBy: 'created_at ASC',
      );

  Future<List<Map<String, Object?>>> searchKnowledge(String q) async {
    try {
      return await db.db.query(
        'knowledge_fts',
        where: 'knowledge_fts MATCH ?',
        whereArgs: [q],
      );
    } catch (_) {
      return db.db.query('knowledge_chunks', limit: 8);
    }
  }

  Future<int> pendingSync() async {
    final r = await db.db.rawQuery("SELECT COUNT(*) c FROM sync_queue WHERE status='pending'");
    return firstInt(r);
  }
}

int firstInt(List<Map<String, Object?>> r) {
  if (r.isEmpty) return 0;
  final v = r.first.values.first;
  if (v is int) return v;
  if (v is num) return v.toInt();
  return int.tryParse('$v') ?? 0;
}
