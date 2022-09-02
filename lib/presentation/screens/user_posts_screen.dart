import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jsonplaceholder_app/data/models/post_model.dart';
import 'package:jsonplaceholder_app/data/models/user_model.dart';
import 'package:jsonplaceholder_app/logic/bloc/abstract/item_list_bloc/item_list_bloc.dart';
import 'package:jsonplaceholder_app/logic/bloc/post_list_bloc.dart';
import 'package:jsonplaceholder_app/presentation/cards/post_card.dart';

class UserPostsScreen extends StatelessWidget {
  final UserModel user;
  const UserPostsScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Posts of user: ${user.username}"),
      ),
      body: BlocBuilder<PostListBloc, ItemListState<PostModel>>(
        builder: (context, state) {
          final posts =
              state.list.where((post) => user.id == post.userId).toList();

          return ListView.builder(
            itemBuilder: (context, index) {
              final post = posts[index];
              return PostCard(post);
            },
            itemCount: posts.length,
          );
        },
      ),
    );
  }
}
