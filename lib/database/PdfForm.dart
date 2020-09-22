import 'package:flutter/material.dart';

class PdfForm {

}

class InvoiceDetails {
  TextEditingController invoiceNoTxtCtrl = new TextEditingController();

  String invoiceNumber;
  DateOfIssue dateOfIssue = new DateOfIssue.empty();
  DateOfService dateOfService= new DateOfService.empty();

  printContent() {
    print("invoice number: " + invoiceNumber);
    dateOfIssue.printContent();
    dateOfService.printContent();
  }

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

  printContent() {
    print("my company name: " + yourCompanyName);
    print("my address 1: " + addressLine1);
    print("my address 2: " + addressLine1);
    print("my address 3: " + addressLine1);
  }

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

  printContent() {
    print("billing company name: " + billToCompanyName);
    print("billing address 1: " + billToAddressLine1);
    print("billing address 2: " + billToAddressLine2);
    print("billing address 3: " + billToAddressLine3);
  }

}

class ServiceDetails {
  TextEditingController serviceNameTxtCtrl = new TextEditingController();
  TextEditingController nettPriceTxtCtrl = new TextEditingController();

  static int serviceIdCounter = 0;
  int _serviceId;
  String serviceName;
  String nettPrice = "0.00";

  ServiceDetails(this.serviceName, this.nettPrice) {
    _serviceId = incrementServiceIdCounter();
    nettPriceTxtCtrl.text = "0.00";
  }

  incrementServiceIdCounter() {
    return serviceIdCounter += 1;
  }

  int get serviceId => _serviceId;

  printContent() {
    print("service name: " + serviceName);
    print("nett price: " + nettPrice);
  }

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

    serviceDetails.add(ServiceDetails("init", "0.00"));
  }

  void printContent() {
    _getAllServiceDetailsToPrint(){
      int counter = 0;
      serviceDetails.forEach((element) {
        counter = counter + 1;
        print("service detail $counter");
        element.printContent();
      });
    }

    invoiceDetails.printContent();
    contactorDetails.printContent();
    clientDetails.printContent();
    _getAllServiceDetailsToPrint();
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

  printContent() {
    print("--- date of issue ---");
    print("date of issue: " + doi);
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

  printContent() {
    print("--- date of service ---");
    print("first date: " + firstDate);
    print("last date: " + lastDate);
  }

}

