import 'package:equatable/equatable.dart';
import 'package:group_exito/ui/feature/home/data/models/product_response.dart';

abstract class ProductState extends Equatable {
  const ProductState();
  @override
  List<Object?> get props => <Object?>[];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<ProductResponse> products;
  const ProductLoaded(this.products);

  @override
  List<Object?> get props => <Object?>[products];
}

class ProductError extends ProductState {
  final String message;
  const ProductError(this.message);

  @override
  List<Object?> get props => <Object?>[message];
}
