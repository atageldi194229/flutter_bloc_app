import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jsonplaceholder_app/data/models/comment_model.dart';
import 'package:jsonplaceholder_app/data/models/post_model.dart';
import 'package:jsonplaceholder_app/logic/bloc/abstract/item_list_bloc/item_list_bloc.dart';
import 'package:jsonplaceholder_app/logic/bloc/comment_list_bloc.dart';
import 'package:jsonplaceholder_app/presentation/constants.dart';

class CommentList extends StatelessWidget {
  const CommentList(
    this.post, {
    Key? key,
  }) : super(key: key);

  final PostModel post;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: kDefaultPadding,
      child: BlocBuilder<CommentListBloc, ItemListState<CommentModel>>(
        builder: (context, state) {
          final comments = state.list.where((e) => e.postId == post.id);

          return Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(kDefaultPadding),
                child: Text("Comments:"),
              ),
              Column(
                children: comments
                    .map<Widget>(
                      (comment) => Padding(
                        padding: const EdgeInsets.all(kDefaultPadding),
                        child: Material(
                          elevation: kDefaultPadding,
                          child: ListTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  comment.email,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                Text(
                                  comment.name,
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                              ],
                            ),
                            subtitle: Text(
                              comment.body,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          );
        },
      ),
    );
  }
}
