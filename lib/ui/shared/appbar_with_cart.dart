import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:group_exito/core/resources/foundations/font_foundation.dart';
import 'package:group_exito/core/resources/gen/colors.gen.dart';
import 'package:group_exito/ui/app/cubit/app_cubit.dart';
import 'package:group_exito/ui/feature/home/data/models/product_response.dart';

class AppBarWithCart extends StatelessWidget implements PreferredSizeWidget {
  void showCartDialog(BuildContext context, List<ProductResponse> products) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            final Map<ProductResponse, int> grouped = context.read<CartCubit>().getGroupedProducts();
            return AlertDialog(
              title: const Text('Carrito de compras'),
              content: SizedBox(
                width: double.maxFinite,
                child: grouped.isEmpty
                    ? const Text('No hay productos en el carrito.')
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: grouped.length,
                        itemBuilder: (BuildContext context, int index) {
                          final productEntry = grouped.entries.elementAt(index);
                          final ProductResponse product = productEntry.key;
                          final int cantidad = productEntry.value;
                          return ListTile(
                            title: Text(product.title),
                            subtitle: Text('Cantidad: $cantidad'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                IconButton(
                                  icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
                                  onPressed: () {
                                    context.read<CartCubit>().removeProduct(product);
                                    setState(() {});
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.add_circle_outline, color: Colors.green),
                                  onPressed: () {
                                    context.read<CartCubit>().addProduct(product);
                                    setState(() {});
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
              actions: <Widget>[
                TextButton(onPressed: () => context.pop(), child: const Text('Cerrar')),
                if (grouped.isNotEmpty)
                  TextButton(
                    onPressed: () {
                      context.read<CartCubit>().clear();
                      context.pop();
                    },
                    child: const Text('Vaciar carrito'),
                  ),
              ],
            );
          },
        );
      },
    );
  }

  final String title;
  final VoidCallback? onCartTap;
  const AppBarWithCart({super.key, required this.title, this.onCartTap});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: BlocBuilder<CartCubit, List<ProductResponse>>(
            builder: (BuildContext context, List<ProductResponse> products) {
              final int totalCount = context.read<CartCubit>().getGroupedProducts().values.fold(0, (int sum, int v) => sum + v);
              return Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  IconButton(icon: const Icon(Icons.shopping_cart), onPressed: () => showCartDialog(context, products)),
                  if (totalCount > 0)
                    Positioned(
                      right: 6,
                      top: 6,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(color: ColorToken.error600, borderRadius: BorderRadius.circular(10)),
                        constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
                        child: Text(
                          '$totalCount',
                          style: FontFoundation.title.bold12Lato.copyWith(color: ColorToken.exitoYellow),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
