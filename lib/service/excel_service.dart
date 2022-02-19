import 'dart:io';

import 'package:excel/excel.dart';
import 'package:fd_price_manager/model/table_columns_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xlsio;

import '../util/log.dart';
import 'database_helper.dart';

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
  static void export(List dataList, List<TableColumnsModel> columns) async {
    if (dataList.isEmpty) {
      log("请先导入客户账单");
      return;
    }

    // Create a new Excel document.
    final xlsio.Workbook workbook = new xlsio.Workbook();
    //Accessing worksheet via index.
    final xlsio.Worksheet sheet = workbook.worksheets[0];
    //Add Text.

    xlsio.Style globalStyle = workbook.styles.add('style');
    globalStyle.fontName = 'Times New Roman';
    globalStyle.fontSize = 20;
    globalStyle.fontColor = '#000000';
    globalStyle.hAlign = xlsio.HAlignType.center;
    globalStyle.vAlign = xlsio.VAlignType.center;

    final excelHeaderTitle = '价格统计明细';

    sheet.getRangeByName("A1").setText(excelHeaderTitle);
    sheet.getRangeByName('A1').rowHeight = 40;

    // 合并居中
    sheet.getRangeByName("A1:J1").merge();
    sheet.getRangeByName("A1").cellStyle = globalStyle..fontSize = 22;

    // 第二行
    for (var item in columns) {
      if (item.tag != null) {
        sheet.getRangeByName(item.tag!).setText(item.title);
        sheet.getRangeByName(item.tag!).columnWidth = 15;
        sheet.getRangeByName(item.tag!).rowHeight = 35;
        sheet.getRangeByName(item.tag!).cellStyle = globalStyle
          ..fontSize = 16
          ..bold = true
          ..fontName = 'Times New Roman';
      }
    }

    for (var i = 1; i < dataList.length; i++) {
      sheet.getRangeByName('A${i + 2}').columnWidth = 15;
      sheet.getRangeByName('A${i + 2}').rowHeight = 35;

      sheet.getRangeByName('B${i + 2}').columnWidth = 15;
      sheet.getRangeByName('B${i + 2}').rowHeight = 35;

      sheet.getRangeByName('C${i + 2}').columnWidth = 15;
      sheet.getRangeByName('C${i + 2}').rowHeight = 35;

      sheet.getRangeByName('D${i + 2}').columnWidth = 15;
      sheet.getRangeByName('D${i + 2}').rowHeight = 35;

      sheet.getRangeByName('E${i + 2}').columnWidth = 15;
      sheet.getRangeByName('E${i + 2}').rowHeight = 35;

      sheet.getRangeByName('F${i + 2}').columnWidth = 15;
      sheet.getRangeByName('F${i + 2}').rowHeight = 35;

      sheet.getRangeByName('G${i + 2}').columnWidth = 15;
      sheet.getRangeByName('G${i + 2}').rowHeight = 35;

      sheet.getRangeByName('H${i + 2}').columnWidth = 25;
      sheet.getRangeByName('H${i + 2}').rowHeight = 35;

      sheet.getRangeByName('A${i + 2}').setText('${dataList[i]['name']}');
      sheet.getRangeByName('B${i + 2}').setText('${dataList[i]['color']}');
      sheet
          .getRangeByName('C${i + 2}')
          .setNumber(double.parse('${dataList[i]['price']}'));
      sheet
          .getRangeByName('D${i + 2}')
          .setNumber(dataList[i]['discount'].toDouble());
      sheet.getRangeByName('E${i + 2}').setNumber(dataList[i]['price']);
      sheet
          .getRangeByName('F${i + 2}')
          .setNumber(double.parse(dataList[i]['totalPrices']));
      sheet
          .getRangeByName('G${i + 2}')
          .setNumber(double.parse(dataList[i]['discountPrice']));
      sheet
          .getRangeByName('H${i + 2}')
          .setNumber(double.parse(dataList[i]['discountTotalPrices']));

      sheet.getRangeByName('A${i + 2}').cellStyle = globalStyle..fontSize = 10;
      sheet.getRangeByName('B${i + 2}').cellStyle = globalStyle..fontSize = 10;
      sheet.getRangeByName('C${i + 2}').cellStyle = globalStyle..fontSize = 10;
      sheet.getRangeByName('D${i + 2}').cellStyle = globalStyle..fontSize = 10;
      sheet.getRangeByName('E${i + 2}').cellStyle = globalStyle..fontSize = 10;
      sheet.getRangeByName('F${i + 2}').cellStyle = globalStyle..fontSize = 10;
      sheet.getRangeByName('G${i + 2}').cellStyle = globalStyle..fontSize = 10;
      sheet.getRangeByName('H${i + 2}').cellStyle = globalStyle..fontSize = 10;
    }
    final List<int> bytes = workbook.saveAsStream();

    String? path = await FilePicker.platform.saveFile(
      dialogTitle: '保存文件',
      type: FileType.any,
      fileName: '$excelHeaderTitle.xlsx',
    );

    if (path != null) {
      final file = File(path);
      file.writeAsBytes(bytes);
      workbook.dispose();
    }
  }
}
