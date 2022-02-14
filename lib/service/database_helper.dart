///
/// @date: 2022/2/14 16:18
/// @author: kevin
/// @description: dart
///
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._interval();

  factory DatabaseHelper() => _instance;

  // late

  DatabaseHelper._interval() {}

  late Database db;

  /// 初始化
  initial() async {
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;

    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;

    print(tempPath);
    print(appDocPath);

    sqfliteFfiInit();
    var databaseFactory = databaseFactoryFfi;
    var path = join(tempPath, "fd_price.db");
    print(path);
    var exists = await databaseFactory.databaseExists(path);
    if (!exists) {
      // Should happen only the first time you launch your application
      print("Creating new copy from asset");
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}
      // Copy from asset
      ByteData data = await rootBundle.load('assets/fd_price.db');
      print(join('assets', 'fd_price.db'));
      // ByteData data = await rootBundle.load(join('assets','express.db'));
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);
    } else {
      print("Opening existing database");
    }
    // open the database
    this.db = await databaseFactory.openDatabase(path);
    print(path);
  }
}
