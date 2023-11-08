import 'package:flutter/material.dart';

import 'invoice.dart';
import 'product.dart';

void main() {
  runApp(const MyApp());
}

TextEditingController customerNameController = TextEditingController();
TextEditingController productNameController = TextEditingController();
TextEditingController quantityController = TextEditingController();
TextEditingController priceController = TextEditingController();
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
  MainPage({super.key});
  final List<Invoice> invoices = [];
}

class _MainPageState extends State<MainPage> {
  static int invNo = 1;
  List<Product> products = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Invoice# $invNo'),
      ),
      body: Column(
        children: [
          TextField(
            controller: customerNameController,
            decoration: InputDecoration(
              labelText: 'Customer Name',
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Products:', style: TextStyle(fontSize: 24),),
              ElevatedButton(
                  onPressed: () {
                    //products = [];
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Product info:',style: TextStyle(fontSize: 24),),
                          content: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextField(
                                  controller: productNameController,
                                  decoration: InputDecoration(
                                    labelText: 'product Name',
                                  ),
                                ),
                                TextField(
                                  keyboardType: TextInputType.number,
                                  controller: quantityController,
                                  decoration: InputDecoration(
                                    labelText: 'Quantity',
                                  ),
                                ),
                                TextField(
                                  keyboardType: TextInputType.number,
                                  controller: priceController,
                                  decoration: InputDecoration(
                                    labelText: 'Price',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          actions: [
                            ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    Product prd = Product(
                                        productNameController.text,
                                        double.parse(priceController.text),
                                        int.parse(quantityController.text)
                                    );
                                    products.add(prd);
                                    productNameController.clear();
                                    priceController.clear();
                                    quantityController.clear();
                                  });
                                  Navigator.of(context).pop();
                                },
                                child: Text('add'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('cancel'),
                            ),
                          ],
                        ),
                    );
                  },
                  child: Text('add product'),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ListTile(
                    tileColor: Colors.blue,
                    leading: Text(products[index].name, style: TextStyle(fontSize: 30),),
                    title: Text('price: ${products[index].price}'),
                    subtitle: Text('quantity: ${products[index].quantity}'),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {

                      },
                    ),
                  ),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    Invoice inv = Invoice(
                        invNo,
                        customerNameController.text,
                        products
                    );
                    products = [];
                    invNo++;
                    customerNameController.clear();
                    widget.invoices.add(inv);
                  });
                },
                child: Text('add invoice'),
              ),
              ElevatedButton(
                onPressed: () {

                },
                child: Text('show all invoices'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}



