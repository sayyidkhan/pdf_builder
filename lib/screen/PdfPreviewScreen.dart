import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/flutter_full_pdf_viewer.dart';
import 'package:pdf_builder/main.dart';
import 'package:pdf_builder/widget/transitions/PageTransistions.dart';
import 'package:share/share.dart';

class PdfPreviewScreen extends StatelessWidget {
  final Key key;
  final String path;

  PdfPreviewScreen({this.key,this.path});

  Future sharePdf(String filePath) async {
    Share.shareFiles(['$filePath']);
  }

  @override
  Widget build(BuildContext context) {
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
              print("download");
              sharePdf(path);
            },
          ),
        ],
      ),
      path: path,
    );
  }
}
