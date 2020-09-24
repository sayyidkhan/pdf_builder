import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/flutter_full_pdf_viewer.dart';
import 'package:pdf_test/main.dart';
import 'package:pdf_test/widget/transitions/PageTransistions.dart';
import 'package:printing/printing.dart';

class PdfPreviewScreen extends StatelessWidget {
  final Key key;
  final Uint8List pdfFile;
  final String path;

  PdfPreviewScreen({this.key,this.pdfFile,this.path});

  Future printPdf(Uint8List pdf) async {
    await Printing.sharePdf(bytes: pdf, filename: 'my-document.pdf');
  }

  @override
  Widget build(BuildContext context) {
    final content = pdfFile;

    return PDFViewerScaffold(
      key: key,
      appBar: AppBar(
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              print("go to home page");
              Navigator.of(context).pushReplacement(SlideRightRoute(page: MyHomePage()));
            },
          ),
          title: Text("PDF Preview"),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.file_download),
              tooltip: 'download file',
              onPressed: () {
                printPdf(pdfFile);
                print("download");
              },
            ),
          ],
      ),
      path: path,
    );
  }
}
