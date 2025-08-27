import 'package:e_commerce_task/models/cart_item_model.dart';

class OrderModel {
  String? id;
  List<CartItemModel>? items;
  double? total;
  DateTime? date;

  OrderModel({
    required this.id,
    required this.items,
    required this.total,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'total': total,
      'date': date.toString(),
      'items': items!.map((e) => e.toMap()).toList(),
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'],
      items: List<Map<String, dynamic>>.from(
        map['items'],
      ).map((e) => CartItemModel.fromMap(e)).toList(),
      total: map['total'],
      date: map['date'],
    );
  }
}
