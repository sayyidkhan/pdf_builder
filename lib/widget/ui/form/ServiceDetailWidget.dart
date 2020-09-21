import 'package:flutter/material.dart';
import 'package:pdf_test/IOopertions/InvoiceDetail.dart';
import 'package:pdf_test/widget/ui/sharedcomponents/DecimalTextInputFormatter.dart';
import 'package:pdf_test/widget/ui/sharedcomponents/FormSharedComponentWidget.dart';

class NewServiceDetailWidget extends StatefulWidget {
  @override
  _NewServiceDetailWidgetState createState() => _NewServiceDetailWidgetState();
}

class _NewServiceDetailWidgetState extends State<NewServiceDetailWidget> {
  final List<ServiceDetail> serviceDetailList = new List();
  final serviceIdCounter = 0;
  final double _gstRate = 0.00;

  @override
  void initState() {
    super.initState();
    serviceDetailList.add(ServiceDetail("init", 0.00));
  }

  addServiceIntoList() {
    if (serviceDetailList.length < 5) {
      serviceDetailList.add(new ServiceDetail("", 0.00));
    } else {
      final snackBar =
          SnackBar(content: Text('Cannot Add More Than 5 Services !'));
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        titleWithAddButton(),
        Container(
          padding: EdgeInsets.only(left: 15, right: 15),
          margin: EdgeInsets.only(top: 15),
          height: 340,
          color: Colors.blueGrey[100],
          child: ListView.builder(
            itemCount: serviceDetailList.length,
            itemBuilder: (BuildContext context, int index) => addServiceItem(index, serviceDetailList[index]),
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Widget addServiceItem(int index, ServiceDetail serviceDetail) {
    return Dismissible(
      key: Key(serviceDetail.serviceId.toString()),
      onDismissed: (direction) {
        setState(() {
          serviceDetailList.removeAt(index);
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
            child: FormSharedComponentWidget.buildTextField(
              labelText: "Service Name",
              textFieldMaxLength: 20,
              errorMessage: 'Service Name is Required',
              inputValue: serviceDetail.serviceName,
              validationRequired: true,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: buildPriceField(
              labelText: "Price",
              errorMessage: 'Price Field Cannot Be Empty',
              inputValue: serviceDetail.nettPrice,
              validationRequired: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPriceField({
    String labelText,
    String errorMessage,
    Object inputValue,
    bool validationRequired = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 22.5),
      child: TextFormField(
        initialValue: "0.00",
        decoration: InputDecoration(labelText: labelText),
        inputFormatters: [DecimalTextInputFormatter(decimalRange: 2)],
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        onSaved: (String value) {
          if (validationRequired) {
            return value.isEmpty ? errorMessage : null;
          }
          inputValue = value;
        },
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
