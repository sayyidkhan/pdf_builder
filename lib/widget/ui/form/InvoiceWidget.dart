import 'package:flutter/material.dart';

class InvoiceWidget extends StatefulWidget {
  final title;
  final Icon icons;
  final myInnerComponents;

  @override
  _InvoiceWidgetState createState() => _InvoiceWidgetState();

  InvoiceWidget({this.title,this.icons,this.myInnerComponents});
}

class _InvoiceWidgetState extends State<InvoiceWidget> {
  bool isToggled = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Material(
        elevation: 1,
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            AppBar(
              leading: widget.icons,
              elevation: 0,
              title: Text(
                  widget.title,
                  style: TextStyle(fontSize: 18),
              ),
              backgroundColor: Theme.of(context).accentColor,
              centerTitle: true,
              actions: <Widget>[toggleArrowButton()],
            ),
            toggleDisplayContainer(),
          ],
        ),
      ),
    );
  }

  Widget toggleDisplayContainer() {
    return
      isToggled ?
      Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
        child: widget.myInnerComponents,
      ),
      )
      :
      new Container();
  }

  IconButton toggleArrowButton() {
    return IconButton(
      icon: Icon(
        isToggled ? Icons.arrow_drop_down : Icons.arrow_right,
        color: Colors.white,
      ),
      onPressed: () {
        setState(() {
          isToggled = !isToggled;
        });
      },
    );
  }

}
