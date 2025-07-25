import 'package:group_exito/core/models/result.dart';
import 'package:group_exito/ui/feature/home/data/models/product_response.dart';

abstract class ProductRepository {
  Future<Result<List<ProductResponse>>> getProductsByCategory(int categoryId);
}
