import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:group_exito/core/client/api_client.dart';
import 'package:group_exito/core/utils/interface/secure_storage_service.dart';
import 'package:group_exito/core/utils/services/secure_storage_service_impl.dart';
import 'package:group_exito/ui/feature/home/data/data_source/category/category_data_source.dart';
import 'package:group_exito/ui/feature/home/data/data_source/product/product_data_source.dart';
import 'package:group_exito/ui/feature/home/data/repository/category/category_repository_impl.dart';
import 'package:group_exito/ui/feature/home/data/repository/product/product_repository_impl.dart';
import 'package:group_exito/ui/feature/home/domain/repository/category/category_repository.dart';
import 'package:group_exito/ui/feature/home/domain/repository/product/product_repository.dart';
import 'package:group_exito/ui/feature/home/domain/usecase/category/get_all_categories_use_case.dart';
import 'package:group_exito/ui/feature/home/domain/usecase/product/get_product_by_catg_use_case.dart';

final class DIManager {
  DIManager._();

  static final GetIt _getIt = GetIt.I;

  static T get<T extends Object>({dynamic param1, dynamic param2, String? instanceName, Type? type}) => _getIt.get<T>(param1: param1, param2: param2, instanceName: instanceName, type: type);

  static GlobalKey<NavigatorState> getNavKey() => get<GlobalKey<NavigatorState>>(instanceName: 'navKey');

  static void setUpInitialDependencies() {
    if (_getIt.hasScope('initial')) {
      return;
    }

    _getIt.pushNewScope(scopeName: 'initial');

    // Context keys
    _getIt.registerSingleton(GlobalKey<NavigatorState>(), instanceName: 'navKey');

    _registerServices();
    _registerClient();
    _registerDataSources();
    _registerRepositories();
    _registerUseCase();

    // Cubits
  }

  static void _registerServices() {
    _getIt.registerLazySingleton<ISecureStorageService>(() => SecureStorageServiceImpl());
  }

  static void _registerClient() {
    _getIt.registerSingleton(ApiClient(), instanceName: 'ClientFactory');
  }

  static void _registerDataSources() {
    _getIt.registerLazySingleton<ProductDataSource>(() => ProductDataSourceImpl(apiClient: get(instanceName: 'ClientFactory')));
    _getIt.registerLazySingleton<CategoryDataSource>(() => CategoryDataSourceImpl(apiClient: get(instanceName: 'ClientFactory')));
  }

  static void _registerRepositories() {
    _getIt.registerLazySingleton<ProductRepository>(() => ProductRepositoryImpl(dataSource: get<ProductDataSource>()));
    _getIt.registerLazySingleton<CategoryRepository>(() => CategoryRepositoryImpl(dataSource: get<CategoryDataSource>()));
  }

  static void _registerUseCase() {
    _getIt.registerLazySingleton<GetProductsByCategoryUseCase>(() => GetProductsByCategoryUseCase(productRepository: get<ProductRepository>()));
    _getIt.registerLazySingleton<GetAllCategoriesUseCase>(() => GetAllCategoriesUseCase(categoryRepository: get<CategoryRepository>()));
  }

  static Future<void> setUpInitialTestDependencies() async {
    await _setUpOrResetGetItScope('test');
    setUpInitialDependencies();
  }

  static Future<void> _setUpOrResetGetItScope(String scope) async {
    await _getIt.reset();
    if (_getIt.hasScope(scope)) {
      await _getIt.resetScope();
    } else {
      _getIt.pushNewScope(scopeName: scope);
    }
  }
}
