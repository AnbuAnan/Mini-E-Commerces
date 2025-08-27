import 'package:e_commerce_task/models/cart_item_model.dart';
import 'package:flutter/material.dart';

class CartItemTitle extends StatelessWidget {
  final CartItemModel item;
  final VoidCallback onIncrease;
  final VoidCallback ondecrease;
  final VoidCallback onRemove;

  const CartItemTitle({
    super.key,
    required this.item,
    required this.onIncrease,
    required this.ondecrease,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(item.image!, width: 50, height: 50),
      title: Text(
        item.name!,
        style: Theme.of(context).textTheme.bodyMedium,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        'Qty: ${item.quantity} | ₹${(item.price! * item.quantity!).toStringAsFixed(2)}',
        style: Theme.of(
          context,
        ).textTheme.bodyMedium!.copyWith(color: Colors.black54),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(onPressed: ondecrease, icon: Icon(Icons.remove)),
          IconButton(onPressed: onIncrease, icon: Icon(Icons.add)),
          IconButton(
            onPressed: onRemove,
            icon: Icon(Icons.delete, color: Colors.red),
          ),
        ],
      ),
    );
  }
}
