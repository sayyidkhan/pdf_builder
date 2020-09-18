import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pdf_test/widget/ui/sharedcomponent/FormSharedComponentWidget.dart';

class ContactorDetailWidget extends StatelessWidget {
  ContactorDetailWidget(
      this._yourCompanyName,
      this._addressLine1,
      this._addressLine2,
      this._addressLine3);

  final String _yourCompanyName;
  final String _addressLine1;
  final String _addressLine2;
  final String _addressLine3;

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
      ],
    );
  }

}
