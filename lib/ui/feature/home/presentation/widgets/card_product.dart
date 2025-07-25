import 'package:flutter/material.dart';
import 'package:group_exito/core/resources/foundations/font_foundation.dart';
import 'package:intl/intl.dart';

class ProductCard extends StatelessWidget {
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
                  itemCount: images.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (_, int index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        images[index],
                        fit: BoxFit.cover,
                        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return const Center(child: CircularProgressIndicator());
                        },
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

  @override
  Widget build(BuildContext context) {
    final String formattedDate = DateFormat.yMMMd().format(creationAt);
    final String imageUrl = images.isNotEmpty ? images.first : '';

    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 180,
            width: double.infinity,
            child: imageUrl.isNotEmpty ? Image.network(imageUrl, fit: BoxFit.cover) : const Center(child: Icon(Icons.image_not_supported, size: 50)),
          ),

          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: FontFoundation.title.bold20Lato.copyWith(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.orange[900]),
                ),
                const SizedBox(height: 4),
                Text(
                  '\$${price.toStringAsFixed(0)} COP',
                  style: FontFoundation.paragraph.medium16Lato.copyWith(color: Colors.green[700], fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 6),
                Text(slug, style: FontFoundation.paragraph.regular14Lato.copyWith(color: Colors.grey[600])),
                const SizedBox(height: 8),
                Text(
                  description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: FontFoundation.paragraph.regular14Lato.copyWith(color: Colors.grey[600]),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Categoría: $categoryName',
                      style: FontFoundation.label.medium14Lato.copyWith(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.blueGrey),
                    ),
                    Text(formattedDate, style: FontFoundation.paragraph.regular14Lato.copyWith(fontSize: 12, color: Colors.grey)),
                  ],
                ),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton.icon(
                    onPressed: () => _showPhotos(context),
                    icon: const Icon(Icons.photo_library),
                    label: const Text('Ver fotos'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange[800],
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
