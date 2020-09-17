import 'package:flutter/material.dart';

class PdfForm {

}

class InvoiceDetails {
  String invoiceNumber;
  String dateOfIssue;
  DateOfService dateOfService= new DateOfService.empty();
  String email;
  String password;
  String url;
  String phoneNumber;

}

class ContactDetails {
  String yourCompanyName;
  String addressLine1;
  String addressLine2;
  String addressLine3;
  String billToCompanyName;
  String billToAddressLine1;
  String billToAddressLine2;
  String billToAddressLine3;
}

class ServiceDetails {

}

class OverallInvoice {
  InvoiceDetails invoiceDetails;
  ContactDetails contactDetails;
  ServiceDetails serviceDetails;

  OverallInvoice(){
    invoiceDetails = new InvoiceDetails();
    contactDetails = new ContactDetails();
    serviceDetails = new ServiceDetails();
  }

}

class DateOfService {
  TextEditingController firstDateTxtCtrl = new TextEditingController();
  TextEditingController lastDateTxtCtrl = new TextEditingController();

  String firstDate;
  String lastDate;

  DateOfService.empty(){
    firstDateTxtCtrl.text = this.firstDate;
    lastDateTxtCtrl.text = this.lastDate;
  }

  DateOfService({this.firstDate, this.lastDate}){
    firstDateTxtCtrl.text = this.firstDate;
    lastDateTxtCtrl.text = this.lastDate;
  }

}

