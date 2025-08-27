class CartItemModel {
  String? id;
  String? name;
  String? image;
  double? price;
  int? quantity;

  CartItemModel({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    this.quantity = 1,
  });

  CartItemModel copyWith({
    String? id,
    String? name,
    double? price,
    String? image,
    int? quantity,
  }) {
    return CartItemModel(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      image:  image ?? this.image,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'image': image,
    'price': price,
    'quantity': quantity ?? 'null',
  };

  factory CartItemModel.fromMap(Map<String, dynamic> map) {
    return CartItemModel(
      id: map['id'],
      name: map['name'],
      image: map['image'],
      price: (map['price'] as num).toDouble(),
      quantity: map['quantity'] ?? 'null',
    );
  }
}
