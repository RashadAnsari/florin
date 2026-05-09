import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DbLocationService {
  static const _dbPathKey = 'db_path';
  static const _dbFileName = 'florin.db';

  final SharedPreferences _prefs;

  DbLocationService(this._prefs);

  String? get currentPath => _prefs.getString(_dbPathKey);

  bool get hasPath => currentPath != null;

  /// Returns (and persists) the default path inside the app support directory.
  /// Always accessible on macOS sandbox — no file-picker permission needed.
  Future<String> defaultPath() async {
    final dir = await getApplicationSupportDirectory();
    return p.join(dir.path, _dbFileName);
  }

  /// Ensures a path is stored. If none, sets the app-support default.
  Future<String> ensurePath() async {
    if (currentPath != null) return currentPath!;
    final path = await defaultPath();
    await _prefs.setString(_dbPathKey, path);
    return path;
  }

  Future<String?> pickAndSetLocation() async {
    final dir = await FilePicker.platform.getDirectoryPath(
      dialogTitle: 'Choose folder to store Florin database',
    );
    if (dir == null) return null;
    final path = p.join(dir, _dbFileName);
    await _prefs.setString(_dbPathKey, path);
    return path;
  }

  Future<String?> moveDatabase(String newDir) async {
    final oldPath = currentPath;
    if (oldPath == null) return null;
    final newPath = p.join(newDir, _dbFileName);
    final oldFile = File(oldPath);
    if (await oldFile.exists()) {
      await oldFile.copy(newPath);
      await oldFile.delete();
    }
    await _prefs.setString(_dbPathKey, newPath);
    return newPath;
  }
}
