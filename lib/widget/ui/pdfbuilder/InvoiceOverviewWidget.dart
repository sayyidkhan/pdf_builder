import 'package:flutter/material.dart';
import 'package:pdf_test/constant/PdfBuilder.dart';
import 'package:pdf_test/screen/PdfPreviewScreen.dart';

class InvoiceOverviewWidget {

  List<ListTile> _listArray = [];

  List<ListTile> get listArray => _listArray;

  InvoiceOverviewWidget(BuildContext context){
    //add List Tile
    _listArray.add(customListArray(context,"Pdf Sample 1","lorem ipsum lorem ipsum lorem ipsum",1));
    _listArray.add(customListArray(context,"Pdf Sample 2","lorem ipsum lorem ipsum lorem ipsum",2));
  }

  ListTile customListArray(
      BuildContext context,
      String title,
      String subtitle,
      int pdfContent) {
    return ListTile(
      contentPadding: EdgeInsets.only(left: 10,top: 10,bottom: 10,right: 5),
      title: Text(title),
      // subtitle: Text(subtitle),
      trailing: Wrap(
        spacing: 2.5, // space between two icons
        children: <IconButton>[
          IconButton(
              icon: const Icon(Icons.image),
              tooltip: "Delete",
              color: Colors.blue,
              onPressed: () async {
                print("view button");
                PdfBuilder pdf = new PdfBuilder(title,pdfContent);
                await navigateToPage(context, pdf);
              }),
          IconButton(
              icon: const Icon(Icons.edit),
              tooltip: "Edit",
              color: Colors.blue,
              onPressed: null),
          IconButton(
              icon: const Icon(Icons.delete),
              tooltip: "Delete",
              color: Colors.red.shade400,
              onPressed: () {
                print("delete button");
              }),
        ],
      ),
      onTap: () {

      },
    );
  }

  Future navigateToPage(BuildContext context,PdfBuilder pdf) async {
    final content = await pdf.savePdf();
    String fullPath = pdf.filePath();

    Navigator.push(context, MaterialPageRoute(
        builder: (context) =>
            PdfPreviewScreen(
              path: fullPath,
            )
    ));
  }

  static Container emptyList() {

    const double fontSize1 = 34;
    const double fontSize2 = 16;

    return Container(
      width: double.infinity,
      height: double.infinity,

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget> [
          Text(
            "No Items to Display",
            style: TextStyle(fontSize: fontSize1),
          ),
          SizedBox(height: 20),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                    text: "click on the",
                    style: TextStyle(
                        fontSize: fontSize2,
                    ),
                ),
                TextSpan(
                    text: " plus button ",
                    style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: fontSize2,
                        fontWeight: FontWeight.bold
                    ),
                ),
                TextSpan(
                    text: "to ",
                    style: TextStyle(
                    fontSize: fontSize2
                    ),
                ),
              ],
            ),
          ),
          Text(
            "start creating invoices!",
            style: TextStyle(fontSize: fontSize2),
          ),
        ],
      ),
    );
  }

}