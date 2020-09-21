import 'package:flutter/material.dart';

class FormSharedComponentWidget {

  static Widget buildTextField({
    String labelText,
    int textFieldMaxLength,
    String errorMessage,
    Object inputValue,
    FocusNode focusNode,
    bool validationRequired = false,
  }) {
    return TextFormField(
      decoration: InputDecoration(labelText: labelText),
      maxLength: textFieldMaxLength,
      focusNode: focusNode,
      onSaved: (String value) {
        if (validationRequired) {
          return value.isEmpty ? errorMessage : null;
        }
        inputValue = value;
      },
    );
  }

}