import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_exito/core/models/exceptions/exceptions.dart';
import 'package:group_exito/core/models/result.dart';
import 'package:group_exito/ui/feature/home/data/models/category_response.dart';
import 'package:group_exito/ui/feature/home/domain/usecase/category/get_all_categories_use_case.dart';
import 'package:group_exito/ui/feature/home/presentation/pages/categories/bloc/categories_event.dart';
import 'package:group_exito/ui/feature/home/presentation/pages/categories/bloc/categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesBloc({required GetAllCategoriesUseCase getAllCategoriesUseCase}) : _getAllCategoriesUseCase = getAllCategoriesUseCase, super(HomeInitial()) {
    on<HomeLoadCategories>(_onGetAllCategories);
  }

  final GetAllCategoriesUseCase _getAllCategoriesUseCase;

  Future<void> _onGetAllCategories(HomeLoadCategories event, Emitter<CategoriesState> emit) async {
    emit(HomeLoading());
    try {
      final Result<List<CategoryResponse>> categories = await _getAllCategoriesUseCase.call();
      if (categories is SuccessfulResult<List<CategoryResponse>>) {
        emit(CategoriesLoaded(categories: categories.payload));
      } else if (categories is FailureResult<List<CategoryResponse>>) {
        emit(CategoriesFailure(categories.exception));
      }
    } catch (error) {
      emit(CategoriesFailure(error is HandledException ? error : Exception(error.toString())));
    }
  }
}
