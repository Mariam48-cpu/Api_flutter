import 'package:ecommerce_app_api_26/features/cart/cart_storage.dart';
import 'package:ecommerce_app_api_26/features/home/models/card_model.dart';
import 'package:ecommerce_app_api_26/features/home/models/products_model.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final ProductsModel product;

  const ProductCard({super.key, required this.product});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue.shade50, Colors.blue.shade100],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network(
                        product.images?.first ?? '',
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(
                              Icons.shopping_bag_outlined,
                              size: 40,
                              color: Colors.blue,
                            ),
                      ),
                    ),
                  ),
                  PositionBag(
                    top: 10,
                    right: 10,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.favorite_border,
                        size: 18,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title ?? '',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  product.description ?? '',
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${product.price ?? 0}',
                      style: const TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        await CartStorage.addToCart(
                          CartModel(
                            id: product.id!,
                            title: product.title!,
                            price: product.price!.toDouble(),
                            image: product.images?.first ?? '',
                            quantity: 1,
                            description: product.description ?? '',
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Added To Cart")),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PositionBag extends StatelessWidget {
  final double? top;
  final double? right;
  final Widget child;
  const PositionBag({super.key, this.top, this.right, required this.child});

  @override
  Widget build(BuildContext context) {
    return Positioned(top: top, right: right, child: child);
  }
}
