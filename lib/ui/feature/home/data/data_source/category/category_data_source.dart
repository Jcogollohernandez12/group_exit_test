import 'package:dio/dio.dart';
import 'package:group_exito/core/client/api_client.dart';
import 'package:group_exito/core/models/exceptions/exceptions.dart';
import 'package:group_exito/ui/feature/home/data/models/category_response.dart';

abstract class CategoryDataSource {
  Future<List<CategoryResponse>> getCategories();
}

class CategoryDataSourceImpl implements CategoryDataSource {
  CategoryDataSourceImpl({required ApiClient apiClient}) : _apiClient = apiClient;

  final ApiClient _apiClient;
  @override
  Future<List<CategoryResponse>> getCategories() async {
    try {
      final Response<List<dynamic>> response = await _apiClient.get('/categories');
      if (response.statusCode == 200) {
        if (response.data == null) {
          return <CategoryResponse>[];
        }
        return response.data!.map((dynamic json) => CategoryResponse.fromJson(json)).toList();
      } else {
        throw HandledException('Failed to load categories');
      }
    } catch (e) {
      throw HandledException('Failed to load categories: $e');
    }
  }
}
