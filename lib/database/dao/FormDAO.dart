import 'package:flutter/material.dart';

class InvoiceDetails {
  TextEditingController invoiceNoTxtCtrl = new TextEditingController();

  String invoiceNumber;
  DateOfIssue dateOfIssue = new DateOfIssue.empty();
  DateOfService dateOfService= new DateOfService.empty();

  printContent() {
    print("invoice number: " + invoiceNumber.toString());
    dateOfIssue.printContent();
    dateOfService.printContent();
  }

}

class BillingDetails {
  TextEditingController companyNameTxtCtrl = new TextEditingController();
  TextEditingController addressLine1TxtCtrl = new TextEditingController();
  TextEditingController addressLine2TxtCtrl = new TextEditingController();
  TextEditingController addressLine3TxtCtrl = new TextEditingController();

  String companyName;
  String addressLine1;
  String addressLine2;
  String addressLine3;

  printContent(int number) {
    if(number == 0 || number == 1){
      //personal details
      if(number == 0){
        print("my company name: " + companyName.toString());
      }
      //client details
      else if(number == 1){
        print("billing company name: " + companyName.toString());
      }
      print("billing address 1: " + addressLine1.toString());
      print("billing address 2: " + addressLine2.toString());
      print("billing address 3: " + addressLine3.toString());
    }

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
  BillingDetails contractorDetails;
  BillingDetails clientDetails;
  List<ServiceDetails> serviceDetails;

  OverallInvoice() {
    invoiceDetails = new InvoiceDetails();
    contractorDetails = new BillingDetails();
    clientDetails = new BillingDetails();
    serviceDetails = new List();

    serviceDetails.add(ServiceDetails("", "0.00"));
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
    contractorDetails.printContent(0);
    clientDetails.printContent(1);
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
    print("date of issue: " + doi.toString());
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
    print("first date: " + firstDate.toString());
    print("last date: " + lastDate.toString());
  }

}

