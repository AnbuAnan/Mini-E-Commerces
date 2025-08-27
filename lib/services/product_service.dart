import 'dart:convert';

import 'package:e_commerce_task/models/product_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProductService {
  static const _cacheKey = 'product_cache';

  Future<List<ProductModel>> fetchProducts() async {
    try {
      final response = await http.get(
        Uri.parse(
          'https://68ad941fa0b85b2f2cf3dcf3.mockapi.io/api/v2/products',
        ),
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final products = data
            .map((product) => ProductModel.formJson(product))
            .toList();

        final prefs = await SharedPreferences.getInstance();
        prefs.setString(_cacheKey, json.encode(data));
        return products;
      } else {
        return _loadFromCache();
      }
    } catch (e) {
      if (kDebugMode) {
        print('Fetch api call error : ${e.toString()}');
      }
      return _loadFromCache();
    }
  }

  Future<List<ProductModel>> _loadFromCache() async {
    final prefs = await SharedPreferences.getInstance();
    final cached = prefs.getString(_cacheKey);

    if (cached != null) {
      final List<dynamic> products = json.decode(cached);
      return products.map((product) => ProductModel.formJson(product)).toList();
    }
    return [];
  }
}
