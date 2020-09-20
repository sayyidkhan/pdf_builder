import 'dart:io' as io;
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image/image.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as widgets;
import 'package:flutter/material.dart' as fm;
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

import '../widget/pdf/InvoicePageWidget.dart';

class Content2 {

  static Future<ByteData> getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load('$path');

//    final file = io.File('${(await getTemporaryDirectory()).path}/$path');
    final file = io.File('$path');
    await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    return byteData;
  }

  static void pdfVersion1(widgets.Document pdf){
    pdf.addPage(
        widgets.MultiPage(
          pageFormat: PdfPageFormat.a5,
          margin: widgets.EdgeInsets.all(32),

          build: (widgets.Context context){
            return <widgets.Widget>  [
              widgets.Header(
                  level: 0,
                  child: widgets.Text("Easy Approach Document")
              ),
              widgets.Paragraph(
                  text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Malesuada fames ac turpis egestas sed tempus urna. Quisque sagittis purus sit amet. A arcu cursus vitae congue mauris rhoncus aenean vel elit. Ipsum dolor sit amet consectetur adipiscing elit pellentesque. Viverra justo nec ultrices dui sapien eget mi proin sed."
              ),
              widgets.Paragraph(
                  text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Malesuada fames ac turpis egestas sed tempus urna. Quisque sagittis purus sit amet. A arcu cursus vitae congue mauris rhoncus aenean vel elit. Ipsum dolor sit amet consectetur adipiscing elit pellentesque. Viverra justo nec ultrices dui sapien eget mi proin sed."
              ),
              widgets.Header(
                  level: 1,
                  child: widgets.Text("Second Heading")
              ),
              widgets.Paragraph(
                  text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Malesuada fames ac turpis egestas sed tempus urna. Quisque sagittis purus sit amet. A arcu cursus vitae congue mauris rhoncus aenean vel elit. Ipsum dolor sit amet consectetur adipiscing elit pellentesque. Viverra justo nec ultrices dui sapien eget mi proin sed."
              ),
              widgets.Paragraph(
                  text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Malesuada fames ac turpis egestas sed tempus urna. Quisque sagittis purus sit amet. A arcu cursus vitae congue mauris rhoncus aenean vel elit. Ipsum dolor sit amet consectetur adipiscing elit pellentesque. Viverra justo nec ultrices dui sapien eget mi proin sed."
              ),
              widgets.Paragraph(
                  text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Malesuada fames ac turpis egestas sed tempus urna. Quisque sagittis purus sit amet. A arcu cursus vitae congue mauris rhoncus aenean vel elit. Ipsum dolor sit amet consectetur adipiscing elit pellentesque. Viverra justo nec ultrices dui sapien eget mi proin sed."
              ),
            ];
          },

        )
    );
  }

  static void pdfVersion2(widgets.Document pdf) async {
//    ByteData byteData = await getImageFileFromAssets("../../image/test_header.jpg");
    final ByteData bytes = await rootBundle.load("image/test_header.jpg");
//    final headerPng = decodeImage(f.readAsBytesSync());
    final headerImage = PdfImage.file(
      pdf.document,
      bytes: bytes.buffer.asUint8List(),
    );

//    final ralewayRegular = widgets.Font.ttf(await rootBundle.load("fonts/Raleway/Raleway-Regular.ttf"));
//    final ralewayBold =  widgets.Font.ttf(await rootBundle.load("fonts/Raleway/Raleway-Bold.ttf"));

    const twoCm = 2.0 * PdfPageFormat.cm;

    pdf.addPage(
      InvoicePage(
        //manage the position of the header from this page
        margin: widgets.EdgeInsets.fromLTRB(twoCm, 7.0 * PdfPageFormat.cm, twoCm, twoCm),
        headerImage: headerImage,
        build: (context) => widgets.Column(
          children: <widgets.Widget>[
            widgets.Text(
              "Invoice",
              style: widgets.TextStyle(fontSize: 36,fontWeight: widgets.FontWeight.bold),
            ),
            widgets.Row(
              mainAxisAlignment: widgets.MainAxisAlignment.center,
              children: <widgets.Widget>[
                widgets.Text("No: ", style: widgets.TextStyle(fontSize: 24.0,),),
                widgets.Padding(
                  padding: const widgets.EdgeInsets.only(top: 2),
                  child :  widgets.Text("T000001",  style: widgets.TextStyle(fontSize: 20.0,fontWeight: widgets.FontWeight.normal)),
                ),
              ],
            ),
            widgets.Row(
              mainAxisAlignment: widgets.MainAxisAlignment.center,
              children: <widgets.Widget>[
                widgets.Text("Date of issue: ", style: widgets.TextStyle(fontSize: 16.0,),),
                widgets.Padding(
                  padding: const widgets.EdgeInsets.only(top: 2),
                  child : widgets.Text("01/12/2020",  style: widgets.TextStyle(fontSize: 14.0,fontWeight: widgets.FontWeight.normal)),
                ),
              ],
            ),
            widgets.Row(
              mainAxisAlignment: widgets.MainAxisAlignment.center,
              children: <widgets.Widget>[
                widgets.Text("Date Of Service: ", style: widgets.TextStyle(fontSize: 16.0,),),
                widgets.Padding(
                  padding: const widgets.EdgeInsets.only(top: 2),
                  child : widgets.Text("01/12/2020 - 31/12/2020",  style: widgets.TextStyle(fontSize: 14.0,fontWeight: widgets.FontWeight.normal)),
                ),
              ],
            ),
            widgets.SizedBox(height: 2.0 * PdfPageFormat.cm),
            widgets.Row(
              mainAxisAlignment: widgets.MainAxisAlignment.spaceBetween,
              children: <widgets.Widget>[
                widgets.Column(
                    crossAxisAlignment: widgets.CrossAxisAlignment.start,
                    children: <widgets.Widget>[
                      widgets.Text(
                        "Contract Partner",
                        style: widgets.TextStyle(fontWeight: widgets.FontWeight.bold,decoration: widgets.TextDecoration.underline),
                      ),
                      widgets.Text(
                        "Fantasy company Ltd.",
//                        style: widgets.TextStyle(font: ralewayBold),
                      ),
                      widgets.Text(
                        "123 Ocean Drive",
//                        style: widgets.TextStyle(font: ralewayRegular),
                      ),
                      widgets.Text(
                        "90-315 Los Angeles, California",
//                        style: widgets.TextStyle(font: ralewayRegular),
                      ),
                      widgets.Text(
                        "United States of America",
//                        style: widgets.TextStyle(font: ralewayRegular),
                      ),
                    ]),
                widgets.Column(
                    crossAxisAlignment: widgets.CrossAxisAlignment.start,
                    children: <widgets.Widget>[
                      widgets.Text(
                        "Bill To",
                        style: widgets.TextStyle(fontWeight: widgets.FontWeight.bold,decoration: widgets.TextDecoration.underline),
                      ),
                      widgets.Text(
                        "otherland labs sp. z o.o.",
                      ),
                      widgets.Text(
                        "Joze korzeniowkiego 11/4",
//                        style: widgets.TextStyle(font: ralewayRegular),
                      ),
                      widgets.Text(
                        "37-700 Przemyl",
//                        style: widgets.TextStyle(font: ralewayRegular),
                      ),
                      widgets.Text(
                        "Poland",
//                        style: widgets.TextStyle(font: ralewayRegular),
                      ),
                    ]),
              ],
            ),
            widgets.SizedBox(height: 2.0 * PdfPageFormat.cm),
            widgets.Table.fromTextArray(
                context: context,
                data: [
                  ["No","Service","Total Price"],
                  ["1","Flutter Development","\$1000"],
                  ["2","Gatsby Development","\$500"],
                  ["3","React Development","\$5000"],
                ]
            ),
            widgets.SizedBox(height: 1.0 * PdfPageFormat.cm),
            widgets.Row(
                children: <widgets.Widget>[
                  widgets.Expanded(child: widgets.Container()),
                  widgets.Row(
                    mainAxisAlignment: widgets.MainAxisAlignment.center,
                    children: <widgets.Widget>[
                      widgets.Text("To Pay: ", style: widgets.TextStyle(fontSize: 20.0,),),
                      widgets.Padding(
                        padding: const widgets.EdgeInsets.only(top: 2),
                        child :  widgets.Text("\$1500",  style: widgets.TextStyle(fontSize: 18.0,fontWeight: widgets.FontWeight.bold)),
                      ),
                    ],
                  ),
                ]
            ),
            widgets.SizedBox(height: 3.0 * PdfPageFormat.cm),
            widgets.Row(
                mainAxisAlignment: widgets.MainAxisAlignment.spaceBetween,
                children: <widgets.Widget> [
                  widgets.Column(
                    children: <widgets.Widget> [
                      widgets.Container(
                        width: 4.0 * PdfPageFormat.cm,
                        decoration: widgets.BoxDecoration(border: widgets.BoxBorder(top: true)),
                      ),
                      widgets.Text("Buyer",
//                          style: widgets.TextStyle(font: ralewayRegular)
                      ),
                    ],
                  ),
                  widgets.Column(
                    children: <widgets.Widget> [
                      widgets.Container(
                        width: 4.0 * PdfPageFormat.cm,
                        decoration: widgets.BoxDecoration(border: widgets.BoxBorder(top: true)),
                      ),
                      widgets.Text("Seller",
//                          style: widgets.TextStyle(font: ralewayRegular)
                      ),
                    ],
                  )
                ]
            ),
          ],
        ),
      ),
    );
  }

}


