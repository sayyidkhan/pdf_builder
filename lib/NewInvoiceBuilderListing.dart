import 'package:flutter/material.dart';
import 'package:pdf_test/database/db_helper.dart';
import 'package:pdf_test/database/pdfDB.dart';
import 'package:pdf_test/screen/FormScreen.dart';

class NewInvoiceBuilderListing extends StatefulWidget {
  @override
  _NewInvoiceBuilderListingState createState() => _NewInvoiceBuilderListingState();
}

class _NewInvoiceBuilderListingState extends State<NewInvoiceBuilderListing> {
  Future<List<PdfDB>> pdfDbList;
  TextEditingController controller = TextEditingController();
  String name;
  int curUserId;

  final formKey = new GlobalKey<FormState>();
  DBHelper dbHelper;
  bool isUpdating;

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    isUpdating = false;
    refreshList();
  }

  refreshList() {
    setState(() {
      pdfDbList = dbHelper.getPdfDB();
    });
  }

  clearName() {
    controller.text = "";
  }

  validate() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      if (isUpdating) {
        PdfDB d = PdfDB(curUserId, name);
        dbHelper.update(d);
        setState(() {
          isUpdating = false;
        });
      } else {
        PdfDB d = PdfDB(null, name);
        dbHelper.save(d);
      }
      clearName();
      refreshList();
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
          DataColumn(label: Text("")),
          DataColumn(label: Text("")),
          DataColumn(label: Text("")),
        ],
        rows: pdfDBList
            .map((pdf) => DataRow(
                  cells: [
                    DataCell(Text(pdf.fileName), onTap: () {
                      setState(() {
                        isUpdating = true;
                        curUserId = pdf.id;
                      });
                      controller.text = pdf.id.toString();
                    }),
                    DataCell(IconButton(
                      icon: const Icon(Icons.image),
                    )),
                    DataCell(IconButton(
                      icon: const Icon(Icons.edit),
                    )),
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
          if (snapshot.hasData) {
            return dataTable(snapshot.data);
          }

          if (null == snapshot.data || snapshot.data.length == 0) {
            return Text("No Data Found");
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }

  form() {
    return Form(
      key: formKey,
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          verticalDirection: VerticalDirection.down,
          children: [
            TextFormField(
              controller: controller,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(labelText: 'Name'),
              validator: (val) => val.length == 0 ? "Enter Name" : null,
              onSaved: (val) => name = val,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FlatButton(
                  onPressed: validate,
                  child: Text(isUpdating ? "UPDATE" : "ADD"),
                ),
                FlatButton(
                  child: Text("CANCEL"),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Invoice Builder"),
      ),
      body: new Container(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          verticalDirection: VerticalDirection.down,
          children: [
            form(),
            list(),
          ],
        ),
      ),
    floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Add New Invoice',
            onPressed: () {
              Navigator.pushNamed( context,  FormScreen.routeName );
            }
          ),
        ),
    );
  }
}
