import 'package:flutter/material.dart';
import 'package:pdf_test/widget/ui/sharedcomponents/FormSharedComponentWidget.dart';

class ClientDetailWidget extends StatelessWidget {
  ClientDetailWidget(
      this._billToCompanyName,
      this._billToAddressLine1,
      this._billToAddressLine2,
      this._billToAddressLine3);

  final String _billToCompanyName;
  final String _billToAddressLine1;
  final String _billToAddressLine2;
  final String _billToAddressLine3;

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
    );
  }


}
