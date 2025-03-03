import 'dart:convert';
import 'dart:developer';
import 'package:fmart/models/modelsApi.dart';
import 'package:http/http.dart' as http;

class ProductsApiService {
  Future<ProductApiModels?> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse('https://fakestoreapi.com/products'));

      log("API Status Code: ${response.statusCode}");
      log("API Response: ${response.body}");

      if (response.statusCode == 200) {
        List<dynamic> responseData = json.decode(response.body);
        return ProductApiModels.fromJson(responseData);
      } else {
        log("API Error: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      log("Exception: $e");
      return null;
    }
  }

  
}
