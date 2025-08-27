// import 'package:e_commerce_task/models/product_model.dart';
// import 'package:flutter/material.dart';

// class ProductCard extends StatelessWidget {
//   final ProductModel product;
//   final VoidCallback onAddToCart;

//   const ProductCard({
//     super.key,
//     required this.product,
//     required this.onAddToCart,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//             Expanded(child: Image.network(product.image!,fit: BoxFit.cover,width: double.infinity,),),
//             Padding(padding: const EdgeInsets.all(8),
//             child: Text(product.name!,style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),),),
//             Padding(padding: const EdgeInsets.symmetric(horizontal: 8),
//             child: Text('₹${product.price!.toString()}'),),
//             Padding(padding: const EdgeInsets.all(8),
//             child: ElevatedButton(onPressed: onAddToCart, child: Text('Add to cart')),)
//         ],
//         ),
//     );
//   }
// }

import 'package:e_commerce_task/models/product_model.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  final VoidCallback onAddToCart;

  const ProductCard({
    super.key,
    required this.product,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 120,
            width: 200,

            child: Padding(
              padding: EdgeInsetsGeometry.symmetric(
                vertical: 10,
                horizontal: 5,
              ),
              child: Image.network(product.image ?? "", fit: BoxFit.cover),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name ?? "No name",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  "₹${product.price ?? "0.00"}",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Colors.teal,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: onAddToCart,
                    icon: const Icon(Icons.add_shopping_cart, size: 18),
                    label: const Text("Add to Cart"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 3,
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
