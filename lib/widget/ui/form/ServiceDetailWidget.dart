import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf_test/database/FormDataStructure.dart';

class ServiceDetailWidget extends StatefulWidget {
  final List<ServiceDetails> serviceDetails;

  @override
  _ServiceDetailWidgetState createState() => _ServiceDetailWidgetState();

  ServiceDetailWidget(this.serviceDetails);
}

class _ServiceDetailWidgetState extends State<ServiceDetailWidget> {
  final formKey = new GlobalKey<FormState>();
  final serviceIdCounter = 0;
  final double _gstRate = 0.00;

  @override
  void initState() {
    super.initState();
  }

  addServiceIntoList() {
    if (widget.serviceDetails.length < 5) {
      widget.serviceDetails.add(new ServiceDetails("", "0.00"));
    } else {
      final snackBar =
          SnackBar(content: Text('Cannot Add More Than 5 Services !'));
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      onChanged: () {
        formKey.currentState.save();
      },
      child: Column(
        children: [
          titleWithAddButton(),
          Container(
            padding: EdgeInsets.only(left: 15, right: 15),
            margin: EdgeInsets.only(top: 15),
            height: 340,
            color: Colors.blueGrey[100],
            child: widget.serviceDetails.length == 0
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "No Service List To Display",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Click on Plus Icon (+) to add new services",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: widget.serviceDetails.length,
                    itemBuilder: (BuildContext context, int index) =>
                        addServiceItem(index, widget.serviceDetails[index]),
                  ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget addServiceItem(int index, ServiceDetails serviceDetail) {
    return Dismissible(
      key: Key(serviceDetail.serviceId.toString()),
      onDismissed: (direction) {
        setState(() {
          widget.serviceDetails.removeAt(index);
        });
      },
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Container(
              width: 30,
              height: 30,
              decoration: new BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              child: Center(
                  child: Text(
                (index + 1).toString(),
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              )),
            ),
          ),
          Expanded(
            flex: 2,
            child:
            TextFormField(
              controller: serviceDetail.serviceNameTxtCtrl,
              maxLength: 20,
              decoration: InputDecoration(labelText: "Service Name"),
              validator: (String value) {
                return value.isEmpty ? 'Service Name ${(index + 1).toString()} is Required' : null;
              },
              onSaved: (String value) {
                serviceDetail.serviceName = value;
                serviceDetail.serviceNameTxtCtrl.text = serviceDetail.serviceName;
              },
            ),
          ),
          SizedBox(
            width: 10,
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 22.5),
              child: TextFormField(
                  controller: serviceDetail.nettPriceTxtCtrl,
                  inputFormatters: [
                     FilteringTextInputFormatter.allow(RegExp('^\$|^(0|([1-9][0-9]{0,}))(\\.[0-9]{0,})?\$')),
                  ],
                  decoration: InputDecoration(labelText: "Price"),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  onSaved: (String value) {
                    //only parse when the value is valid to parse
                    serviceDetail.nettPrice = value;
                    serviceDetail.nettPriceTxtCtrl.text = serviceDetail.nettPrice;
                }
              ),
            ),
          ),
        ],
      ),
    );
  }

  Row titleWithAddButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Service Detail",
              textAlign: TextAlign.left,
              style: TextStyle(
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.grey.shade700,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 5, top: 5),
          child: CircleAvatar(
            radius: 13,
            backgroundColor: Colors.blue,
            child: IconButton(
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
                icon: const Icon(Icons.add),
                color: Colors.black,
                tooltip: 'Add New Service',
                onPressed: () {
                  setState(() {
                    addServiceIntoList();
                  });
                }),
          ),
        ),
      ],
    );
  }
}
