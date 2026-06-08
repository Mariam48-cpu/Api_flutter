import 'package:ecommerce_app_api_26/features/cart/cart_storage.dart';
import 'package:ecommerce_app_api_26/features/home/models/products_model.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<ProductsModel> cartItems = [];
  bool isLoading = true;

  Future<void> getCart() async {
    cartItems = await CartStorage.getCartProducts();
    setState(() {
      isLoading = false;
    });
  }

  double totalPrice() {
    double total = 0;
    for (var item in cartItems) {
      total += (item.price ?? 0) * (item.quantity ?? 1);
    }
    return total;
  }

  @override
  void initState() {
    super.initState();
    getCart();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (cartItems.isEmpty) {
      return const Scaffold(body: Center(child: Text("Cart is empty")));
    }
    return Scaffold(
      appBar: AppBar(title: const Text("My Cart")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final product = cartItems[index];

                return ListTile(
                  leading: Image.network(product.images?.first ?? ''),
                  title: Text(product.title ?? ''),
                  subtitle: Text("${product.price ?? 0} EGP"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildQtyBtn(Icons.remove, () async {
                        await CartStorage.decreaseQuantity(product.id!);
                        await getCart();
                      }),

                      SizedBox(width: 8),

                      Text("${product.quantity ?? 1}"),

                      SizedBox(width: 8),

                      _buildQtyBtn(Icons.add, () async {
                        await CartStorage.increaseQuantity(product.id!);
                        await getCart();
                      }),

                      SizedBox(width: 8),

                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () async {
                          await CartStorage.removeProduct(product.id!);
                          await getCart();
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Total:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  "${totalPrice()} EGP",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQtyBtn(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 18, color: Colors.black),
      ),
    );
  }
}
