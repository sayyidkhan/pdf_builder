import 'dart:io';

import 'package:path_provider/path_provider.dart';

class IoOperations {

  static Future<String> writeDocsIntoDirectory(String fileName) async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String documentPath = documentDirectory.path;
    String fullPath = "$documentPath/$fileName.pdf";
    return fullPath;
  }

  static Future<String> renameDocsFromDirectory(String oldFilePath,String oldFileName,String fileName) async {
    File sourceFile = _obtainLocalFile(oldFilePath);
    String newPath = findAndReplaceFilePath(oldFilePath, oldFileName, fileName);
    try{
      await sourceFile.rename(newPath);
      print("file successfully renamed");
    }
    on Exception {
      print("issue with renaming the file");
    }
    return newPath;
  }

  static void deleteDocsFromDirectory(String filePath) {
    try{
      final dir = Directory(filePath);
      dir.deleteSync(recursive: true);
      print("Fie is deleted successfully from the file path");
    }
    on Exception {
      print("File is not deleted successfully from the file path");
    }
  }

  static File _obtainLocalFile(String localPath) {
    return File(localPath);
  }

  static String findAndReplaceFilePath(String text,String findText,String replaceText) {
    final original = text;
    final find = findText + ".pdf";
    final replaceWith = replaceText + ".pdf";
    return original.replaceAll(find, replaceWith);
  }

}