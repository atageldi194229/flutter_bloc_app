import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:jsonplaceholder_app/data/models/photo_model.dart';

class PhotoCard extends StatelessWidget {
  const PhotoCard({
    Key? key,
    required this.photo,
    this.onTap,
  }) : super(key: key);

  final PhotoModel photo;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return InkWell(
        onTap: onTap,
        child: SizedBox(
          width: constraints.maxHeight,
          height: constraints.maxHeight,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              elevation: 3,
              child: GridTile(
                footer: Container(
                  decoration:
                      BoxDecoration(color: Colors.black.withOpacity(0.5)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RichText(
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        text: photo.title + ("\n" * 3),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                child: CachedNetworkImage(
                  progressIndicatorBuilder: (context, url, progress) => Center(
                    child: CircularProgressIndicator(
                      value: progress.progress,
                    ),
                  ),
                  imageUrl: photo.url,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
