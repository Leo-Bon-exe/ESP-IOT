import 'dart:io';
import 'package:sdp_1/main_page_socket.dart';
import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';


class ExcelExporter {
  
  static Future<String> exportToExcel(List<DataModel> dataList) async {
    var excel = Excel.createExcel(); 
    Sheet sheetObject = excel['Sheet1']; 

   
  sheetObject.appendRow([
    TextCellValue("ID"),
    TextCellValue("Device 1 ID"),
    TextCellValue("Device 1 Current (A)"),
    TextCellValue("Device 1 Power (W)"),
    TextCellValue("Device 2 ID"),
    TextCellValue("Device 2 Current (A)"),
    TextCellValue("Device 2 Power (W)"),
    TextCellValue("Timestamp")
  ]);

  
  for (var data in dataList) {
    sheetObject.appendRow([
      TextCellValue(data.id.toString()), 
      TextCellValue(data.device1DeviceId), 
      TextCellValue(data.device1Current.toString()), 
      TextCellValue(data.device1Power.toString()), 
      TextCellValue(data.device2DeviceId), 
      TextCellValue(data.device2Current.toString()), 
      TextCellValue(data.device2Power.toString()), 
      TextCellValue(data.timestamp.toIso8601String()) 
    ]);
  }
    
    try {
      
      var directory =
          await getExternalStorageDirectory(); 
      
      String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      String outputFile =
          '${directory!.path}/data_export_$timestamp.xlsx'; 
      var fileBytes = excel.save();

      // Write Excel to file
      File(outputFile)
        ..createSync(recursive: true)
        ..writeAsBytesSync(fileBytes!);

      return 'Excel file exported to $outputFile'; 
    } catch (e) {
      return 'Error exporting Excel file: $e'; 
    }
  }
}
