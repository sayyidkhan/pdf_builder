import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pdf_test/database/PdfForm.dart';
import 'package:pdf_test/widget/ui/form/InvoiceDetailWidget.dart';

class NewFormScreen extends StatefulWidget {
  static const routeName = '/createNewInvoice';
  @override
  _NewFormScreenState createState() => _NewFormScreenState();
}

class _NewFormScreenState extends State<NewFormScreen> {
  final List<Widget> list = new List();
  int currentPagination = 1;
  OverallInvoice overallInvoice;

  @override
  void initState() {
    super.initState();
    initPageDetail();
    overallInvoice = new OverallInvoice();
  }

  @override
  void dispose() {
    overallInvoice = null;
    super.dispose();
  }

  List<Widget> initPageDetail() {
    //first page
    list.add(InvoiceDetailWidget());
    //second page
    list.add(InvoiceDetailWidget());
    //third page
    list.add(InvoiceDetailWidget());
    return list;
  }

  Widget accessPageDetail(int i) {
    return list[i];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create a New Invoice")),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              pagination(1, "Invoice"),
              paginationBlocks(),
              pagination(2, "Contact"),
              paginationBlocks(),
              pagination(3, "Item List"),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(
                left: 30,
                right: 30,
              ),
              child: Center(
                child: accessPageDetail(currentPagination - 1),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey[500],
                ),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              height: 40,
              width: double.infinity,
              child: FlatButton(
                textColor: Theme.of(context).primaryColor,
                onPressed: () {

                },
                child: Text("Next",style: TextStyle(fontWeight: FontWeight.normal),),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget pagination(int number, String title) {
    var colorBox =
        number <= currentPagination ? Colors.blue : Colors.grey.shade300;
    var textBold =
        number <= currentPagination ? FontWeight.bold : FontWeight.normal;

    return GestureDetector(
      onTap: () {
        setState(() {
          currentPagination = number;
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: Column(children: [
          Container(
            width: 40,
            height: 40,
            color: colorBox,
            child: Center(
                child: Text(
              number.toString(),
              style: TextStyle(fontWeight: textBold),
            )),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "$title details",
            style: TextStyle(fontSize: 12, fontWeight: textBold),
          ),
        ]),
      ),
    );
  }

  Widget paginationBlocks() {
    return Padding(
      padding: const EdgeInsets.only(left: 2.5, right: 2.5, bottom: 15),
      child: Container(
        width: 10,
        height: 10,
        color: Colors.grey.shade500,
      ),
    );
  }
}
