import 'package:equatable/equatable.dart';
import 'package:group_exito/ui/feature/home/data/models/category_response.dart';

abstract class CategoriesState extends Equatable {
  @override
  List<Object?> get props => <Object>[];
}

class HomeInitial extends CategoriesState {}

class HomeLoading extends CategoriesState {}

class CategoriesLoaded extends CategoriesState {
  final List<CategoryResponse> categories;

  CategoriesLoaded({required this.categories});
}

class CategoriesFailure extends CategoriesState {
  final Exception exceptionDetail;
  CategoriesFailure(this.exceptionDetail);

  @override
  List<Object?> get props => <Object>[exceptionDetail];
}

class CategoriesEmpty extends CategoriesState {
  final String message;

  CategoriesEmpty({required this.message});

  @override
  List<Object?> get props => <Object>[message];
}
