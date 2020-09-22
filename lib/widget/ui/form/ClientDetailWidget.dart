import 'package:flutter/material.dart';
import 'package:pdf_test/database/PdfForm.dart';
import 'package:pdf_test/widget/ui/sharedcomponents/FormSharedComponentWidget.dart';

class ClientDetailWidget extends StatelessWidget {
  ClientDetailWidget(this.clientDetails);

  final ClientDetails clientDetails;

  @override
  Widget build(BuildContext context) {
    return Column(
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
          controller: clientDetails.billToCompanyNameTxtCtrl,
          maxLength: 30,
          decoration: InputDecoration(labelText: "Billing Company Name"),
          validator: (String value) {
            return value.isEmpty ? 'Company Name is Required' : null;
          },
          onSaved: (String value) {
            clientDetails.billToCompanyName = value;
            clientDetails.billToCompanyNameTxtCtrl.text = clientDetails.billToCompanyName;
          },
        ),
        TextFormField(
          controller: clientDetails.billToAddressLine1TxtCtrl,
          maxLength: 30,
          decoration: InputDecoration(labelText: "Address Line 1"),
          validator: (String value) {
            return value.isEmpty ? 'Address Line 1 cannot be empty' : null;
          },
          onSaved: (String value) {
            clientDetails.billToAddressLine1 = value;
            clientDetails.billToAddressLine1TxtCtrl.text = clientDetails.billToAddressLine1;
          },
        ),
        TextFormField(
          controller: clientDetails.billToAddressLine2TxtCtrl,
          maxLength: 30,
          decoration: InputDecoration(labelText: "Address Line 2"),
          onSaved: (String value) {
            clientDetails.billToAddressLine2 = value;
            clientDetails.billToAddressLine2TxtCtrl.text = clientDetails.billToAddressLine2;
          },
        ),
        TextFormField(
          controller: clientDetails.billToAddressLine3TxtCtrl,
          maxLength: 30,
          decoration: InputDecoration(labelText: "Address Line 3"),
          onSaved: (String value) {
            clientDetails.billToAddressLine3 = value;
            clientDetails.billToAddressLine3TxtCtrl.text = clientDetails.billToAddressLine3;
          },
        ),
      ],
    );
  }


}
