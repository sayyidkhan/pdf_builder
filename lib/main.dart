import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pdf_test/database/pdfDB.dart';
import 'package:pdf_test/NewInvoiceBuilderListing.dart';
import 'package:pdf_test/screen/FormScreen.dart';
import 'package:pdf_test/widget/ui/pdfbuilder/InvoiceOverviewWidget.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Invoice App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
        routes: {
        FormScreen.routeName : (ctx) => FormScreen(),
        },
    );
  }
}

class MyHomePage extends StatelessWidget {

  Widget build(BuildContext context) {
    return NewInvoiceBuilderListing();
  }
  //original UI is in below here..

  //   List<ListTile> listArray = new InvoiceOverviewWidget(context).listArray;
  //
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text("Invoice Builder"),
  //       automaticallyImplyLeading: false,
  //     ),
  //     body:
  //     listArray.isEmpty ?
  //       InvoiceOverviewWidget.emptyList() :
  //       Padding(
  //         padding: const EdgeInsets.all(10.0),
  //         child: ListView(
  //           children: ListTile.divideTiles(
  //             context: context,
  //             tiles: listArray
  //           ).toList(),
  //         ),
  //       ),
  //     floatingActionButton: FloatingActionButton(
  //       onPressed: () {},
  //       child: IconButton(
  //         icon: const Icon(Icons.add),
  //         tooltip: 'Add New Invoice',
  //         onPressed: () {
  //           Navigator.pushNamed( context,  FormScreen.routeName );
  //         }
  //       ),
  //     ),
  //   );
  // }

}
