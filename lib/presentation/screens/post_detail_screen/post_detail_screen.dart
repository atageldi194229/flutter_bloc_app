// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jsonplaceholder_app/data/models/photo_model.dart';
import 'package:jsonplaceholder_app/data/models/post_model.dart';
import 'package:jsonplaceholder_app/logic/bloc/abstract/item_list_bloc/item_list_bloc.dart';
import 'package:jsonplaceholder_app/logic/bloc/photo_list_bloc.dart';
import 'package:jsonplaceholder_app/presentation/constants.dart';
import 'package:jsonplaceholder_app/presentation/responsive.dart';

import 'comment_form.dart';
import 'comment_list.dart';
import 'post_details.dart';

class PostDetailScreen extends StatelessWidget {
  final PostModel post;
  const PostDetailScreen({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post detail: ${post.title}"),
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<PhotoListBloc, ItemListState<PhotoModel>>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      // mainAxisSize: MainAxisSize.max,
                      children: [
                        PostDetails(post: post),
                        const SizedBox(height: kDefaultPadding),
                        CommentForm(post.id),
                        const SizedBox(height: kDefaultPadding),
                        if (!Responsive.isDesktop(context)) CommentList(post)
                      ],
                    ),
                  ),
                  const SizedBox(width: kDefaultPadding),
                  if (Responsive.isDesktop(context))
                    Expanded(
                      flex: 3,
                      child: CommentList(post),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
