import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_exito/core/resources/foundations/font_foundation.dart';
import 'package:group_exito/core/resources/gen/colors.gen.dart';
import 'package:group_exito/ui/feature/home/data/models/category_response.dart';
import 'package:group_exito/ui/feature/home/data/models/product_response.dart';
import 'package:group_exito/ui/shared/cubit/appbar_with_card_cubit.dart';
import 'package:group_exito/ui/shared/cubit/express_cubit.dart';

class ProductCard extends StatefulWidget {
  final int id;
  final String title;
  final String slug;
  final num price;
  final String description;
  final String categoryName;
  final List<String> images;
  final DateTime creationAt;

  const ProductCard({
    super.key,
    required this.id,
    required this.title,
    required this.slug,
    required this.price,
    required this.description,
    required this.categoryName,
    required this.images,
    required this.creationAt,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  CartCubit _getActiveCart(BuildContext context) {
    return context.read<CartCubit>();
  }

  int get cartQuantity => _getActiveCart(context).getProductCount(widget.id);

  void _increment() {
    _getActiveCart(context).addProduct(_toProductResponse());
  }

  void _decrement() {
    if (cartQuantity > 0) {
      _getActiveCart(context).removeProduct(_toProductResponse());
    }
  }

  ProductResponse _toProductResponse() {
    return ProductResponse(
      id: widget.id,
      title: widget.title,
      slug: widget.slug,
      price: widget.price,
      description: widget.description,
      category: CategoryResponse(id: 0, name: widget.categoryName, image: '', slug: '', creationAt: widget.creationAt, updatedAt: widget.creationAt),
      images: widget.images,
      creationAt: widget.creationAt,
      updatedAt: widget.creationAt,
    );
  }

  void _showPhotos(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text('📸 Imágenes del producto', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: widget.images.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (_, int index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        widget.images[index],
                        fit: BoxFit.cover,
                        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) => loadingProgress == null ? child : const Center(child: CircularProgressIndicator()),
                        errorBuilder: (_, __, ___) => const Icon(Icons.broken_image, size: 50),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAddButton() {
    return ElevatedButton(
      onPressed: _increment,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange[800],
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: const Text('Agregar'),
    );
  }

  Widget _buildCounter() {
    final bool express = context.read<ExpressCubit>().state;
    final Color counterColor = express ? Colors.blueAccent : Colors.orange;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            border: Border.all(color: counterColor),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              express
                  ? IconButton(
                      icon: Icon(Icons.delete_forever_outlined, color: Colors.blueGrey),
                      onPressed: () {
                        while (cartQuantity > 0) {
                          _decrement();
                        }
                      },
                    )
                  : IconButton(
                      icon: Icon(Icons.remove_circle_outline, color: counterColor),
                      onPressed: _decrement,
                    ),
              Text('$cartQuantity und', style: FontFoundation.label.medium14Lato.copyWith(color: counterColor)),
              IconButton(
                icon: Icon(Icons.add_circle_outline, color: counterColor),
                onPressed: _increment,
              ),
            ],
          ),
        ),
        if (express)
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: ElevatedButton(
              onPressed: () {
                // TODO: Implementar lógica de compra express
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Comprar'),
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final String imageUrl = widget.images.isNotEmpty ? widget.images.first : '';
    return BlocBuilder<CartCubit, List<ProductResponse>>(
      builder: (BuildContext context, _) {
        return Card(
          elevation: 6,
          margin: const EdgeInsets.only(bottom: 30),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 180,
                width: double.infinity,
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) => loadingProgress == null ? child : const Center(child: CircularProgressIndicator()),
                  errorBuilder: (_, __, ___) => const Icon(Icons.broken_image, size: 50),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.title,
                      style: FontFoundation.title.bold20Lato.copyWith(fontSize: 18, fontWeight: FontWeight.bold, color: ColorToken.exitoBlack),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${widget.price.toStringAsFixed(3)} COP',
                      style: FontFoundation.paragraph.medium16Lato.copyWith(color: ColorToken.exitoRed, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 6),
                    Text(widget.slug, style: FontFoundation.paragraph.regular14Lato.copyWith(color: Colors.grey[600])),
                    const SizedBox(height: 8),
                    Text(
                      widget.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: FontFoundation.paragraph.regular14Lato.copyWith(color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        cartQuantity == 0 ? _buildAddButton() : _buildCounter(),
                        ElevatedButton.icon(
                          onPressed: () => _showPhotos(context),
                          icon: const Icon(Icons.photo_library),
                          label: const Text('Ver fotos'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange[800],
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
