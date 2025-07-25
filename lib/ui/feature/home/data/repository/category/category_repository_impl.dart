import 'package:group_exito/core/models/exceptions/exceptions.dart';
import 'package:group_exito/core/models/result.dart';
import 'package:group_exito/ui/feature/home/data/data_source/category/category_data_source.dart';
import 'package:group_exito/ui/feature/home/data/models/category_response.dart';
import 'package:group_exito/ui/feature/home/domain/repository/category/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  CategoryRepositoryImpl({required CategoryDataSource dataSource}) : _dataSource = dataSource;

  final CategoryDataSource _dataSource;

  @override
  Future<Result<List<CategoryResponse>>> getCategories() async {
    try {
      final List<CategoryResponse> categories = await _dataSource.getCategories();
      return SuccessfulResult<List<CategoryResponse>>(categories, 200);
    } catch (e) {
      return FailureResult<List<CategoryResponse>>(e is HandledException ? e : Exception(e.toString()), 500);
    }
  }
}
