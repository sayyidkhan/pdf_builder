import 'package:flutter/material.dart';
import 'package:pdf_test/screen/NewPdfPreviewScreen.dart';
import 'package:pdf_test/screen/PdfPreviewScreen.dart';

class PdfReader {
  static void navigateToPDFPage(BuildContext context, String filePath) {
    print("filePath: " + filePath.toString());
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => NewPdfPreviewScreen(
                  path: filePath,
                )));
  }
}
