// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import 'package:jsonplaceholder_app/data/models/photo_model.dart';

class PhotoViewerScreen extends HookWidget {
  const PhotoViewerScreen({
    Key? key,
    required this.photos,
    this.defaultIndex = 0,
  }) : super(key: key);

  final List<PhotoModel> photos;
  final int defaultIndex;

  @override
  Widget build(BuildContext context) {
    final currentIndex = useState(defaultIndex);

    return Scaffold(
      appBar: AppBar(title: const Text("Photo Gallery")),
      body: Container(
        alignment: Alignment.bottomRight,
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            PhotoViewGallery.builder(
              scrollPhysics: const BouncingScrollPhysics(),
              builder: (BuildContext context, int index) {
                return PhotoViewGalleryPageOptions(
                  imageProvider: NetworkImage(photos[index].url),
                  initialScale: PhotoViewComputedScale.contained * 0.8,
                  heroAttributes:
                      PhotoViewHeroAttributes(tag: photos[index].id),
                );
              },
              itemCount: photos.length,
              loadingBuilder: (context, event) => Center(
                child: SizedBox(
                  width: 20.0,
                  height: 20.0,
                  child: CircularProgressIndicator(
                    value: event == null
                        ? 0
                        : event.cumulativeBytesLoaded /
                            event.expectedTotalBytes!,
                  ),
                ),
              ),
              // backgroundDecoration: widget.backgroundDecoration,
              // pageController: widget.pageController,
              onPageChanged: (index) => currentIndex.value = index,
            ),
            Container(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                photos[currentIndex.value].title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17.0,
                  decoration: null,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
