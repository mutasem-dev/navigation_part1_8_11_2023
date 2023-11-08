import 'product.dart';

class Invoice {
  int invoiceNO;
  String customerName;
  List<Product> products;

  Invoice(this.invoiceNO, this.customerName, this.products);

}