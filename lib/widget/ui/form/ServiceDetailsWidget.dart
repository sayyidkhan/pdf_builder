import 'package:flutter/material.dart';

class ServiceDetailWidget extends StatefulWidget {
  final title;
  final Icon icons;

  @override
  _ServiceDetailWidgetState createState() => _ServiceDetailWidgetState();

  ServiceDetailWidget({this.title, this.icons});
}

class _ServiceDetailWidgetState extends State<ServiceDetailWidget> {
  List<ServiceDetails> serviceDetailList = new List();
  bool isToggled = true;

  test() {

  }

  test2() => {};

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
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    isToggled ? Icons.add_circle : null,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      serviceDetailList.add(ServiceDetails());
                    });
                  },
                ),
                IconButton(
                  icon: Icon(
                    isToggled ? Icons.arrow_drop_down : Icons.arrow_right,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      isToggled = !isToggled;
                    });
                  },
                ),
              ],
            ),
            toggleDisplayContainer(),
          ],
        ),
      ),
    );
  }

  Widget toggleDisplayContainer() {
    String serviceName;
    return isToggled
        ? Container(
            height: 250,
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
              child: ListView.builder(
                  itemCount: serviceDetailList.length,
                  itemBuilder: (BuildContext context,int index) {
                    return individualServiceDetail(serviceName,index);
                  },
              ),
            ),
          )
        : new Container();
  }

  Widget individualServiceDetail(String serviceName,int index) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 20,right: 20,bottom: 0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: Icon(Icons.delete),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20,bottom: 0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "item no: ${index + 1}",
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
              SizedBox(
                width: 10,
              ),
            ],
          ),
          _buildServiceName(serviceName),
          Row(
            children: <Widget>[
              Expanded(
                child: _buildServiceName(serviceName),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: _buildServiceName(serviceName),
              ),
              SizedBox(
                width: 10,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildServiceName(String inputValue) {
    return TextFormField(
      decoration: InputDecoration(labelText: "Service Name"),
      maxLength: 50,
      validator: (String value) {
        return value.isEmpty ? "Service Name cannot be empty" : null;
      },
      onSaved: (String value) {
        inputValue = value;
      },
    );
  }
}

class ServiceDetails {
  String _serviceName;
  int _netPrice;
  int _gstRate;
  int _totalGross;

  ServiceDetails();
}
