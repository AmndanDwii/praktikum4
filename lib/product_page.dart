import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart_model.dart';

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final List<Product> products = [
    Product(name: "Product 1", price: 10),
    Product(name: "Product 2", price: 20),
    Product(name: "Product 3", price: 30),
    Product(name: "Product 4", price: 40),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Page'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ProductListItem(product: products[index]);
        },
      ),
    );
  }
}

class Product {
  final String name;
  final int price;
  int quantity;

  Product({required this.name, required this.price, this.quantity = 0});
}

class ProductListItem extends StatelessWidget {
  final Product product;

  ProductListItem({required this.product});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartModel>(context);

    return ListTile(
      title: Text(product.name),
      subtitle: Text('\$${product.price}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.remove),
            onPressed: () {
              cart.remove(product);
            },
          ),
          Text(product.quantity.toString()),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              cart.addToCart(product);
            },
          ),
          ElevatedButton(
            onPressed: () {
              cart.addToCart(product);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${product.name} added to cart!'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: Text('Add to Cart'),
          ),
        ],
      ),
    );
  }
}
