class Product {
  String name;
  double price;
  int quantity;

  Product(this.name, this.price, this.quantity);

  @override
  String toString() {
    return '$name, price: $price, quantity: $quantity';
  }
}