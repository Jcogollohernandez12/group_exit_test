import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();
  @override
  List<Object?> get props => <Object?>[];
}

class LoadProductsByCategory extends ProductEvent {
  final int categoryId;
  const LoadProductsByCategory(this.categoryId);

  @override
  List<Object?> get props => <Object?>[categoryId];
}
