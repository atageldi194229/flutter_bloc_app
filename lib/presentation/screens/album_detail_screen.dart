import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jsonplaceholder_app/data/models/album_model.dart';
import 'package:jsonplaceholder_app/data/models/photo_model.dart';
import 'package:jsonplaceholder_app/logic/bloc/abstract/item_list_bloc/item_list_bloc.dart';
import 'package:jsonplaceholder_app/logic/bloc/photo_list_bloc.dart';
import 'package:jsonplaceholder_app/presentation/cards/photo_card.dart';
import 'package:jsonplaceholder_app/presentation/responsive.dart';
import 'package:jsonplaceholder_app/presentation/screens/photo_viewer_screen.dart';

class AlbumDetailScreen extends StatelessWidget {
  final AlbumModel album;
  const AlbumDetailScreen({
    Key? key,
    required this.album,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Album photos of: ${album.title}"),
      ),
      body: BlocBuilder<PhotoListBloc, ItemListState<PhotoModel>>(
        builder: (context, state) {
          final photos =
              state.list.where((photo) => photo.albumId == album.id).toList();

          return GridView.count(
            crossAxisCount: Responsive.getValue<int>(context, 1, 2, 3, 5),
            children: photos.map<Widget>((e) {
              return PhotoCard(
                photo: e,
                onTap: () {
                  final index = photos.indexOf(e);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PhotoViewerScreen(
                        photos: photos,
                        defaultIndex: index,
                        pageController: PageController(initialPage: index),
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
