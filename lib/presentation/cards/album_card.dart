import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jsonplaceholder_app/data/models/album_model.dart';
import 'package:jsonplaceholder_app/data/models/photo_model.dart';
import 'package:jsonplaceholder_app/data/repositories/photo_repository.dart';
import 'package:jsonplaceholder_app/logic/bloc/abstract/item_list_bloc/item_list_bloc.dart';
import 'package:jsonplaceholder_app/logic/bloc/photo_list_bloc.dart';
import 'package:jsonplaceholder_app/presentation/screens/album_detail_screen.dart';

class AlbumCard extends StatelessWidget {
  final AlbumModel album;
  const AlbumCard(this.album, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return InkWell(
        onTap: () {
          context.read<PhotoListBloc>().add(
                LoadAlbumPhotosEvent(
                  loader: () => PhotoRepository().getForAlbum(album.id),
                  albumId: album.id,
                ),
              );

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AlbumDetailScreen(album: album),
            ),
          );
        },
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
                        text: album.title + ("\n" * 3),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                child: BlocBuilder<PhotoListBloc, ItemListState<PhotoModel>>(
                  builder: (context, state) {
                    findFunc(photo) => photo.albumId == album.id;

                    final found = state.list.any(findFunc);

                    if (found) {
                      final photo = state.list.firstWhere(findFunc);

                      return CachedNetworkImage(
                        progressIndicatorBuilder: (context, url, progress) =>
                            Center(
                          child: CircularProgressIndicator(
                            value: progress.progress,
                          ),
                        ),
                        imageUrl: photo.thumbnailUrl,
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) => const Center(
                          child: Icon(Icons.error),
                        ),
                      );
                    }

                    return Container();
                  },
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
