// main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart_provider.dart';
import 'product_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: MaterialApp(
        home: LaunchScreen(),
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black),
          ),
        ),
      ),
    );
  }
}

class LaunchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CartScreen()));
            },
          ),
        ],
      ),
      body: ProductList(),
    );
  }
}

class ProductList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Product> products = [
      Product(
          image: 'assets/product1.jpg', name: 'Iphonemini', price: 1999),
      Product(
          image: 'assets/product2.jpg',
          name: 'iphone12',
          price: 10999),
      Product(
          image: 'assets/product3.jpg',
          name: 'iphone12 pro',
          price: 13999),
      Product(
          image: 'assets/product4.jpg', name: 'Google Pixel 8', price: 9999),
      Product(image: 'assets/product5.jpg', name: 'iphone13 pro', price: 8999),
      Product(image: 'assets/product6.jpg', name: 'google pixel 7', price: 8999),
      Product(
          image: 'assets/product7.jpg', name: 'Samsung m51', price: 5999),
      Product(image: 'assets/product8.jpg', name: 'Samsung m31', price: 99),
      Product(
          image: 'assets/product9.jpg',
          name: 'Iphone 14 Pro Max',
          price: 19999),
      Product(
          image: 'assets/product10.jpg',
          name: 'Mototola Moto E5 Plus',
          price: 3999),
    ];

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Center(
              child: Text(
                'Phones',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                Product product = products[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 2,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        product.image,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(
                      product.name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
                    trailing: IconButton(
                      icon: product.addedToCart
                          ? Icon(Icons.check, color: Colors.green)
                          : Icon(Icons.add_shopping_cart),
                      onPressed: () {
                        CartProvider cartProvider =
                            Provider.of<CartProvider>(context, listen: false);
                        if (product.addedToCart) {
                          cartProvider.removeFromCart(product);
                        } else {
                          cartProvider.addToCart(product);
                        }
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}



class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    List<Product> cartItems = cartProvider.cartItems;

    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'),
      ),
      body: ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          Product product = cartItems[index];
          return Card(
            elevation: 2,
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              contentPadding: EdgeInsets.all(16),
              leading: Image.asset(
                product.image,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
              title: Text(
                product.name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
              trailing: IconButton(
                icon: Icon(Icons.remove_shopping_cart),
                onPressed: () {
                  cartProvider.removeFromCart(product);
                },
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Total: \$${cartProvider.totalCartPrice.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                cartProvider.clearCart();
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
              ),
              child: Text(
                'BUY',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



