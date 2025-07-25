import 'package:dio/dio.dart';
import 'package:group_exito/core/client/api_client.dart';
import 'package:group_exito/core/models/exceptions/exceptions.dart';
import 'package:group_exito/ui/feature/home/data/models/product_response.dart';

abstract class ProductDataSource {
  Future<List<ProductResponse>> getProductsByCategory(int categoryId);
}

class ProductDataSourceImpl implements ProductDataSource {
  ProductDataSourceImpl({required ApiClient apiClient}) : _apiClient = apiClient;

  final ApiClient _apiClient;

  @override
  Future<List<ProductResponse>> getProductsByCategory(int categoryId) async {
    try {
      final Response<List<dynamic>> response = await _apiClient.get('/products', queryParameters: <String, dynamic>{'category': categoryId});
      if (response.statusCode == 200) {
        if (response.data == null) {
          return <ProductResponse>[];
        }
        return response.data!.map((dynamic json) => ProductResponse.fromJson(json)).toList();
      } else {
        throw HandledException('Failed to load products');
      }
    } catch (e) {
      throw HandledException('Failed to validate category ID: $e');
    }
  }
}
