import 'package:equatable/equatable.dart';
import 'package:group_exito/ui/feature/home/data/models/category_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_response.g.dart';

@JsonSerializable()
class ProductResponse extends Equatable {
  final int id;
  final String title;
  final String slug;
  final num price;
  final String description;
  final CategoryResponse category;
  final List<String> images;
  final DateTime creationAt;
  final DateTime updatedAt;

  const ProductResponse({
    required this.id,
    required this.title,
    required this.slug,
    required this.price,
    required this.description,
    required this.category,
    required this.images,
    required this.creationAt,
    required this.updatedAt,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) => _$ProductResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductResponseToJson(this);

  @override
  List<Object?> get props => <Object?>[id, title, slug, price, description, category, images, creationAt, updatedAt];
}
