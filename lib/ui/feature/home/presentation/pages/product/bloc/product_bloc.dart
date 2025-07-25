import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:group_exito/core/models/result.dart';
import 'package:group_exito/ui/feature/home/data/models/product_response.dart';
import 'package:group_exito/ui/feature/home/domain/usecase/product/get_product_by_catg_use_case.dart';
import 'package:group_exito/ui/feature/home/presentation/pages/product/bloc/product_event.dart';
import 'package:group_exito/ui/feature/home/presentation/pages/product/bloc/product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProductsByCategoryUseCase getProductsByCategoryUseCase;

  ProductBloc({required this.getProductsByCategoryUseCase}) : super(ProductInitial()) {
    on<LoadProductsByCategory>(_onLoadProductsByCategory);
  }

  Future<void> _onLoadProductsByCategory(LoadProductsByCategory event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      final Result<List<ProductResponse>> result = await getProductsByCategoryUseCase.call(event.categoryId);
      if (result is SuccessfulResult<List<ProductResponse>>) {
        emit(ProductLoaded(result.payload));
      } else if (result is FailureResult<List<ProductResponse>>) {
        emit(ProductError(result.exception.toString()));
      }
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }
}
