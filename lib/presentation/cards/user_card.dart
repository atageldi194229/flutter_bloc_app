import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jsonplaceholder_app/data/models/user_model.dart';
import 'package:jsonplaceholder_app/data/repositories/album_repository.dart';
import 'package:jsonplaceholder_app/data/repositories/post_repository.dart';
import 'package:jsonplaceholder_app/logic/bloc/album_list_bloc.dart';
import 'package:jsonplaceholder_app/logic/bloc/post_list_bloc.dart';
import 'package:jsonplaceholder_app/presentation/screens/user_detail_screen/user_detail_screen.dart';

class UserCard extends StatelessWidget {
  final UserModel user;
  const UserCard(this.user, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        elevation: 3,
        child: InkWell(
          onTap: () {
            context.read<AlbumListBloc>().add(
                  LoadUserAlbumsEvent(
                    loader: () => AlbumRepository().getForUser(user.id),
                    userId: user.id,
                  ),
                );

            context.read<PostListBloc>().add(
                  LoadUserPostsEvent(
                    loader: () => PostRepository().getForUser(user.id),
                    userId: user.id,
                  ),
                );

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UserDetailScreen(user: user),
              ),
            );
          },
          child: ListTile(
            title: Text(user.username),
            leading: Text(user.name),
          ),
        ),
      ),
    );
  }
}
