import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_exito/core/config/di/di_manager.dart';
import 'package:group_exito/ui/feature/home/data/models/product_response.dart';
import 'package:group_exito/ui/feature/home/domain/usecase/product/get_product_by_catg_use_case.dart';
import 'package:group_exito/ui/feature/home/presentation/pages/product/bloc/product_bloc.dart';
import 'package:group_exito/ui/feature/home/presentation/pages/product/bloc/product_event.dart';
import 'package:group_exito/ui/feature/home/presentation/pages/product/bloc/product_state.dart';
import 'package:group_exito/ui/feature/home/presentation/widgets/card_product.dart';
import 'package:group_exito/ui/shared/loading_mask.dart';

class ProductPage extends StatelessWidget {
  static const String routeName = '/product';
  const ProductPage({super.key, required this.categoryId, this.categoryName});

  final int categoryId;
  final String? categoryName;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductBloc>(
      create: (_) {
        final ProductBloc bloc = ProductBloc(getProductsByCategoryUseCase: DIManager.get<GetProductsByCategoryUseCase>());
        bloc.add(LoadProductsByCategory(categoryId));
        return bloc;
      },
      child: BlocBuilder<ProductBloc, ProductState>(
        builder: (BuildContext context, ProductState state) {
          if (state is ProductLoading) {
            return Scaffold(
              body: Center(child: LoadingMask(loading: true, child: Container())),
            );
          } else if (state is ProductLoaded) {
            final List<ProductResponse> products = state.products;
            return Scaffold(
              appBar: AppBar(title: Text(products.isNotEmpty ? products.first.category.name : '')),
              body: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: products.length,
                itemBuilder: (BuildContext context, int index) {
                  final ProductResponse product = products[index];
                  return ProductCard(
                    id: product.id,
                    title: product.title,
                    slug: product.slug,
                    price: product.price,
                    description: product.description,
                    categoryName: product.category.name,
                    images: product.images,
                    creationAt: product.creationAt,
                  );
                },
              ),
            );
          } else if (state is ProductError) {
            return Scaffold(body: Center(child: Text('Error: ${state.message}')));
          }
          return const Scaffold(body: Center(child: Text('No hay productos')));
        },
      ),
    );
  }
}
