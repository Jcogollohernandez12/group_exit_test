import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_exito/core/config/di/di_manager.dart';
import 'package:group_exito/core/errors/error_handler.dart';
import 'package:group_exito/ui/feature/home/data/models/category_response.dart';
import 'package:group_exito/ui/feature/home/presentation/widgets/category_card.dart';
import 'package:group_exito/ui/feature/home/domain/usecase/category/get_all_categories_use_case.dart';
import 'package:group_exito/ui/feature/home/presentation/pages/categories/bloc/categories_bloc.dart';
import 'package:group_exito/ui/feature/home/presentation/pages/categories/bloc/categories_event.dart';
import 'package:group_exito/ui/feature/home/presentation/pages/categories/bloc/categories_state.dart';

class CategoriesPage extends StatelessWidget {
  static const String routeName = '/categories';
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CategoriesBloc>(
      create: (_) {
        final CategoriesBloc bloc = CategoriesBloc(getAllCategoriesUseCase: DIManager.get<GetAllCategoriesUseCase>());
        bloc.add(HomeLoadCategories());
        return bloc;
      },
      child: BlocListener<CategoriesBloc, CategoriesState>(
        listener: (BuildContext context, CategoriesState state) {
          if (state is CategoriesFailure) {
            ErrorHandler.handleException(state.exceptionDetail, showAlertOnError: true);
          }
        },
        child: BlocBuilder<CategoriesBloc, CategoriesState>(
          builder: (BuildContext context, CategoriesState state) {
            if (state is HomeLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CategoriesLoaded) {
              final List<CategoryResponse> categories = state.categories;
              return _CategoriesView(categories: categories);
            } else if (state is CategoriesFailure) {
              return const Center(child: Text('Error al cargar categorías'));
            }
            return const Center(child: Text('No hay categorías'));
          },
        ),
      ),
    );
  }
}

class _CategoriesView extends StatelessWidget {
  const _CategoriesView({this.categories = const <CategoryResponse>[]});

  final List<CategoryResponse> categories;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Categorías')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.7, crossAxisSpacing: 16, mainAxisSpacing: 16),
          itemCount: categories.length,
          itemBuilder: (BuildContext context, int index) {
            final CategoryResponse category = categories[index];
            return CategoriaCard(id: category.id.toString(), name: category.name, imageUrl: category.image, url: category.slug, onTap: () {});
          },
        ),
      ),
    );
  }
}
