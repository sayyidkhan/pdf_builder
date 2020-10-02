import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pdf_builder/screen/InvoiceBuilderListScreen.dart';
import 'package:pdf_builder/screen/FormScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Invoice App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
        routes: {
        FormScreen.routeName : (ctx) => FormScreen(),
        },
    );
  }
}

class MyHomePage extends StatelessWidget {

  Widget build(BuildContext context) {
    return InvoiceBuilderListScreen();
  }

}
