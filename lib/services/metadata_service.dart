import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

class MetadataService {
  static final MetadataService _instance = MetadataService._internal();
  factory MetadataService() => _instance;
  MetadataService._internal();

  Database? _db;

  Future<void> _initDb() async {
    if (_db != null) return;

    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'downloads.db');

    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE downloads (
            lesson_id TEXT PRIMARY KEY,
            module_id TEXT NOT NULL,
            folder_id TEXT,
            subfolder_id TEXT,
            local_path TEXT NOT NULL,
            title TEXT NOT NULL,
            type TEXT NOT NULL,
            file_size INTEGER NOT NULL,
            created_at INTEGER NOT NULL
          )
        ''');
      },
    );
  }

  Future<void> saveDownloadMetadata({
    required String lessonId,
    required String moduleId,
    String? folderId,
    String? subfolderId,
    required String localPath,
    required String title,
    required String type,
    required int fileSize,
  }) async {
    await _initDb();

    await _db!.insert(
      'downloads',
      {
        'lesson_id': lessonId,
        'module_id': moduleId,
        'folder_id': folderId,
        'subfolder_id': subfolderId,
        'local_path': localPath,
        'title': title,
        'type': type,
        'file_size': fileSize,
        'created_at': DateTime.now().millisecondsSinceEpoch,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Map<String, dynamic>?> getDownloadMetadata(String lessonId) async {
    await _initDb();

    final List<Map<String, dynamic>> maps = await _db!.query(
      'downloads',
      where: 'lesson_id = ?',
      whereArgs: [lessonId],
    );

    if (maps.isEmpty) return null;
    return maps.first;
  }

  Future<List<Map<String, dynamic>>> getAllDownloads() async {
    await _initDb();

    return await _db!.query('downloads', orderBy: 'created_at DESC');
  }

  Future<void> removeDownloadMetadata(String lessonId) async {
    await _initDb();

    await _db!.delete(
      'downloads',
      where: 'lesson_id = ?',
      whereArgs: [lessonId],
    );
  }

  Future<int> getTotalDownloadsSize() async {
    await _initDb();

    final result =
        await _db!.rawQuery('SELECT SUM(file_size) as total FROM downloads');
    return result.first['total'] as int? ?? 0;
  }

  Future<int> getDownloadsCount() async {
    await _initDb();

    return Sqflite.firstIntValue(
          await _db!.rawQuery('SELECT COUNT(*) FROM downloads'),
        ) ??
        0;
  }

  Future<void> clearAll() async {
    await _initDb();
    await _db!.delete('downloads');
  }
}
