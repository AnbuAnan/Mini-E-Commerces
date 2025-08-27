import 'package:e_commerce_task/models/product_model.dart';
import 'package:e_commerce_task/services/product_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productViewModelProvider = FutureProvider<List<ProductModel>>((
  ref,
) async {
  return ProductService().fetchProducts();
});

