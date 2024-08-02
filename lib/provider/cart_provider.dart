import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../model/product_model.dart';

part 'cart_provider.g.dart';

@riverpod
class CartNotifier extends _$CartNotifier {
  @override
  Set<Product> build() {
    return const {};
  }

  // method to Update State
  void addProduct(Product product) {
    if (!state.contains(product)) {
      state = {...state, product};
    }
  }

  void removeProduct(Product product) {
    if (state.contains(product)) {
      state = state.where((p) => p.id != product.id).toSet();
    }
  }
}

@riverpod
int cartTotalPrice(ref) {
  final cartProducts = ref.watch(cartNotifierProvider);
  int total = 0;
  for (Product p in cartProducts) {
    total += p.price;
  }
  return total;
}
