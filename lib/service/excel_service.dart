import 'dart:io';

import 'package:excel/excel.dart';
import 'package:fd_price_manager/service/database_helper.dart';
import 'package:file_picker/file_picker.dart';

import '../util/log.dart';

///
/// @date: 2022/2/14 15:37
/// @author: kevin
/// @description: dart
///

class ExcelService {
  ///
  /// @desc 导入excel
  static void import() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      log(result.files.single.path);

      // read excel

      var file = result.files.single.path;
      var bytes = File(file!).readAsBytesSync();
      var excel = Excel.decodeBytes(bytes);
      var sql = StringBuffer();

      for (var table in excel.tables.keys) {
        log(table); //sheet Name
        log(excel.tables[table]?.maxCols);
        log(excel.tables[table]?.maxRows);
        // for (var row in excel.tables[table]?.rows ?? []) {
        //   print("$row");
        // }

        List rows = excel.tables[table]?.rows ?? [];

        for (var i = 0; i < 35; i++) {
          if (i > 0) {
            var item = rows[i];
            log(item);
            var lastSeparator = i == 34 ? ";" : ",";
            sql
              ..write("(")
              ..write("\"${item[1].value}\",")
              ..write("\"${item[2].value}\",")
              ..write("${item[3]?.value ?? 0.0},")
              ..write("\"${item[4]?.value ?? ''}\")$lastSeparator");
            // print(rows[i]);
            // print(item[2].value);
          }
        }
      }

      log(sql);

      DatabaseHelper().initial().then((res) {
        // DatabaseHelper().db.execute("""INSERT INTO products(name, color, price) VALUES("三位面板带架","雕琢灰",12);""");
        DatabaseHelper().db.execute(
            'INSERT INTO product(name, color, price,description) VALUES${sql.toString()}');
      });
    } else {
      // User canceled the picker
    }
  }

  ///
  /// @desc 导出excel
  static void export() {}
}
