import 'package:flutter/material.dart';
import 'package:group_exito/core/resources/foundations/font_foundation.dart';

class CategoriaCard extends StatelessWidget {
  final String id;
  final String name;
  final String imageUrl;
  final String url;
  final void Function()? onTap;

  const CategoriaCard({super.key, required this.id, required this.name, required this.imageUrl, required this.url, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 180,
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) => const Center(child: Icon(Icons.broken_image, size: 60, color: Colors.grey)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(name, style: FontFoundation.title.bold20Lato.copyWith(color: Colors.orange[800])),
                  const SizedBox(height: 6),

                  Row(
                    children: <Widget>[
                      const Icon(Icons.link, size: 16, color: Colors.blueAccent),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          url,
                          style: FontFoundation.title.medium14Lato.copyWith(color: Colors.blueAccent, decoration: TextDecoration.underline),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
