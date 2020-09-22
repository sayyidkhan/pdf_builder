import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pdf_test/database/PdfForm.dart';

class ContactorDetailWidget extends StatelessWidget {
  final ContactorDetails contactorDetails;

  ContactorDetailWidget(this.contactorDetails);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Contractor Details",
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
        TextFormField(
          controller: contactorDetails.yourCompanyNameTxtCtrl,
          maxLength: 30,
          decoration: InputDecoration(labelText: "Company Name"),
          validator: (String value) {
            return value.isEmpty ? 'Company Name is Required' : null;
          },
          onSaved: (String value) {
            contactorDetails.yourCompanyName = value;
            contactorDetails.yourCompanyNameTxtCtrl.text = contactorDetails.yourCompanyName;
          },
        ),
        TextFormField(
          controller: contactorDetails.addressLine1TxtCtrl,
          maxLength: 30,
          decoration: InputDecoration(labelText: "Address Line 1"),
          validator: (String value) {
            return value.isEmpty ? 'Address Line 1 cannot be empty' : null;
          },
          onSaved: (String value) {
            contactorDetails.addressLine1 = value;
            contactorDetails.addressLine1TxtCtrl.text = contactorDetails.addressLine1;
          },
        ),
        TextFormField(
          controller: contactorDetails.addressLine2TxtCtrl,
          maxLength: 30,
          decoration: InputDecoration(labelText: "Address Line 2"),
          onSaved: (String value) {
            contactorDetails.addressLine2 = value;
            contactorDetails.addressLine2TxtCtrl.text = contactorDetails.addressLine2;
          },
        ),
        TextFormField(
          controller: contactorDetails.addressLine3TxtCtrl,
          maxLength: 30,
          decoration: InputDecoration(labelText: "Address Line 3"),
          onSaved: (String value) {
            contactorDetails.addressLine3 = value;
            contactorDetails.addressLine3TxtCtrl.text = contactorDetails.addressLine3;
          },
        ),
      ],
    );
  }


}
