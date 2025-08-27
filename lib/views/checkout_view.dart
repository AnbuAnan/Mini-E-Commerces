import 'package:e_commerce_task/view_models/cart_view_model.dart';
import 'package:e_commerce_task/view_models/order_view_model.dart';
import 'package:e_commerce_task/views/order_view.dart';
import 'package:e_commerce_task/widgets/icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CheckoutView extends ConsumerStatefulWidget {
  const CheckoutView({super.key});

  @override
  CheckoutViewState createState() => CheckoutViewState();
}

class CheckoutViewState extends ConsumerState<CheckoutView> {
  final TextEditingController _couponController = TextEditingController();
  String? _errorMessage;
  double? _discountedTotal;
  String? _appliedCode;

  double applyCoupon(String code, double total) {
    switch (code.toUpperCase()) {
      case 'DISCOUNT10':
        _appliedCode = code.toUpperCase();
        return total * 0.9;
      case 'DISCOUNT20':
        _appliedCode = code.toUpperCase();
        return total * 0.8;
      default:
        _appliedCode = null;
        _errorMessage = 'Invalid or expired coupon';
        return total;
    }
  }

  @override
  Widget build(BuildContext context) {
    final total = ref.watch(cartViewModelProvider.notifier).totalPrice;
    final cartState = ref.watch(cartViewModelProvider);
    final cartAction = ref.watch(cartViewModelProvider.notifier);
    final orderAction = ref.read(orderViewModelProvider.notifier);
    final finalAmount = _discountedTotal ?? total;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Checkout",
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
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GestureDetector(
          onTap: FocusScope.of(context).unfocus,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  margin: EdgeInsets.all(6),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Order Summary",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          height: 200,
                          child: ListView(
                            children: cartState
                                .map(
                                  (e) => ListTile(
                                    title: Text('${e.name}'),
                                    subtitle: Text(
                                      '${e.quantity} X ₹${e.price}',
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                        const SizedBox(height: 12),
                        if (_discountedTotal != null &&
                            _discountedTotal != total)
                          Row(
                            children: [
                              Text(
                                "₹${total.toStringAsFixed(2)}",
                                style: Theme.of(context).textTheme.bodyMedium!
                                    .copyWith(
                                      fontSize: 16,
                                      color: Colors.grey,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                "₹${finalAmount.toStringAsFixed(2)}",
                                style: Theme.of(context).textTheme.bodyMedium!
                                    .copyWith(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                    ),
                              ),
                            ],
                          )
                        else
                          Text(
                            "₹${total.toStringAsFixed(2)}",
                            style: Theme.of(context).textTheme.bodyMedium!
                                .copyWith(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                TextField(
                  controller: _couponController,
                  decoration: InputDecoration(
                    labelText: "Enter Coupon Code",
                    labelStyle: Theme.of(context).textTheme.bodyMedium!
                        .copyWith(fontSize: 18, color: Colors.black54),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        setState(() {
                          _couponController.clear();
                          _errorMessage = null;
                          _appliedCode = null;
                          _discountedTotal = null;
                        });
                      },
                    ),
                    errorText: _errorMessage,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 12),
                CustomIconButton(
                  label: 'Apply Coupon',
                  icon: Icons.local_offer,
                  onPressed: () {
                    setState(() {
                      _errorMessage = null;
                      _discountedTotal = applyCoupon(
                        _couponController.text.trim(),
                        total,
                      );
                    });
                  },
                ),
                if (_appliedCode != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      "Coupon $_appliedCode applied ",
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium!.copyWith(color: Colors.green),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.teal.shade50,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                "Final Amount: ₹${finalAmount.toStringAsFixed(2)}",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
            ),

            CustomIconButton(
              label: 'Place Order',
              icon: Icons.payment,
              onPressed: () async {
                FocusScope.of(context).unfocus();
                if (cartState.isEmpty) return;
                await orderAction.addOrder(cartState, total);
                cartAction.clearCart();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "Order placed successfully",
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium!.copyWith(color: Colors.white),
                    ),
                    backgroundColor: Colors.teal,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
