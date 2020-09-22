import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:pdf_test/database/PdfForm.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;

class InvoiceDetailWidget extends StatefulWidget {
  final InvoiceDetails invoiceDetails;
  InvoiceDetailWidget(this.invoiceDetails);

  @override
  _InvoiceDetailWidgetState createState() => _InvoiceDetailWidgetState();
}

class _InvoiceDetailWidgetState extends State<InvoiceDetailWidget> {
  final formKey = new GlobalKey<FormState>();
  //date range
  static DateTime minYear;
  static DateTime maxYear;

  String getDateString(DateTime date) =>
      "${date.day}/${date.month}/${date.year}";

  DateTime getYear(int value) {
    return new DateTime(DateTime.now().year + value);
  }

  @override
  void initState() {
    super.initState();
    //init fields
    minYear = getYear(-2);
    maxYear = getYear(2);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      onChanged: () {
        formKey.currentState.save();
        InvoiceDetails invoiceDetails = widget.invoiceDetails;
        print("invoice details: ${invoiceDetails.invoiceNumber}");
        print("date of issue: " + invoiceDetails.dateOfIssue.doi);
        print("date of service (from): " +
            invoiceDetails.dateOfService.firstDate);
        print("date of service (to): " + invoiceDetails.dateOfService.lastDate);
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Invoice Details",
                textAlign: TextAlign.left,
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.grey.shade700,
                ),
              ),
            ),
          ),
          Column(
            children: [
              TextFormField(
                controller: widget.invoiceDetails.invoiceNoTxtCtrl,
                maxLength: 10,
                decoration: InputDecoration(labelText: "Invoice No"),
                validator: (String value) {
                  return value.isEmpty ? 'Invoice Number is Required' : null;
                },
                onSaved: (String value) {
                  widget.invoiceDetails.invoiceNumber = value;
                  widget.invoiceDetails.invoiceNoTxtCtrl.text = widget.invoiceDetails.invoiceNumber;
                },
              ),
              _buildDateOfIssue(),
              _subHeaderTitle("Date Of Service"),
              _buildDateOfService(),
              SizedBox(
                height: 50,
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDateOfIssue() {
    return Row(
      children: <Widget>[
        Expanded(
          child: TextFormField(
            controller: widget.invoiceDetails.dateOfIssue.dateOfIssueCtrl,
            maxLength: 10,
            decoration: InputDecoration(labelText: 'Date Of Issue',counter: Offstage(),),
            validator: (String value) {
              return value.isEmpty ? 'Date of Issue is Required' : null;
            },
            onSaved: (String value) {
              widget.invoiceDetails.dateOfIssue = new DateOfIssue(doi: value);
            },
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 2, top: 20, right: 2),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey[500],
              ),
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            height: 30,
            child: FlatButton(
              textColor: Theme.of(context).primaryColor,
              onPressed: () {
                DatePicker.showDatePicker(
                  context,
                  showTitleActions: true,
                  minTime: minYear,
                  maxTime: maxYear,
                  onChanged: (date) {},
                  onConfirm: (date) {
                    setState(() {
                      widget.invoiceDetails.dateOfIssue.doi =
                          getDateString(date);
                      widget.invoiceDetails.dateOfIssue = new DateOfIssue(
                          doi: widget.invoiceDetails.dateOfIssue.doi);
                    });
                  },
                  currentTime: DateTime.now(),
                  locale: LocaleType.en,
                  theme: DatePickerTheme(
                    doneStyle: TextStyle(color: Colors.white),
                    itemStyle: TextStyle(color: Colors.white70),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                );
              },
              child: Text(
                "Select Date",
                style: TextStyle(fontWeight: FontWeight.normal),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _subHeaderTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 25, bottom: 5),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.grey[600],
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Widget _buildDateOfService() {
    return Row(
      children: <Widget>[
        Expanded(
          child: TextFormField(
            controller: widget.invoiceDetails.dateOfService.firstDateTxtCtrl,
            maxLength: 10,
            decoration: InputDecoration(labelText: 'From',counter: Offstage(),),
            validator: (String value) {
              return value.isEmpty ? 'Date From is Required' : null;
            },
            onSaved: (String value) {
              widget.invoiceDetails.dateOfService.firstDate = value;
            },
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: TextFormField(
            controller: widget.invoiceDetails.dateOfService.lastDateTxtCtrl,
            maxLength: 10,
            decoration: InputDecoration(labelText: 'To',counter: Offstage(),),
            validator: (String value) {
              return value.isEmpty ? 'Date To is Required' : null;
            },
            onSaved: (String value) {
              widget.invoiceDetails.dateOfService.lastDate = value;
            },
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 2, top: 20, right: 2),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey[500],
              ),
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            height: 30,
            child: FlatButton(
              textColor: Theme.of(context).primaryColor,
              onPressed: () async {
                final List<DateTime> picked =
                    await DateRangePicker.showDatePicker(
                  context: context,
                  initialFirstDate: DateTime.now(),
                  initialLastDate:
                      (new DateTime.now()).add(new Duration(days: 7)),
                  firstDate: minYear,
                  lastDate: maxYear,
                );
                if (picked != null && picked.length == 2) {
                  String firstDate = getDateString(picked[0]);
                  String lastDate = getDateString(picked[1]);
                  setState(() {
                    widget.invoiceDetails.dateOfService = new DateOfService(
                        firstDate: firstDate, lastDate: lastDate);
                  });
                } else if (picked != null && picked.length == 1) {
                  String firstDate = getDateString(picked[0]);
                  setState(() {
                    widget.invoiceDetails.dateOfService =
                        new DateOfService(firstDate: firstDate, lastDate: null);
                  });
                }
              },
              child: Text(
                "Select Date",
                style: TextStyle(fontWeight: FontWeight.normal),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
