import 'package:group_exito/core/models/exceptions/exceptions.dart';
import 'package:group_exito/core/models/result.dart';
import 'package:group_exito/ui/feature/home/data/data_source/product/product_data_source.dart';
import 'package:group_exito/ui/feature/home/data/models/product_response.dart';
import 'package:group_exito/ui/feature/home/domain/repository/product/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  ProductRepositoryImpl({required ProductDataSource dataSource}) : _dataSource = dataSource;

  final ProductDataSource _dataSource;

  @override
  Future<Result<List<ProductResponse>>> getProductsByCategory(int categoryId) async {
    try {
      final List<ProductResponse> products = await _dataSource.getProductsByCategory(categoryId);
      return SuccessfulResult<List<ProductResponse>>(products, 200);
    } catch (e) {
      return FailureResult<List<ProductResponse>>(e is HandledException ? e : Exception(e.toString()), 500);
    }
  }
}
