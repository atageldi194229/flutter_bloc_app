import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jsonplaceholder_app/data/models/album_model.dart';
import 'package:jsonplaceholder_app/data/models/user_model.dart';
import 'package:jsonplaceholder_app/logic/bloc/abstract/item_list_bloc/item_list_bloc.dart';
import 'package:jsonplaceholder_app/logic/bloc/album_list_bloc.dart';
import 'package:jsonplaceholder_app/presentation/cards/album_card.dart';
import 'package:jsonplaceholder_app/presentation/responsive.dart';

class UserAlbumsScreen extends StatelessWidget {
  final UserModel user;
  const UserAlbumsScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Albums of user: ${user.username}"),
      ),
      body: BlocBuilder<AlbumListBloc, ItemListState<AlbumModel>>(
        builder: (context, state) {
          final albums = state.list.where((album) => user.id == album.userId);

          return GridView.count(
            crossAxisCount: Responsive.getValue<int>(context, 1, 2, 3, 5),
            children: albums.map<Widget>((e) => AlbumCard(e)).toList(),
          );
        },
      ),
    );
  }
}
