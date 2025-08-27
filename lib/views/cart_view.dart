import 'package:e_commerce_task/view_models/cart_view_model.dart';
import 'package:e_commerce_task/views/checkout_view.dart';
import 'package:e_commerce_task/views/order_view.dart';
import 'package:e_commerce_task/widgets/cart_item_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartView extends ConsumerWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartState = ref.watch(cartViewModelProvider);
    final cartAction = ref.read(cartViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'cart',
          style: Theme.of(
            context,
          ).textTheme.titleLarge!.copyWith(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
        iconTheme: IconThemeData(color: Colors.white70),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const OrderView()),
              );
            },
            icon: const Icon(Icons.shopping_cart_checkout_rounded),
          ),
        ],
      ),
      body: cartState.isEmpty
          ?  Center(child: Text("Your cart is Empty",style: Theme.of(context).textTheme.bodyMedium))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartState.length,
                    itemBuilder: (context, index) {
                      final item = cartState[index];
                      return CartItemTitle(
                        item: item,
                        onIncrease: () => cartAction.increaseQuantity(item.id!),
                        ondecrease: () => cartAction.decreaseQuantity(item.id!),
                        onRemove: () => cartAction.removeFromCart(item.id!),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Total: ',
                              style: Theme.of(context).textTheme.bodyMedium!
                                  .copyWith(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey[700],
                                    letterSpacing: 1,
                                  ),
                            ),
                            TextSpan(
                              text:
                                  '₹${cartAction.totalPrice.toStringAsFixed(2)}',
                              style: Theme.of(context).textTheme.bodyMedium!
                                  .copyWith(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.teal,
                                    letterSpacing: 1.2,
                                    
                                  ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => CheckoutView(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'proceed to checkout',
                            style: Theme.of(context).textTheme.labelLarge!
                                .copyWith(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
