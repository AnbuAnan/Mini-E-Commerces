import 'package:e_commerce_task/models/cart_item_model.dart';
import 'package:e_commerce_task/view_models/cart_view_model.dart';
import 'package:e_commerce_task/view_models/product_view_model.dart';
import 'package:e_commerce_task/views/cart_view.dart';
import 'package:e_commerce_task/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductView extends ConsumerWidget {
  const ProductView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productState = ref.watch(productViewModelProvider);
    final cartAction = ref.watch(cartViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Products',
          style: Theme.of(
            context,
          ).textTheme.titleLarge!.copyWith(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (context) => const CartView()));
            },
            icon: const Icon(Icons.shopping_cart),
          ),
        ],
      ),
      body: productState.when(
        data: (products) => GridView.builder(
          padding: const EdgeInsets.all(10),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return ProductCard(
              product: product,
              onAddToCart: () => cartAction.addToCart(
                CartItemModel(
                  id: product.id,
                  name: product.name,
                  price: double.parse(product.price!),
                  image: product.image,
                ),
              ),
            );
          },
        ),
        error: (err, _) => Center(
          child: Text(
            'Error: ${err.toString()}',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium!.copyWith(color: Colors.red),
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
