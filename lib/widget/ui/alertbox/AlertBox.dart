

import 'package:flutter/material.dart';
import 'package:pdf_test/constant/AlertBoxContent.dart';

class AlertBox {
  // static void showAlertDialog(BuildContext context) {
  //   String title;
  //   String description;
  //   AlertBoxStatus.changeStatus(title, description,AlertBoxEnum.confirm);
  //
  //   showDialog(
  //     barrierDismissible: false,
  //     context: context,
  //     builder: (context) {
  //       return StatefulBuilder(
  //         builder: (context, setState) {
  //           return AlertDialog(
  //             title: Text(title),
  //             content: Text(description),
  //             actions: <Widget>[
  //               FlatButton(
  //                   onPressed: () {
  //                     setState(() => {
  //                       title = AlertBoxStatus.loading.title,
  //                       description = AlertBoxStatus.loading.description,
  //                     });
  //                   },
  //                   child: Text("Change"))
  //             ],
  //           );
  //         },
  //       );
  //     },
  //   );
  // }

  static void showAlertDialog(BuildContext context) {
    int selectTitleOption = 0;

    String selectTitle(int no) {
      switch (no) {
        case 0:
          return "Confirm";
        case 1:
          return "Loading...";
        case 2:
          return "Completed";
      }
      return "";
    }

    String selectDialogContent(int no) {
      switch (no) {
        case 0:
          return "Would you like to confirm all the information entered?";
        case 1:
          return "Please Wait while we convert your document into a PDF...";
        case 2:
          return "Completed";
      }
      return "";
    }

    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Proceed"),
      onPressed: () {
        print(selectTitleOption.toString());
        selectTitleOption++;
      },
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        StateSetter _setState;
        String description;

        return AlertDialog(
          title: Text(selectTitle(selectTitleOption)),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              _setState = setState;

              _setState(() {
                description = selectDialogContent(selectTitleOption);
              });

              return Text(description);
            },
          ),
          actions: [
            cancelButton,
            continueButton,
          ],
        );
      },
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(selectTitle(selectTitleOption)),
          content: Text(
              "Would you like to confirm all the information entered?"),
          actions: [
            cancelButton,
            continueButton,
          ],
        );
      },
    );
  }
}
