

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:pdf_test/constant/AlertBoxContent.dart';
import 'package:pdf_test/main.dart';
import 'package:pdf_test/widget/transitions/PageTransistions.dart';

class AlertBox {
  static List<Widget> listOfButtons = initListOfButtons();

  static List<Widget> initListOfButtons() {
    //confirm buttons
    List<Widget> listOfConfirmButton = new List();

    List<Widget> listOfButtons = new List();
    return listOfButtons;
  }

  static Widget _cancelButton({BuildContext context}) {
    return FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  static Widget _pleaseWaitButton() {
    return FlatButton(
      child: Text("Please Wait..."),
      onPressed: null,
    );
  }

  static Widget _generalButton(
      {BuildContext context, String title, Function onClick}) {
    return FlatButton(
      child: Text(title),
      onPressed: () {
        onClick();
      },
    );
  }

  static void showAlertDialog(BuildContext context) {
    int buttonListSelect = 0;
    String title = AlertBoxStatus.confirm.title;
    String description = AlertBoxStatus.confirm.description;

    void changeToLoadingScreen(StateSetter setState) {
      setState(() {
        title = AlertBoxStatus.loading.title;
        description = AlertBoxStatus.loading.description;
        buttonListSelect = 1;
      });

      new Future.delayed(new Duration(seconds: 2), () {
        setState(() {
          title = AlertBoxStatus.completed.title;
          description = AlertBoxStatus.completed.description;
          buttonListSelect = 2;
        });
      });
    }

    goToHomePage(BuildContext context) {
      print("go to home page");
      Navigator.of(context).pushReplacement(SlideRightRoute(page: MyHomePage()));
    }

    void goToResultScreen() {
      print("go to result screen");
    }

    void changeButtonLayout() {

    }

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            //setup all button list
            final confirmationScreen = <Widget>[
              _cancelButton(context: context),
              _generalButton(
                context: context,
                title: "Continue",
                onClick: () => changeToLoadingScreen(setState),
              ),
            ];
            final loadingScreen = <Widget>[
              _pleaseWaitButton(),
              new CircularProgressIndicator(),
              SizedBox(width: 5,)
            ];
            final completedScreen = <Widget>[
              _generalButton(
                context: context,
                title: "Go Back To Main Menu",
                onClick: () => goToHomePage(context),
              ),
              _generalButton(
                context: context,
                title: "View PDF",
                onClick: () => goToResultScreen(),
              ),
            ];
            //store in a list
            final buttonList = new List();
            buttonList.add(confirmationScreen);
            buttonList.add(loadingScreen);
            buttonList.add(completedScreen);

            return AlertDialog(
              title: Text(title),
              content: Text(description),
              actions: buttonList[buttonListSelect],
            );
          },
        );
      },
    );
  }

}

