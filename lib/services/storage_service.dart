import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static final StorageService _instance = StorageService._internal();
  factory StorageService() => _instance;
  StorageService._internal();

  late final SharedPreferences _prefs;
  bool _initialized = false;

  Future<void> init() async {
    if (!_initialized) {
      _prefs = await SharedPreferences.getInstance();
      _initialized = true;
    }
  }

  // Métodos para tema
  Future<void> saveThemeMode(String mode) async {
    await _ensureInitialized();
    await _prefs.setString('theme_mode', mode);
  }

  Future<String?> getThemeMode() async {
    await _ensureInitialized();
    return _prefs.getString('theme_mode');
  }

  // Métodos para usuário
  Future<void> saveUser(Map<String, dynamic> user) async {
    await _ensureInitialized();
    await _prefs.setString('user', jsonEncode(user));
  }

  Future<Map<String, dynamic>?> getUser() async {
    await _ensureInitialized();
    final userStr = _prefs.getString('user');
    if (userStr != null) {
      return jsonDecode(userStr) as Map<String, dynamic>;
    }
    return null;
  }

  Future<void> removeUser() async {
    await _ensureInitialized();
    await _prefs.remove('user');
  }

  // Métodos para pontos
  Future<void> savePoints(int points) async {
    await _ensureInitialized();
    await _prefs.setInt('points', points);
  }

  Future<int> getPoints() async {
    await _ensureInitialized();
    return _prefs.getInt('points') ?? 0;
  }

  // Métodos para favoritos
  Future<void> saveFavorites(List<String> lessonIds) async {
    await _ensureInitialized();
    await _prefs.setStringList('favorites', lessonIds);
  }

  Future<List<String>> getFavorites() async {
    await _ensureInitialized();
    return _prefs.getStringList('favorites') ?? [];
  }

  Future<void> addFavorite(String lessonId) async {
    await _ensureInitialized();
    final favorites = await getFavorites();
    if (!favorites.contains(lessonId)) {
      favorites.add(lessonId);
      await saveFavorites(favorites);
    }
  }

  Future<void> removeFavorite(String lessonId) async {
    await _ensureInitialized();
    final favorites = await getFavorites();
    favorites.remove(lessonId);
    await saveFavorites(favorites);
  }

  // Métodos para progresso das aulas
  Future<void> saveLessonProgress(String lessonId, Duration position) async {
    await _ensureInitialized();
    final progress = await getLessonProgress();
    progress[lessonId] = position.inSeconds;
    await _prefs.setString('lesson_progress', jsonEncode(progress));
  }

  Future<Map<String, int>> getLessonProgress() async {
    await _ensureInitialized();
    final progressStr = _prefs.getString('lesson_progress');
    if (progressStr != null) {
      final Map<String, dynamic> decoded = jsonDecode(progressStr);
      return decoded.map((key, value) => MapEntry(key, value as int));
    }
    return {};
  }

  // Métodos para comentários curtidos
  Future<void> saveLikedComments(List<String> commentIds) async {
    await _ensureInitialized();
    await _prefs.setStringList('liked_comments', commentIds);
  }

  Future<List<String>> getLikedComments() async {
    await _ensureInitialized();
    return _prefs.getStringList('liked_comments') ?? [];
  }

  Future<void> addLikedComment(String commentId) async {
    await _ensureInitialized();
    final likedComments = await getLikedComments();
    if (!likedComments.contains(commentId)) {
      likedComments.add(commentId);
      await saveLikedComments(likedComments);
    }
  }

  Future<void> removeLikedComment(String commentId) async {
    await _ensureInitialized();
    final likedComments = await getLikedComments();
    likedComments.remove(commentId);
    await saveLikedComments(likedComments);
  }

  // Métodos para downloads
  Future<void> saveDownloadedLessons(List<String> lessonIds) async {
    await _ensureInitialized();
    await _prefs.setStringList('downloaded_lessons', lessonIds);
  }

  Future<List<String>> getDownloadedLessons() async {
    await _ensureInitialized();
    return _prefs.getStringList('downloaded_lessons') ?? [];
  }

  Future<void> addDownloadedLesson(String lessonId) async {
    await _ensureInitialized();
    final downloadedLessons = await getDownloadedLessons();
    if (!downloadedLessons.contains(lessonId)) {
      downloadedLessons.add(lessonId);
      await saveDownloadedLessons(downloadedLessons);
    }
  }

  Future<void> removeDownloadedLesson(String lessonId) async {
    await _ensureInitialized();
    final downloadedLessons = await getDownloadedLessons();
    downloadedLessons.remove(lessonId);
    await saveDownloadedLessons(downloadedLessons);
  }

  // Método auxiliar
  Future<void> _ensureInitialized() async {
    if (!_initialized) {
      await init();
    }
  }

  // Limpeza
  Future<void> clearAll() async {
    await _ensureInitialized();
    await _prefs.clear();
  }
} 