import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart';
import 'package:pdf_test/constant/pdf/templates/PdfTemplate2.dart';

import 'package:pdf_test/database/FormDataStructure.dart';
import 'package:pdf_test/database/IoOperations.dart';
import 'package:pdf_test/database/db_helper.dart';
import 'package:pdf_test/database/pdfDB.dart';
import 'package:pdf_test/screen/PdfPreviewScreen.dart';

import '../templates/DummyContent.dart';

class PdfBuilder {
  bool filePathAssigned = false;
  final String _fileName;
  String _directory;
  final Document _pdf = new Document();
  var content;
  //SQL-STATEMENTS
  DBHelper dbHelper;
  PdfDB pdfDB;

  String get fileName => _fileName;

  PdfBuilder(this._fileName, int content) {
    _writeOnPdf(content);
  }

  //only use this method to create new PDF templates and persist into database
  PdfBuilder.createPdfTemplate(this._fileName, OverallInvoice overallInvoice) {
    _writeOnPdfTemplateWriter(overallInvoice);
  }

  Future<void> _writeOnPdfTemplateWriter(OverallInvoice overallInvoice) async {
    PdfTemplate2.pdfWriter(overallInvoice, _pdf);
    content = await savePdf();
    //SQL-STATEMENTS
    dbHelper = DBHelper();
    print("filename: " + _fileName.toString());
    print("directory: " + _directory.toString());
    pdfDB = PdfDB(null, _fileName, _directory);
    dbHelper.save(pdfDB);
    dbHelper.close();
  }

  void navigateToPdfPage(BuildContext context) {
    String fullPath = filePath();

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PdfPreviewScreen(
                  path: fullPath,
                )));
  }

  void _writeOnPdf(int content) {
    switch (content) {
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
    if (_directory == null) {
      throw new Exception("file path not assigned");
    }
    return _directory;
  }

  Future<String> get _tempDirectory async {
    _directory = await IoOperations.tempDocDirectory(_fileName);
    print("### file directory ###");
    print(_directory);
    print("######################");
    return _directory;
  }
}
