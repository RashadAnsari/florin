import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../db/database.dart';
import 'receipt_store.dart';

/// Where the database file lives.
abstract final class DbLocationService {
  static const fileName = 'florin.db';

  static Future<String> defaultPath() async =>
      p.join((await getApplicationSupportDirectory()).path, fileName);

  static String pathIn(String directory) => p.join(directory, fileName);

  /// Copies the open database and its receipts folder to [directory] and
  /// returns the new database path. Refuses to overwrite an existing
  /// database or receipts folder there, and removes the copied database
  /// again when the receipts cannot follow, so nothing is half moved.
  static Future<String> copyTo(
    AppDatabase db,
    String directory,
    ReceiptStore receipts,
  ) async {
    final target = pathIn(directory);
    if (File(target).existsSync()) {
      throw FileSystemException('A database already exists here', target);
    }
    await db.customStatement('VACUUM INTO ?', [target]);
    try {
      await receipts.copyTo(directory);
    } catch (_) {
      await File(target).delete();
      rethrow;
    }
    return target;
  }
}
