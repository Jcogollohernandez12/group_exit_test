import 'package:group_exito/core/models/result.dart';
import 'package:group_exito/ui/feature/home/data/models/category_response.dart';

abstract class CategoryRepository {
  Future<Result<List<CategoryResponse>>> getCategories();
}
