import 'dart:convert';
import 'package:ecommerce_app_api_26/core/api/end_points.dart';
import 'package:ecommerce_app_api_26/features/categories/models/category_model.dart';
import 'package:http/http.dart' as http;

class CategoryApi {
  Future<List<CategoryModel>> getAllcategories() async {
    Uri url = Uri.parse(EndPoints.baseUrl + EndPoints.categories);
    var response = await http.get(url);

    var json = jsonDecode(response.body) as List;
    List<CategoryModel> products = json.map((ele) {
      return CategoryModel.fromJson(ele);
    }).toList();
    return products;
  }
}
