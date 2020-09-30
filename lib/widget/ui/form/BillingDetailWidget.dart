import 'package:flutter/material.dart';
import 'package:pdf_test/database/dao/FormDAO.dart';

//for the contractor & client details
class BillingWidget extends StatelessWidget {
  final formKey = new GlobalKey<FormState>();
  BillingWidget(this.billingDetails);

  final BillingDetails billingDetails;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      onChanged: () {
        formKey.currentState.save();
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20,bottom: 0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Client Detail",
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
          TextFormField(
            controller: billingDetails.companyNameTxtCtrl,
            maxLength: 30,
            decoration: InputDecoration(labelText: "Company Name"),
            validator: (String value) {
              return value.isEmpty ? 'Company Name is Required' : null;
            },
            onSaved: (String value) {
              billingDetails.companyName = value;
              billingDetails.companyNameTxtCtrl.text = billingDetails.companyName;
            },
          ),
          TextFormField(
            controller: billingDetails.addressLine1TxtCtrl,
            maxLength: 30,
            decoration: InputDecoration(labelText: "Address Line 1"),
            validator: (String value) {
              return value.isEmpty ? 'Address Line 1 cannot be empty' : null;
            },
            onSaved: (String value) {
              billingDetails.addressLine1 = value;
              billingDetails.addressLine1TxtCtrl.text = billingDetails.addressLine1;
            },
          ),
          TextFormField(
            controller: billingDetails.addressLine2TxtCtrl,
            maxLength: 30,
            decoration: InputDecoration(labelText: "Address Line 2"),
            onSaved: (String value) {
              billingDetails.addressLine2 = value;
              billingDetails.addressLine2TxtCtrl.text = billingDetails.addressLine2;
            },
          ),
          TextFormField(
            controller: billingDetails.addressLine3TxtCtrl,
            maxLength: 30,
            decoration: InputDecoration(labelText: "Address Line 3"),
            onSaved: (String value) {
              billingDetails.addressLine3 = value;
              billingDetails.addressLine3TxtCtrl.text = billingDetails.addressLine3;
            },
          ),
        ],
      ),
    );
  }


}
