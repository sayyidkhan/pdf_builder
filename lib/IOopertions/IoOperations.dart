
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class IoOperations {

  static Future<String> tempDocDirectory(String fileName) async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String documentPath = documentDirectory.path;
    String fullPath = "$documentPath/$fileName.pdf";
    return fullPath;
  }

}