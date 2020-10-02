import 'package:flutter/material.dart';

class FieldValidationAlertBox {

  static showAlertDialog(BuildContext context,String errorMessage) {

    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Incomplete Fields"),
      content: Text(errorMessage.toString(),style: TextStyle(fontSize: 14),),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

}