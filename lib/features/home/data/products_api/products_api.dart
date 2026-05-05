import 'dart:convert';

import 'package:ecommerce_app_api_26/core/api/end_points.dart';
import 'package:ecommerce_app_api_26/features/home/models/products_model.dart';
import 'package:http/http.dart' as http;

class ProductsApi {
  Future<List<ProductsModel?>> getAllProducts() async {
    Uri url = Uri.parse(EndPoints.baseUrl + EndPoints.products);
    var response = await http.get(url);

    var json = jsonDecode(response.body) as List;
    List<ProductsModel> products = json.map((ele) {
      return ProductsModel.fromJson(ele);
    }).toList();
    return products;
  }

    Future<List<ProductsModel?>> getCategoryById(int categoryId) async {
    Uri url = Uri.parse(EndPoints.baseUrl + EndPoints.products +"?categoryId=$categoryId");
    var response = await http.get(url);

    var json = jsonDecode(response.body) as List;
    List<ProductsModel> products = json.map((ele) {
      return ProductsModel.fromJson(ele);
    }).toList();
    return products;
  }

  
}
