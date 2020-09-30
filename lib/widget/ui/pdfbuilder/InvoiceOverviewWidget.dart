import 'package:flutter/material.dart';

class InvoiceOverviewWidget {

  static Container emptyList() {
    const double fontSize1 = 34;
    const double fontSize2 = 16;

    return Container(
      width: double.infinity,
      height: double.infinity,

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget> [
          Text(
            "No Items to Display",
            style: TextStyle(fontSize: fontSize1),
          ),
          SizedBox(height: 20),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                    text: "click on the",
                    style: TextStyle(
                        fontSize: fontSize2,
                    ),
                ),
                TextSpan(
                    text: " plus button ",
                    style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: fontSize2,
                        fontWeight: FontWeight.bold
                    ),
                ),
                TextSpan(
                    text: "to ",
                    style: TextStyle(
                    fontSize: fontSize2
                    ),
                ),
              ],
            ),
          ),
          Text(
            "start creating invoices!",
            style: TextStyle(fontSize: fontSize2),
          ),
        ],
      ),
    );
  }

}