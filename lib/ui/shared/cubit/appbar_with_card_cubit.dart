import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_exito/ui/feature/home/data/models/product_response.dart';

class CartCubit extends Cubit<List<ProductResponse>> {
  Map<ProductResponse, int> getGroupedProducts() {
    final Map<int, ProductResponse> uniqueProducts = <int, ProductResponse>{};
    final Map<int, int> productCounts = <int, int>{};
    for (final ProductResponse p in state) {
      uniqueProducts[p.id] = p;
      productCounts[p.id] = (productCounts[p.id] ?? 0) + 1;
    }
    final Map<ProductResponse, int> result = <ProductResponse, int>{};
    for (final int id in uniqueProducts.keys) {
      result[uniqueProducts[id]!] = productCounts[id]!;
    }
    return result;
  }

  int getProductCount(int productId) {
    return state.where((ProductResponse p) => p.id == productId).length;
  }

  CartCubit() : super(<ProductResponse>[]);

  void addProduct(ProductResponse product) {
    final List<ProductResponse> updated = List<ProductResponse>.from(state);
    updated.add(product);
    emit(updated);
  }

  void removeProduct(ProductResponse product) {
    final List<ProductResponse> updated = List<ProductResponse>.from(state);
    updated.remove(product);
    emit(updated);
  }

  void clear() => emit(<ProductResponse>[]);

  int get count => state.length;
}
