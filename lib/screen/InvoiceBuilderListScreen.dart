import 'package:flutter/material.dart';
import 'package:pdf_test/constant/pdf/crud/PdfReader.dart';
import 'package:pdf_test/database/db_helper.dart';
import 'package:pdf_test/database/pdfDB.dart';
import 'package:pdf_test/screen/FormScreen.dart';
import 'package:pdf_test/widget/ui/pdfbuilder/InvoiceOverviewWidget.dart';

class InvoiceBuilderListScreen extends StatefulWidget {
  @override
  _InvoiceBuilderListScreenState createState() =>
      _InvoiceBuilderListScreenState();
}

class _InvoiceBuilderListScreenState extends State<InvoiceBuilderListScreen> {
  Future<List<PdfDB>> pdfDbList;
  TextEditingController controller = TextEditingController();
  String name;
  int currentPDFId;

  final formKey = new GlobalKey<FormState>();
  DBHelper dbHelper;
  bool isUpdating;

  @override
  void initState() {
    isUpdating = false;
    refreshList();
    super.initState();
  }

  @override
  void dispose() {
    dbHelper.close();
    super.dispose();
  }

  refreshList() {
    dbHelper = DBHelper();
    setState(() {
      pdfDbList = dbHelper.getPdfDB();
      print("refresh homepage list");
    });
    dbHelper.close();
  }

  clearName() {
    controller.text = "";
  }

  validate() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      if (isUpdating) {
        PdfDB d = PdfDB(currentPDFId, name, name + "_filepath");
        dbHelper.update(d);
        setState(() {
          isUpdating = false;
        });
      } else {
        PdfDB d = PdfDB(null, name, name + "_filepath");
        dbHelper.save(d);
      }
      clearName();
      refreshList();
    }
  }

  validateUpdate() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      PdfDB d = PdfDB(currentPDFId, name, name + "_filepath");
      dbHelper.update(d);
      setState(() {
        isUpdating = false;
      });
    }
    clearName();
    refreshList();
  }

  SingleChildScrollView dataTable(List<PdfDB> pdfDBList) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        columnSpacing: 20,
        columns: [
          DataColumn(
              label: Text(
            "PDF NAME",
            style: TextStyle(
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800]),
          )),
          DataColumn(
              label: Padding(
            padding: const EdgeInsets.only(left: 11.0),
            child: Text("VIEW"),
          )),
          DataColumn(
              label: Padding(
            padding: const EdgeInsets.only(left: 11.0),
            child: Text("EDIT"),
          )),
          DataColumn(label: Text("DELETE")),
        ],
        rows: pdfDBList
            .map((pdf) => DataRow(
                  cells: [
                    DataCell(Text(pdf.fileName)),
                    DataCell(
                        IconButton(
                          icon: const Icon(
                            Icons.image,
                            color: Colors.blueAccent,
                          ),
                        ), onTap: () {
                      String filePath = pdf.filePath;
                      PdfReader.navigateToPDFPage(context, filePath);
                    }),
                    DataCell(
                        IconButton(
                          icon: const Icon(Icons.edit),
                        ), onTap: () {
                      setState(() {
                        isUpdating = true;
                        currentPDFId = pdf.id;
                      });
                      controller.text = pdf.fileName;
                    }),
                    DataCell(IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        dbHelper.delete(pdf.id);
                        refreshList();
                      },
                    ))
                  ],
                ))
            .toList(),
      ),
    );
  }

  list() {
    return Expanded(
      child: FutureBuilder(
        future: pdfDbList,
        builder: (context, snapshot) {
          //if data exist, return data table
          if (snapshot.hasData) {
            return dataTable(snapshot.data);
          }
          //if data is null or empty list, display no information found
          if (null == snapshot.data || snapshot.data.length == 0) {
            return Center(child: InvoiceOverviewWidget.emptyList());
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }

  Widget form() {
    return isUpdating
        ? Container(
            color: Theme.of(context).primaryColor,
            child: Form(
              key: formKey,
              child: Padding(
                padding:
                    EdgeInsets.only(left: 30, right: 30, top: 15, bottom: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  verticalDirection: VerticalDirection.down,
                  children: [
                    TextFormField(
                      controller: controller,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(labelText: 'Change PDF Name'),
                      validator: (val) => val.length == 0 ? "Enter Name" : null,
                      onSaved: (val) => name = val,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FlatButton(
                          onPressed: validateUpdate,
                          child: Text("UPDATE"),
                        ),
                        FlatButton(
                          child: Text("CLOSE"),
                          onPressed: () {
                            setState(() {
                              isUpdating = false;
                            });
                            clearName();
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        : Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Invoice Builder"),
          automaticallyImplyLeading: false,
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.refresh,
                  color: Colors.white,
                ),
                onPressed: () async {
                  await refreshList();
                }),
          ]),
      body: new Container(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          verticalDirection: VerticalDirection.down,
          children: [
            list(),
            form(),
          ],
        ),
      ),
      floatingActionButton: isUpdating
          ? null
          : FloatingActionButton(
              onPressed: () {},
              child: IconButton(
                  icon: const Icon(Icons.add),
                  tooltip: 'Add New Invoice',
                  onPressed: () {
                    Navigator.pushNamed(context, FormScreen.routeName);
                  }),
            ),
    );
  }
}
