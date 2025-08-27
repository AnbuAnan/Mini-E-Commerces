import 'dart:convert';

import 'package:e_commerce_task/models/cart_item_model.dart';
import 'package:e_commerce_task/models/order_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderViewModel extends StateNotifier<List<OrderModel>> {
  OrderViewModel() : super([]) {
    loadOrders();
  }

  Future<void> loadOrders() async {
    final prefs = await SharedPreferences.getInstance();
    final ordersJson = prefs.getString('orders');
    if (ordersJson != null) {
      final decoded = json.decode(ordersJson) as List;
      state = decoded.map((e) => OrderModel.fromMap(e)).toList();
    }
  }

  Future<void> saveOrders() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      'orders',
      json.encode(state.map((e) => e.toMap()).toList()),
    );
  }

  Future<void> addOrder(List<CartItemModel> items, double total) async {
    final order = OrderModel(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      items: items,
      total: total,
      date: DateTime.now(),
    );
    state = [...state, order];
    await saveOrders();
  }
}

final orderViewModelProvider =
    StateNotifierProvider<OrderViewModel, List<OrderModel>>((ref) {
      return OrderViewModel();
    });
