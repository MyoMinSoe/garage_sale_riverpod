import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../model/product_model.dart';

part 'product_provider.g.dart';

// without Generate riverpod //
// final productProvider = Provider<List<Product>>((ref) {
//   return allProducts;
// });

// final reducedProducts = Provider<List<Product>>((ref) {
//   return allProducts.where((element) => element.price < 50).toList();
// });

// Generate riverpod //
@riverpod
List<Product> products(ref) {
  return allProducts;
}

@riverpod
List<Product> reducedProduct(ref) {
  return allProducts.where((element) => element.price < 50).toList();
}
