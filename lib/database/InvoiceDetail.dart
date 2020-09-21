class InvoiceDetail {

}

class ServiceDetail {
  static int serviceIdCounter = 0;
  int _serviceId;
  String serviceName;
  double nettPrice;

  ServiceDetail(this.serviceName, this.nettPrice) {
    _serviceId = incrementServiceIdCounter();
  }

  incrementServiceIdCounter() {
    return serviceIdCounter += 1;
  }

  int get serviceId => _serviceId;
}