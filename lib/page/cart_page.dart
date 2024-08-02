import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/product_model.dart';
import '../provider/cart_provider.dart';

class CartPage extends ConsumerStatefulWidget {
  const CartPage({super.key});

  @override
  ConsumerState<CartPage> createState() => _CartPageState();
}

class _CartPageState extends ConsumerState<CartPage> {
  @override
  Widget build(BuildContext context) {
    final cartProductProvider =
        ref.watch<Set<Product>>(cartNotifierProvider).toList();
    final cartTotal = ref.watch(cartTotalPriceProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Theme.of(context).secondaryHeaderColor,
        title: const Text('Your Cart'),
        // centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Column(
              children: cartProductProvider.map((products) {
                return Container(
                  padding: const EdgeInsets.only(
                      left: 10, right: 30, top: 10, bottom: 10),
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.2),
                      borderRadius: BorderRadius.circular(6)),
                  child: Row(
                    children: [
                      Image.asset(
                        products.image,
                        width: 50,
                        height: 50,
                      ),
                      const SizedBox(width: 10),
                      Text(products.title),
                      const Spacer(),
                      Text('£${products.price}'),
                    ],
                  ),
                );
              }).toList(),
            ),
            if (cartTotal != 0)
              Container(
                margin: const EdgeInsets.only(top: 5, bottom: 15),
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 30,
                  top: 30,
                  bottom: 30,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Price : ',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.onSecondary),
                    ),
                    Text(
                      '£$cartTotal',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.onSecondary),
                    ),
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}
