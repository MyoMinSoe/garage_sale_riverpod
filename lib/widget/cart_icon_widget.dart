import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_garage_sale_app/page/cart_page.dart';
import 'package:riverpod_garage_sale_app/provider/cart_provider.dart';

class CartIconWidget extends ConsumerWidget {
  const CartIconWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showCircle = ref.watch(cartNotifierProvider).toList();
    return Stack(
      children: [
        IconButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const CartPage(),
              ),
            );
          },
          icon: const Icon(
            Icons.shopping_bag_outlined,
            size: 40,
            color: Colors.white,
          ),
        ),
        if (showCircle.isNotEmpty)
          Positioned(
            top: 3,
            left: 3,
            child: Container(
              width: 20,
              height: 20,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: Colors.pink,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Text(showCircle.length.toString()),
            ),
          ),
      ],
    );
  }
}
