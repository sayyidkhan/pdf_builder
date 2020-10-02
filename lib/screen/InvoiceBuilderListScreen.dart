import 'package:flutter/material.dart';
import 'package:pdf_builder/constant/pdf/crud/PdfReader.dart';
import 'package:pdf_builder/database/io/IoOperations.dart';
import 'package:pdf_builder/database/sql/db_helper.dart';
import 'package:pdf_builder/database/dao/pdfDAO.dart';
import 'package:pdf_builder/screen/FormScreen.dart';
import 'package:pdf_builder/widget/ui/alertbox/ConfirmDeleteAlertBox.dart';
import 'package:pdf_builder/widget/ui/pdfbuilder/InvoiceOverviewWidget.dart';

class InvoiceBuilderListScreen extends StatefulWidget {
  @override
  _InvoiceBuilderListScreenState createState() =>
      _InvoiceBuilderListScreenState();
}

class _InvoiceBuilderListScreenState extends State<InvoiceBuilderListScreen> {
  Future<List<PdfDB>> pdfDbList;
  TextEditingController controller = TextEditingController();
  String newFileName;
  int currentPDFId;
  PdfDB currentPDFdb;

  final formKey = new GlobalKey<FormState>();
  DBHelper dbHelper;
  bool isUpdating;
  //alertbox
  bool currentState;


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

  assignFileName(String val) {
    newFileName = val;
  }

  clearName() {
    controller.text = "";
  }

  refreshList() {
    dbHelper = DBHelper();
    setState(() {
      pdfDbList = dbHelper.getPdfDB();
      print("refresh homepage list");
    });
    dbHelper.close();
  }

  validateUpdate() async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      //IO Operations
      final newFilePath = await IoOperations.renameDocsFromDirectory(
          currentPDFdb.filePath, currentPDFdb.fileName, newFileName);
      //SQL Operations
      PdfDB d = PdfDB(currentPDFId, newFileName, newFilePath);
      dbHelper = DBHelper();
      await dbHelper.initDb();
      dbHelper.update(d);
      setState(() {
        isUpdating = false;
      });
      dbHelper.close();
    }
    clearName();
    refreshList();
  }

  deleteItemFromList(PdfDB pdf) async {
    dbHelper = DBHelper();
    await dbHelper.initDb();
    await dbHelper.delete(pdf.id);
    IoOperations.deleteDocsFromDirectory(pdf.filePath);
    refreshList();
  }

  _validateDelete(bool newState,PdfDB pdf) {
    currentState = newState;
    if(currentState) {
      deleteItemFromList(pdf);
    }
    else {
      print("### item is not deleted ###");
    }
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
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.blueGrey,
                          ),
                        ), onTap: () {
                      setState(() {
                        isUpdating = true;
                        currentPDFId = pdf.id;
                        currentPDFdb = pdf;
                      });
                      controller.text = pdf.fileName;
                    }),
                    DataCell(ConfirmDeleteAlertBoxButton(_validateDelete,pdf)),
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
          if (snapshot.hasData && snapshot.data.length > 0) {
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
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      //cursorColor: Colors.white,
                      controller: controller,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'Change PDF Name',
                        labelStyle: TextStyle(color: Colors.white70),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white38),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white38),
                        ),
                      ),
                      validator: (val) => val.length == 0 ? "Enter Name" : null,
                      onSaved: (val) => assignFileName(val),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FlatButton(
                          onPressed: validateUpdate,
                          child: Text(
                            "UPDATE",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        FlatButton(
                          child: Text(
                            "CLOSE",
                            style: TextStyle(color: Colors.white),
                          ),
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
          ),
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
