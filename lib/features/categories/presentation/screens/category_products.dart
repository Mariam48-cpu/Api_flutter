import 'package:ecommerce_app_api_26/features/home/data/products_api/products_api.dart';
import 'package:ecommerce_app_api_26/features/home/models/products_model.dart';
import 'package:ecommerce_app_api_26/features/home/presentation/widgets/product_card.dart';
import 'package:flutter/material.dart';

class CategoryProducts extends StatelessWidget {
  const CategoryProducts({super.key, required this.categoryId});
  final int categoryId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: ProductsApi().getCategoryById(categoryId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError || snapshot.data == null) {
              return const Center(child: Text("Error"));
            }
            final products = snapshot.data as List<ProductsModel>?;
            if (products == null) {
              return const Center(child: Text("Error"));
            }
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return ProductCard(product: product);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
