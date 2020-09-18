import 'package:flutter/material.dart';

class FormSharedComponentWidget {

  static Widget buildTextField({
    String labelText,
    int textFieldMaxLength,
    String errorMessage,
    Object inputValue,
    bool validationRequired = false,
  }) {
    return TextFormField(
      decoration: InputDecoration(labelText: labelText),
      maxLength: textFieldMaxLength,
      onSaved: (String value) {
        if (validationRequired) {
          return value.isEmpty ? errorMessage : null;
        }
        inputValue = value;
      },
    );
  }

}