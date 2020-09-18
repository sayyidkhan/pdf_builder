import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;
import 'package:flutter/cupertino.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter/material.dart';
import 'package:pdf_test/database/PdfForm.dart';
import 'package:pdf_test/widget/ui/form/FormSharedComponentWidget.dart';
import 'package:pdf_test/widget/ui/form/InvoiceWidget.dart';
import 'package:pdf_test/widget/ui/form/ServiceDetailsWidget.dart';

class FormScreen extends StatefulWidget {
  static const routeName = '/cart';

  @override
  State<StatefulWidget> createState() {
    return FormScreenState();
  }

}

class FormScreenState extends State<FormScreen> {
  //date range
  static DateTime minYear;
  static DateTime maxYear;

  TextEditingController _dateOfIssueTxtCtrl = new TextEditingController();

  //invoice details variables
  String _invoiceNumber;
  String _dateOfIssue;
  DateOfService _dateOfService= new DateOfService.empty();
  String _email;
  String _password;
  String _url;
  String _phoneNumber;

  //contact detail variables
  String _yourCompanyName;
  String _addressLine1;
  String _addressLine2;
  String _addressLine3;
  String _billToCompanyName;
  String _billToAddressLine1;
  String _billToAddressLine2;
  String _billToAddressLine3;

  @override
  void initState() {
    super.initState();
    //init fields
    minYear = getYear(-2);
    maxYear = getYear(2);
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  DateTime getYear(int value){
    return new DateTime(DateTime.now().year + value);
  }

  void setValueToController(TextEditingController controller,String text){
    controller.text = text;
  }

  String getDateString(DateTime date) => "${date.day}/${date.month}/${date.year}";


  @override
  Widget build(BuildContext context) {
    DateTime oneDate = DateTime.now();

    return Scaffold(
      appBar: AppBar(title: Text("Create a New Invoice")),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              //need to turn cardWidget into its own class
              InvoiceWidget(
                title: "Invoice Details",
                icons: Icon(Icons.textsms),
                myInnerComponents: Column(
                  children: <Widget>[
                    FormSharedComponentWidget.buildTextField(
                      labelText: "Invoice No",
                      textFieldMaxLength: 10,
                      errorMessage: 'Invoice Number is Required',
                      inputValue: _invoiceNumber,
                      validationRequired: true,
                    ),
                    _buildDateOfIssue(),
                    _subHeaderTitle("Date Of Service"),
                    _buildDateOfService(),
                  ],
                ),
              ),
              InvoiceWidget(
                title: "Contact Details",
                icons: Icon(Icons.perm_contact_calendar),
                myInnerComponents: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 20,bottom: 0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Contractor Details",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            decoration:TextDecoration.underline,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ),
                    ),
                    FormSharedComponentWidget.buildTextField(
                      labelText: "Company Name",
                      textFieldMaxLength: 30,
                      errorMessage: 'Company Name is Required',
                      inputValue: _yourCompanyName,
                      validationRequired: true,
                    ),
                    FormSharedComponentWidget.buildTextField(
                      labelText: "Address Line 1",
                      textFieldMaxLength: 30,
                      errorMessage: 'Address Line 1 cannot be empty',
                      inputValue: _addressLine1,
                      validationRequired: true,
                    ),
                    FormSharedComponentWidget.buildTextField(
                      labelText: "Address Line 2",
                      textFieldMaxLength: 30,
                      errorMessage: 'Address Line 1 cannot be empty',
                      inputValue: _addressLine2,
                    ),
                    FormSharedComponentWidget.buildTextField(
                      labelText: "Address Line 3",
                      textFieldMaxLength: 30,
                      errorMessage: 'Address Line 1 cannot be empty',
                      inputValue: _addressLine3,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20,bottom: 0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Bill To",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            decoration:TextDecoration.underline,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ),
                    ),
                    FormSharedComponentWidget.buildTextField(
                      labelText: "Company Name",
                      textFieldMaxLength: 30,
                      errorMessage: 'Company Name is Required',
                      inputValue: _billToCompanyName,
                      validationRequired: true,
                    ),
                    FormSharedComponentWidget.buildTextField(
                      labelText: "Address Line 1",
                      textFieldMaxLength: 30,
                      errorMessage: 'Address Line 1 cannot be empty',
                      inputValue: _billToAddressLine1,
                      validationRequired: true,
                    ),
                    FormSharedComponentWidget.buildTextField(
                      labelText: "Address Line 2",
                      textFieldMaxLength: 30,
                      errorMessage: 'Address Line 1 cannot be empty',
                      inputValue: _billToAddressLine2,
                    ),
                    FormSharedComponentWidget.buildTextField(
                      labelText: "Address Line 3",
                      textFieldMaxLength: 30,
                      errorMessage: 'Address Line 1 cannot be empty',
                      inputValue: _billToAddressLine3,
                    ),
                  ],
                ),
              ),

              ServiceDetailWidget(
                title: "Service Details",
                icons: Icon(Icons.receipt),
              ),
//              _buildEmail(),
//              _buildPassword(),
//              _builURL(),
//              _buildPhoneNumber(),

              SizedBox(height: 100),

              new MaterialButton(
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  onPressed: () async {
                    final List<DateTime> picked = await DateRangePicker.showDatePicker(
                        context: context,
                        initialFirstDate: oneDate,
                        initialLastDate: oneDate,
                        firstDate: minYear,
                        lastDate: maxYear,
                    );
                    if (picked != null) {
                      print(picked);
                    }
                  },
                  child: new Text("Pick date range")
              ),

              RaisedButton(
                child: Text(
                  'Submit',
                  style: TextStyle(color: Colors.blue, fontSize: 16),
                ),
                onPressed: () {
                  if (!_formKey.currentState.validate()) {
                    return;
                  }

                  _formKey.currentState.save();

                  print(_invoiceNumber);
                  print(_email);
                  print(_phoneNumber);
                  print(_url);
                  print(_password);
                  print(_dateOfIssue);

                  //Send to API
                },
              ),
              RawMaterialButton(
                onPressed: () {},
                elevation: 2.0,
                fillColor: Colors.blue,
                child: Icon(
                  Icons.add,
                  size: 15.0,
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(15.0),
                shape: CircleBorder(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListView(String title,Widget widget) {
    bool _isCollapsed = false;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      borderOnForeground: true,
      child: Column(
        children: [
          Container(
            color: Theme.of(context).primaryColor,
            child: ListTile(
              title: Padding(
                padding: const EdgeInsets.only(left:26.0),
                child: Center(
                    child: Text(title,style: TextStyle(color: Colors.white)
                    )
                ),
              ),
              trailing: Icon(Icons.arrow_right,color: Colors.white,),
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20),
              child: widget
            ),
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
              controller: _dateOfIssueTxtCtrl,
            decoration: InputDecoration(labelText: 'Date Of Issue'),
              validator: (String value) {
                return value.isEmpty ? 'Date of Issue is Required' : null;
              },
              onSaved: (String value) {
                _dateOfIssue = value;
              },
            ),
          ),
          SizedBox(width: 10,),
          Padding(
            padding: const EdgeInsets.only(left: 2,top: 20,right: 2),
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
                    DatePicker.showDatePicker(context,
                      showTitleActions: true,
                      minTime: minYear,
                      maxTime: maxYear,
                      onChanged: (date) {
                      },
                      onConfirm: (date) {
                        setState(() {
                          _dateOfIssue = getDateString(date);
                          setValueToController(_dateOfIssueTxtCtrl,_dateOfIssue);
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
                  child: Text("Select Date",style: TextStyle(fontWeight: FontWeight.normal),),
              ),
            ),
          ),
    ],
    );
  }

  Padding _subHeaderTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(top: 25.0),
      child: new Text(
        title,
        style: TextStyle(fontSize: 16.0,color: Colors.grey[600],fontWeight: FontWeight.w300,),
      ),
    );
  }

  Widget _buildDateOfService() {
    return Row(
      children: <Widget>[
        Expanded(
          child: TextFormField(
            controller: _dateOfService.firstDateTxtCtrl,
            decoration: InputDecoration(labelText: 'From'),
            validator: (String value) {
              return value.isEmpty ? 'Date of Service is Required' : null;
            },
            onSaved: (String value) {
              _dateOfService.firstDate = value;
            },
          ),
        ),
        SizedBox(width: 10,),
        Expanded(
          child: TextFormField(
            controller: _dateOfService.lastDateTxtCtrl,
            decoration: InputDecoration(labelText: 'To'),
            validator: (String value) {
              return value.isEmpty ? 'Date of Service is Required' : null;
            },
            onSaved: (String value) {
              _dateOfService.lastDate = value;
            },
          ),
        ),
        SizedBox(width: 10,),
        Padding(
          padding: const EdgeInsets.only(left: 2,top: 20,right: 2),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey[500],
              ),
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            height: 30,
            child: FlatButton(
//              color: Colors.yellow,
              textColor: Theme.of(context).primaryColor,
              onPressed: () async {
                final List<DateTime> picked = await DateRangePicker.showDatePicker(
                  context: context,
                  initialFirstDate: DateTime.now(),
                  initialLastDate: (new DateTime.now()).add(new Duration(days: 7)),
                  firstDate: minYear,
                  lastDate: maxYear,
                );
                if (picked != null && picked.length == 2) {
                  String firstDate = getDateString(picked[0]);
                  String lastDate = getDateString(picked[1]);
                  setState(() {
                    _dateOfService = new DateOfService(firstDate: firstDate, lastDate: lastDate);
                  });
                }
                else if (picked != null && picked.length == 1) {
                  String firstDate = getDateString(picked[0]);
                  setState(() {
                    _dateOfService = new DateOfService(firstDate: firstDate, lastDate: null);
                  });
                }
              },
              child: Text("Select Date",style: TextStyle(fontWeight: FontWeight.normal),),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmail() {
    const regExp = r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?";
    return TextFormField(
      decoration: InputDecoration(labelText: 'Email'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Email is Required';
        }

        if (!RegExp(regExp)
            .hasMatch(value)) {
          return 'Please enter a valid email Address';
        }

        return null;
      },
      onSaved: (String value) {
        _email = value;
      },
    );
  }

  Widget _buildPassword() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Password'),
      keyboardType: TextInputType.visiblePassword,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Password is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _password = value;
      },
    );
  }

  Widget _builURL() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Url'),
      keyboardType: TextInputType.url,
      validator: (String value) {
        if (value.isEmpty) {
          return 'URL is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _url = value;
      },
    );
  }

  Widget _buildPhoneNumber() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Phone number'),
      keyboardType: TextInputType.phone,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Phone number is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _url = value;
      },
    );
  }

}