import 'package:group_exito/core/usecases/use_cases.dart';
import 'package:group_exito/ui/feature/home/data/models/category_response.dart';
import 'package:group_exito/ui/feature/home/domain/repository/category/category_repository.dart';

class GetAllCategoriesUseCase extends UseCaseWithoutParams<List<CategoryResponse>> {
  final CategoryRepository _categoryRepository;

  GetAllCategoriesUseCase({required CategoryRepository categoryRepository}) : _categoryRepository = categoryRepository;

  @override
  ResultFuture<List<CategoryResponse>> call() {
    return _categoryRepository.getCategories();
  }
}
