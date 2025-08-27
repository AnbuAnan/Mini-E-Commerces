import 'dart:convert';

import 'package:e_commerce_task/models/cart_item_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartViewModel extends StateNotifier<List<CartItemModel>> {
  CartViewModel() : super([]) {
    loadCart();
  }

  Future<void> loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    final cartJson = prefs.getString('cart');
    if (cartJson != null) {
      final decoded = json.decode(cartJson) as List;
      state = decoded.map((e) => CartItemModel.fromMap(e)).toList();
    }
  }

  Future<void> saveCart() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      'cart',
      json.encode(state.map((e) => e.toMap()).toList()),
    );
  }

  void addToCart(CartItemModel cartItem) {
    final index = state.indexWhere((item) => item.id == cartItem.id);
    if (index >= 0) {
      final updated = state[index].copyWith(
        quantity: state[index].quantity! + 1,
      );
      state = [...state]..[index] = updated;
    } else {
      state = [...state, cartItem];
    }
  }

  void removeFromCart(String productId) {
    state = state.where((item) => item.id != productId).toList();
  }

  void increaseQuantity(String productId) {
    state = state.map((item) {
      if (item.id == productId) {
        return item.copyWith(quantity: item.quantity! + 1);
      }
      return item;
    }).toList();
  }

  void decreaseQuantity(String productId) {
    state = state.map((item) {
      if (item.id == productId && item.quantity! > 1) {
        return item.copyWith(quantity: item.quantity! - 1);
      }
      return item;
    }).toList();
  }

  void clearCart() {
    state = [];
    saveCart();
  }

  double get totalPrice =>
      state.fold(0, (sum, item) => sum + (item.price! * item.quantity!));
}

final cartViewModelProvider =
    StateNotifierProvider<CartViewModel, List<CartItemModel>>((ref) {
      return CartViewModel();
    });
