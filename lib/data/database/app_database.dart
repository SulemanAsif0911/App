import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

class AppDatabase {
  AppDatabase(this.db);
  final Database db;
  static const uuid = Uuid();

  static Future<AppDatabase> open() async {
    final dir = await getApplicationDocumentsDirectory();
    final path = p.join(dir.path, 'cyber_hayat.db');
    final database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, v) async {
        await db.execute('''
CREATE TABLE cases(
  id TEXT PRIMARY KEY,
  incident_type TEXT,
  platform TEXT,
  approx_date TEXT,
  description TEXT,
  username TEXT,
  profile_url TEXT,
  contact TEXT,
  threat_level TEXT,
  evidence_count INTEGER,
  notes TEXT,
  status TEXT,
  created_at TEXT,
  updated_at TEXT,
  version INTEGER,
  official_ref TEXT,
  org TEXT,
  follow_up TEXT
)''');
        await db.execute('''
CREATE TABLE case_events(
  id TEXT PRIMARY KEY,
  case_id TEXT,
  kind TEXT,
  detail TEXT,
  created_at TEXT
)''');
        await db.execute('''
CREATE TABLE evidence(
  id TEXT PRIMARY KEY,
  filename TEXT,
  sha256 TEXT,
  created_at TEXT,
  captured_at TEXT,
  platform TEXT,
  case_id TEXT,
  mime_type TEXT,
  size INTEGER,
  notes TEXT,
  path TEXT,
  tags TEXT
)''');
        await db.execute('''
CREATE TABLE checklists(
  id TEXT PRIMARY KEY,
  category TEXT,
  created_at TEXT
)''');
        await db.execute('''
CREATE TABLE checklist_items(
  id TEXT PRIMARY KEY,
  checklist_id TEXT,
  label TEXT,
  done INTEGER
)''');
        await db.execute('''
CREATE TABLE helplines(
  id TEXT PRIMARY KEY,
  organization TEXT,
  category TEXT,
  phone TEXT,
  website TEXT,
  availability TEXT,
  jurisdiction TEXT,
  last_verified TEXT,
  source TEXT
)''');
        await db.execute('''
CREATE TABLE knowledge_chunks(
  id TEXT PRIMARY KEY,
  source TEXT,
  title TEXT,
  body TEXT
)''');
        await db.execute('''
CREATE TABLE chat_sessions(
  id TEXT PRIMARY KEY,
  created_at TEXT
)''');
        await db.execute('''
CREATE TABLE chat_messages(
  id TEXT PRIMARY KEY,
  session_id TEXT,
  role TEXT,
  body TEXT,
  created_at TEXT
)''');
        await db.execute('''
CREATE TABLE complaint_drafts(
  id TEXT PRIMARY KEY,
  payload TEXT,
  created_at TEXT
)''');
        await db.execute('''
CREATE TABLE sync_queue(
  id TEXT PRIMARY KEY,
  entity TEXT,
  entity_id TEXT,
  op TEXT,
  payload TEXT,
  created_at TEXT,
  status TEXT,
  version INTEGER
)''');
        await db.execute('''
CREATE TABLE audit_events(
  id TEXT PRIMARY KEY,
  kind TEXT,
  created_at TEXT
)''');
        await db.execute('''
CREATE TABLE settings(
  k TEXT PRIMARY KEY,
  v TEXT
)''');
        try {
          await db.execute('CREATE VIRTUAL TABLE knowledge_fts USING fts5(title, body)');
        } catch (_) {}
      },
    );
    return AppDatabase(database);
  }

  Future<void> enqueueSync(String entity, String entityId, String op, String payload) async {
    await db.insert('sync_queue', {
      'id': uuid.v4(),
      'entity': entity,
      'entity_id': entityId,
      'op': op,
      'payload': payload,
      'created_at': DateTime.now().toIso8601String(),
      'status': 'pending',
      'version': 1,
    });
  }

  Future<void> audit(String kind) async {
    await db.insert('audit_events', {
      'id': uuid.v4(),
      'kind': kind,
      'created_at': DateTime.now().toIso8601String(),
    });
  }
}
