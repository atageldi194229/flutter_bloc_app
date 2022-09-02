// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import 'package:jsonplaceholder_app/data/models/photo_model.dart';

class PhotoViewerScreen extends StatefulWidget {
  const PhotoViewerScreen({
    Key? key,
    required this.photos,
    this.defaultIndex = 0,
    this.pageController,
  }) : super(key: key);

  final List<PhotoModel> photos;
  final int defaultIndex;
  final PageController? pageController;

  @override
  State<PhotoViewerScreen> createState() => _PhotoViewerScreenState();
}

class _PhotoViewerScreenState extends State<PhotoViewerScreen> {
  late int currentIndex = widget.defaultIndex;

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                  imageProvider: NetworkImage(widget.photos[index].url),
                  initialScale: PhotoViewComputedScale.contained * 0.8,
                );
              },
              itemCount: widget.photos.length,
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
              pageController: widget.pageController,
              onPageChanged: onPageChanged,
            ),
            Container(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                widget.photos[currentIndex].title,
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
