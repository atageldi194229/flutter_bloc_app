// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:jsonplaceholder_app/data/models/comment_model.dart';
import 'package:jsonplaceholder_app/data/models/photo_model.dart';
import 'package:jsonplaceholder_app/data/models/post_model.dart';
import 'package:jsonplaceholder_app/data/repositories/comment_repository.dart';
import 'package:jsonplaceholder_app/logic/bloc/abstract/item_list_bloc/item_list_bloc.dart';
import 'package:jsonplaceholder_app/logic/bloc/comment_list_bloc.dart';
import 'package:jsonplaceholder_app/logic/bloc/photo_list_bloc.dart';
import 'package:jsonplaceholder_app/presentation/constants.dart';
import 'package:jsonplaceholder_app/presentation/responsive.dart';

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
        title: Text(post.title),
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
                        _PostDetail(post: post),
                        const SizedBox(height: kDefaultPadding),
                        _CommentForm(post.id),
                        const SizedBox(height: kDefaultPadding),
                        if (!Responsive.isDesktop(context)) _CommentList(post)
                      ],
                    ),
                  ),
                  const SizedBox(width: kDefaultPadding),
                  if (Responsive.isDesktop(context))
                    Expanded(
                      flex: 3,
                      child: _CommentList(post),
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

class _PostDetail extends StatelessWidget {
  const _PostDetail({
    Key? key,
    required this.post,
  }) : super(key: key);

  final PostModel post;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: kDefaultPadding,
      child: Container(
        alignment: Alignment.bottomCenter,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text("Post Detail: "),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.title,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                const SizedBox(height: 16.0),
                Text(
                  post.body,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CommentList extends StatelessWidget {
  const _CommentList(
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

class _CommentForm extends HookWidget {
  _CommentForm(this.postId, {Key? key}) : super(key: key);

  final int postId;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController();
    final nameController = useTextEditingController();
    final bodyController = useTextEditingController();

    final decoration = InputDecoration(
      contentPadding: const EdgeInsets.all(kDefaultPadding * 2),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(kDefaultPadding),
      ),
    );

    return Material(
      elevation: kDefaultPadding,
      child: Container(
        padding: const EdgeInsets.all(kDefaultPadding),
        alignment: Alignment.bottomCenter,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Text("Comment Form"),
              const SizedBox(height: kDefaultPadding),
              TextFormField(
                controller: emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter correct email';
                  }

                  // TODO: email validation

                  return null;
                },
                decoration: decoration.copyWith(hintText: 'Email'),
              ),
              const SizedBox(height: kDefaultPadding),
              TextFormField(
                controller: nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter correct text';
                  }
                  return null;
                },
                decoration: decoration.copyWith(hintText: 'Name'),
              ),
              const SizedBox(height: kDefaultPadding),
              TextFormField(
                controller: bodyController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter correct text';
                  }
                  return null;
                },
                maxLines: 6,
                decoration: decoration.copyWith(hintText: 'Body'),
              ),
              const SizedBox(height: kDefaultPadding),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<CommentListBloc>().add(
                          CreatePostCommentEvent(
                            loader: () => CommentRepository().create(
                              CommentModel(
                                body: bodyController.text,
                                email: emailController.text,
                                id: -1,
                                name: nameController.text,
                                postId: postId,
                              ),
                            ),
                          ),
                        );
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
