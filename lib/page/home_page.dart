import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/product_model.dart';
import '../provider/cart_provider.dart';
import '../provider/product_provider.dart';
import '../widget/cart_icon_widget.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allProductProvider = ref.watch<List<Product>>(productsProvider);
    final cartProductProvider =
        ref.watch<Set<Product>>(cartNotifierProvider).toList();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Theme.of(context).secondaryHeaderColor,
        title: const Text(
          'Garage Sale Products',
        ),
        actions: const [
          CartIconWidget(),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              childAspectRatio: 0.9,
            ),
            itemCount: allProductProvider.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      allProductProvider[index].image,
                      width: 100,
                    ),
                    Text(allProductProvider[index].title),
                    Text('£${allProductProvider[index].price}'),
                    if (cartProductProvider.contains(allProductProvider[index]))
                      TextButton(
                        onPressed: () {
                          ref
                              .read(cartNotifierProvider.notifier)
                              .removeProduct(allProductProvider[index]);
                        },
                        child: const Text(
                          'Remove',
                          style: TextStyle(color: Colors.pink),
                        ),
                      ),
                    if (!cartProductProvider
                        .contains(allProductProvider[index]))
                      TextButton(
                        onPressed: () {
                          ref
                              .read(cartNotifierProvider.notifier)
                              .addProduct(allProductProvider[index]);
                        },
                        child: Text(
                          'Add to Cart',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
