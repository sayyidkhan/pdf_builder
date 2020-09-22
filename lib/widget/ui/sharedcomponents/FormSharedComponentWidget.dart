import 'package:flutter/material.dart';

class FormSharedComponentWidget {

  static Widget buildTextField({
    //key & controller will need to be mandatory fields
    Key key,
    TextEditingController controller,
    @required String labelText,
    int textFieldMaxLength,
    String errorMessage,
    @required Object inputValue,
    Function function,
    // bool validationRequired = false,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: labelText),
      maxLength: textFieldMaxLength,
      onSaved: (String value) {
        // if (validationRequired) {
        //   return value.isEmpty ? errorMessage : null;
        // }
        inputValue = value;
        if(controller != null){
          controller.text = inputValue;
          print("test: " + controller.text);
        }
      },
    );
  }

}