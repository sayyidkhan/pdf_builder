import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pdf_test/database/dao/FormDAO.dart';
import 'package:pdf_test/widget/ui/alertbox/CreatePdfAlertBox.dart';
import 'package:pdf_test/widget/ui/form/BillingDetailWidget.dart';
import 'package:pdf_test/widget/ui/form/InvoiceDetailWidget.dart';
import 'package:pdf_test/widget/ui/form/ServiceDetailWidget.dart';

class FormScreen extends StatefulWidget {
  static const routeName = '/createNewInvoice';
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final List<Widget> list = new List();
  int currentPagination = 1;
  OverallInvoice overallInvoice;
  //validation controllers
  bool validateInvoiceDetail = false;
  bool validateContractorDetail = false;
  bool validateClientDetail = false;
  bool validateServiceDetail = false;

  @override
  void initState() {
    super.initState();
    overallInvoice = new OverallInvoice();
    initPageDetail();
  }

  @override
  void dispose() {
    overallInvoice = null;
    super.dispose();
  }

  void toggleValidationStatus(int currentPagination,bool status) {
    print(currentPagination);
    switch(currentPagination){
      case(1):
        validateInvoiceDetail = status;
        break;
      case(2):
        validateContractorDetail = status;
        break;
      case(3):
        validateClientDetail = status;
        break;
      case(4):
        validateServiceDetail = status;
        break;
    }
  }

  bool checkValidationStatus() {
    List<bool> validationItem = [
      validateInvoiceDetail,
      validateContractorDetail,
      validateClientDetail,
    ];

    bool result = false;
    validationItem.forEach((element) {
      if(element){
        result = true;
      }
    });
    return result;
  }

  List<Widget> initPageDetail() {
    //first page
    list.add(InvoiceDetailWidget(overallInvoice.invoiceDetails,1,toggleValidationStatus));
    //second page
    list.add(BillingWidget(overallInvoice.contractorDetails,2,toggleValidationStatus));
    //third page
    list.add(BillingWidget(overallInvoice.clientDetails,3,toggleValidationStatus));
    //fourth page
    list.add(ServiceDetailWidget(overallInvoice.serviceDetails));
    return list;
  }

  Widget accessPageDetail(int i) {
    return list[i];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create a New Invoice")),
      body: ListView(
        children: <Widget>[
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              pagination(1, "Invoice"),
              paginationBlocks(),
              pagination(2, "Contractor"),
              paginationBlocks(),
              pagination(3, "Client"),
              paginationBlocks(),
              pagination(4, "Service"),
            ],
          ),
          Container(
            height: 420,
            padding: const EdgeInsets.only(
              left: 30,
              right: 30,
            ),
            child: Center(
              child: accessPageDetail(currentPagination - 1),
            ),
          ),
          backAndNextButton(context),
        ],
      ),
    );
  }

  void validationErrorMsg() {
    print("validation not success on page ${currentPagination.toString()}");
    print("clear validation process before proceeding");
  }

  Widget backAndNextButton(BuildContext context) {
    Expanded backButton() {
      return Expanded(
        child: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey[500],
              ),
              color: currentPagination != 1 ? Colors.red[700] : Colors.grey[500],
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            height: 40,
            width: double.infinity,
            child: FlatButton(
              textColor: Colors.white,
              onPressed: currentPagination != 1 ? () {
                //prevent page to navigate, if there is error messages not handled
                var checkValidationMsgs = checkValidationStatus();
                if(checkValidationMsgs) {
                  validationErrorMsg();
                }
                else {
                  setState(() {
                    currentPagination--;
                  });
                }
              }
              :
              null,
              child: Text(
                "Back",
                style: TextStyle(fontWeight: FontWeight.normal),
              ),
            ),
          ),
        ),
      );
    }

    Expanded nextButton() {
      return Expanded(
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
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
                //prevent page to navigate, if there is error messages not handled
                var checkValidationMsgs = checkValidationStatus();
                if(checkValidationMsgs){
                  validationErrorMsg();
                }
                else{
                  if (currentPagination < list.length) {
                    setState(() {
                      currentPagination++;
                    });
                  }
                  else if(currentPagination == list.length){
                    CreatePdfAlertBox.showAlertDialog(context,overallInvoice);
                    //print data to verify its content
                    overallInvoice.printContent();
                  }
                }
              },
              child: Text(
                currentPagination == list.length ? "Proceed" : "Next",
                style: TextStyle(fontWeight: FontWeight.normal),
              ),
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, bottom: 25),
      child: Container(
        child: Row(
          children: [
            backButton(),
            nextButton(),
          ],
        ),
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
        //prevent page to navigate, if there is error messages not handled
        var checkValidationMsgs = checkValidationStatus();
        if(checkValidationMsgs) {
          validationErrorMsg();
        }
        else {
          setState(() {
            currentPagination = number;
          });
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 7.5, right: 7.5),
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
            title,
            style: TextStyle(fontSize: 10.5, fontWeight: textBold),
          ),
          Text(
            "details",
            style: TextStyle(fontSize: 12.5, fontWeight: textBold),
          ),
        ]),
      ),
    );
  }

  Widget paginationBlocks() {
    return Padding(
      padding: const EdgeInsets.only(left: 7.5, right: 7.5, bottom: 28),
      child: Container(
        width: 10,
        height: 10,
        color: Colors.grey.shade500,
      ),
    );
  }
}
