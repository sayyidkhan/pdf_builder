import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart';
import 'package:pdf_test/constant/pdfTemplates/PdfTemplate2.dart';
import 'package:pdf_test/database/FormDataStructure.dart';
import 'package:pdf_test/database/IoOperations.dart';
import 'package:pdf_test/screen/PdfPreviewScreen.dart';

import 'DummyContent.dart';

class GeneratePdfContent {
  bool filePathAssigned = false;
  final String _fileName;
  String _directory;
  final Document _pdf = new Document();

  var content;

  String get fileName => _fileName;

  GeneratePdfContent(this._fileName,int content){
    _writeOnPdf(content);
  }

  GeneratePdfContent.PdfTemplate(this._fileName,OverallInvoice overallInvoice){
    _writeOnPdfTemplateWriter(overallInvoice);
  }

  void _writeOnPdfTemplateWriter(OverallInvoice overallInvoice) async {
    PdfTemplate2.pdfWriter(overallInvoice,_pdf);
    content = await savePdf();
  }

  void navigateToPdfPage(BuildContext context) {
    String fullPath = filePath();

    Navigator.push(context, MaterialPageRoute(
        builder: (context) =>
            PdfPreviewScreen(
              pdfFile: content,
              path: fullPath,
            )
    ));
  }

  void _writeOnPdf(int content) {
    switch(content){
      case 1:
        Content2.pdfVersion1(_pdf);
        break;
      case 2:
        Content2.pdfVersion2(_pdf);
        break;
    }
  }

  Future savePdf() async {
    String directory = await _tempDirectory;
    File file = new File(directory);
    final content = _pdf.save();
    file.writeAsBytesSync(content);

    filePathAssigned = true;
    return content;
  }

  String filePath() {
    if(_directory == null){
      throw new Exception("file path not assigned");
    }
    return _directory;
  }

  Future<String> get _tempDirectory async {
    _directory = await IoOperations.tempDocDirectory(_fileName);
    return _directory;
  }

}