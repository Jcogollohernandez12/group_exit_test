import 'package:group_exito/core/usecases/use_cases.dart';
import 'package:group_exito/ui/feature/home/data/models/product_response.dart';
import 'package:group_exito/ui/feature/home/domain/repository/product/product_repository.dart';

class GetProductsByCategoryUseCase extends UseCaseWithParams<List<ProductResponse>, int> {
  final ProductRepository _productRepository;

  GetProductsByCategoryUseCase({required ProductRepository productRepository}) : _productRepository = productRepository;

  @override
  ResultFuture<List<ProductResponse>> call(int params) {
    return _productRepository.getProductsByCategory(params);
  }
}
