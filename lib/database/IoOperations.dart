import 'dart:io';

import 'package:path_provider/path_provider.dart';

class IoOperations {

  static Future<String> writeDocsIntoDirectory(String fileName) async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String documentPath = documentDirectory.path;
    String fullPath = "$documentPath/$fileName.pdf";
    return fullPath;
  }

  static Future<String> renameDocsFromDirectory(String oldFilePath,String fileName) {
    Future<File> test;
  }

  static Future<String> deleteDocsFromDirectory(String filePath) {
    try{
      final dir = Directory(filePath);
      dir.deleteSync(recursive: true);
      print("Fie is deleted successfully from the file path");
    }
    on Exception {
      print("File is not deleted successfully from the file path");
    }
  }

}