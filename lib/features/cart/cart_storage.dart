// import 'dart:convert';

// import 'package:ecommerce_app_api_26/features/home/models/products_model.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class CartStorage {
//   static const String key = "cart";

//   /// Add to cart
//   static Future<void> addToCart(ProductsModel product) async {

//     final prefs = await SharedPreferences.getInstance();
//     List<String> cart = prefs.getStringList(key) ?? [];
//     List<Map<String, dynamic>> items = cart
//         .map((e) => jsonDecode(e) as Map<String, dynamic>)
//         .toList();

  

//     await prefs.setStringList(key, items.map((e) => jsonEncode(e)).toList());

//   }

//   /// get cart product
//   static Future<List<ProductsModel>> getCartProducts() async {
//     final prefs = await SharedPreferences.getInstance();
//     List<String> cart = prefs.getStringList(key) ?? [];
//     return cart.map((item) {
//       final json = jsonDecode(item) as Map<String, dynamic>;
//       return ProductsModel.fromJson(json);
//     }).toList();
//   }

//   /// remove product
//   static Future<void> removeProduct(int productId) async {
//     final prefs = await SharedPreferences.getInstance();
//     List<String> cart = prefs.getStringList(key) ?? [];
//     cart.removeWhere((item) {
//       final product = ProductsModel.fromJson(jsonDecode(item));
//       return product.id == productId;
//     });
//     await prefs.setStringList(key, cart);
//   }

//   /// increase quantity
//   // static Future<void> increaseQuantity(int productId) async {
//   //   final prefs = await SharedPreferences.getInstance();
//   //   List<String> cart = prefs.getStringList(key) ?? [];
//   //   List<Map<String, dynamic>> items = List<Map<String, dynamic>>.from(
//   //     cart.map((e) => jsonDecode(e) as Map<String, dynamic>),
//   //   );
//   //   for (var item in items) {
//   //     if (item['id'] == productId) {
//   //       item['quantity'] = (item['quantity'] ?? 1) + 1;
//   //     }
//   //   }
//   //   await prefs.setStringList(key, items.map((e) => jsonEncode(e)).toList());
//   // }

//   /// decrease quantity
//   // static Future<void> decreaseQuantity(int productId) async {
//   //   final prefs = await SharedPreferences.getInstance();
//   //   List<String> cart = prefs.getStringList(key) ?? [];
//   //   List<Map<String, dynamic>> items = List<Map<String, dynamic>>.from(
//   //     cart.map((e) => jsonDecode(e) as Map<String, dynamic>),
//   //   );
//   //   for (var item in items) {
//   //     if (item['id'] == productId) {
//   //       int quantity = (item['quantity'] ?? 1);

//   //       if (quantity > 1) {
//   //         item['quantity'] = quantity - 1;
//   //       }
//   //     }
//   //   }
//   //   await prefs.setStringList(key, items.map((e) => jsonEncode(e)).toList());
//   // }
// }

//   // int index = items.indexWhere((item) => item['id'] == product.id);
//     // if (index != -1) {
//     //   items[index]['quantity'] = (items[index]['quantity'] ?? 1) + 1;
//     // } 
//     // else {
//     //   Map<String, dynamic> item = product.toJson();
//     //   item['quantity'] = 1;
//     //   items.add(item);
//     // }


import 'dart:convert';

import 'package:ecommerce_app_api_26/features/home/models/card_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartStorage {
  static const String key = "cart";

  /// Add To Cart
  static Future<void> addToCart(CartModel product) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> cart = prefs.getStringList(key) ?? [];
    List<CartModel> items = cart
        .map((e) => CartModel.fromJson(jsonDecode(e)))
        .toList();
    bool found = false;
    for (var item in items) {
      if (item.id == product.id) {
        item.quantity++;
        found = true;
        break;
      }
    }
    if (!found) {
      items.add(product);
    }
    await prefs.setStringList(
      key,
      items.map((e) => jsonEncode(e.toJson())).toList(),
    );
  }

  /// Get Cart Products
  static Future<List<CartModel>> getCartProducts() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> cart = prefs.getStringList(key) ?? [];
    return cart
        .map((e) => CartModel.fromJson(jsonDecode(e)))
        .toList();
  }

  /// Increase Quantity
  static Future<void> increaseQuantity(int productId) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> cart = prefs.getStringList(key) ?? [];
    List<CartModel> items = cart
        .map((e) => CartModel.fromJson(jsonDecode(e)))
        .toList();

    for (var item in items) {
      if (item.id == productId) {
        item.quantity++;
        break;
      }
    }

    await prefs.setStringList(
      key,
      items.map((e) => jsonEncode(e.toJson())).toList(),
    );
  }

  /// Decrease Quantity
  static Future<void> decreaseQuantity(int productId) async {
    final prefs = await SharedPreferences.getInstance();

    List<String> cart = prefs.getStringList(key) ?? [];

    List<CartModel> items = cart
        .map((e) => CartModel.fromJson(jsonDecode(e)))
        .toList();

    for (var item in items) {
      if (item.id == productId) {
        item.quantity--;

        if (item.quantity <= 0) {
          items.remove(item);
        }

        break;
      }
    }

    await prefs.setStringList(
      key,
      items.map((e) => jsonEncode(e.toJson())).toList(),
    );
  }

  /// Remove Product
  static Future<void> removeProduct(int productId) async {
    final prefs = await SharedPreferences.getInstance();

    List<String> cart = prefs.getStringList(key) ?? [];

    cart.removeWhere((item) {
      final product = CartModel.fromJson(
        jsonDecode(item),
      );

      return product.id == productId;
    });

    await prefs.setStringList(key, cart);
  }

  /// Clear Cart
  static Future<void> clearCart() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(key);
  }
}