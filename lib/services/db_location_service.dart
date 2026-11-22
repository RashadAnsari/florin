import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../db/database.dart';

/// Where the database file lives.
abstract final class DbLocationService {
  static const fileName = 'florin.db';

  static Future<String> defaultPath() async =>
      p.join((await getApplicationSupportDirectory()).path, fileName);

  static String pathIn(String directory) => p.join(directory, fileName);

  /// Copies the open database to [directory] and returns the new path.
  /// Refuses to overwrite an existing database there.
  static Future<String> copyTo(AppDatabase db, String directory) async {
    final target = pathIn(directory);
    if (File(target).existsSync()) {
      throw FileSystemException('A database already exists here', target);
    }
    await db.customStatement('VACUUM INTO ?', [target]);
    return target;
  }
}
