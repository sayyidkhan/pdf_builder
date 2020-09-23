import 'dart:io' as io;
import 'package:flutter/services.dart';

class LoadPdfImage {

  static Future<ByteData> getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load('$path');

//    final file = io.File('${(await getTemporaryDirectory()).path}/$path');
    final file = io.File('$path');
    await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    return byteData;
  }

}