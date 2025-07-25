import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category_response.g.dart';

@JsonSerializable()
class CategoryResponse extends Equatable {
  final int id;
  final String name;
  final String slug;
  final String image;
  final DateTime creationAt;
  final DateTime updatedAt;

  const CategoryResponse({required this.id, required this.name, required this.slug, required this.image, required this.creationAt, required this.updatedAt});

  factory CategoryResponse.fromJson(Map<String, dynamic> json) => _$CategoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryResponseToJson(this);

  @override
  List<Object?> get props => <Object?>[id, name, slug, image, creationAt, updatedAt];
}
