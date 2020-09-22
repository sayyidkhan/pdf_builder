import 'package:flutter/material.dart';

class PdfForm {

}

class InvoiceDetails {
  TextEditingController invoiceNoTxtCtrl = new TextEditingController();

  String invoiceNumber;
  DateOfIssue dateOfIssue = new DateOfIssue.empty();
  DateOfService dateOfService= new DateOfService.empty();

}

class ContactorDetails {
  TextEditingController yourCompanyNameTxtCtrl = new TextEditingController();
  TextEditingController addressLine1TxtCtrl = new TextEditingController();
  TextEditingController addressLine2TxtCtrl = new TextEditingController();
  TextEditingController addressLine3TxtCtrl = new TextEditingController();

  String yourCompanyName;
  String addressLine1;
  String addressLine2;
  String addressLine3;
}

class ClientDetails {
  TextEditingController billToCompanyNameTxtCtrl = new TextEditingController();
  TextEditingController billToAddressLine1TxtCtrl = new TextEditingController();
  TextEditingController billToAddressLine2TxtCtrl = new TextEditingController();
  TextEditingController billToAddressLine3TxtCtrl = new TextEditingController();

  String billToCompanyName;
  String billToAddressLine1;
  String billToAddressLine2;
  String billToAddressLine3;
}

class ServiceDetails {
  static int serviceIdCounter = 0;
  int _serviceId;
  String serviceName;
  double nettPrice;

  ServiceDetails(this.serviceName, this.nettPrice) {
    _serviceId = incrementServiceIdCounter();
  }

  incrementServiceIdCounter() {
    return serviceIdCounter += 1;
  }

  int get serviceId => _serviceId;
}

class OverallInvoice {
  InvoiceDetails invoiceDetails;
  ContactorDetails contactorDetails;
  ClientDetails clientDetails;
  List<ServiceDetails> serviceDetails;

  OverallInvoice() {
    invoiceDetails = new InvoiceDetails();
    contactorDetails = new ContactorDetails();
    clientDetails = new ClientDetails();
    serviceDetails = new List();
  }

}

class DateOfIssue {
  TextEditingController dateOfIssueCtrl = new TextEditingController();

  String doi;

  DateOfIssue.empty(){
    dateOfIssueCtrl.text = this.doi;
  }

  DateOfIssue({this.doi}){
    dateOfIssueCtrl.text = this.doi;
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

