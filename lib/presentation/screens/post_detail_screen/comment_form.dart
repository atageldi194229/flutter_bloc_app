import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:jsonplaceholder_app/data/models/comment_model.dart';
import 'package:jsonplaceholder_app/data/repositories/comment_repository.dart';
import 'package:jsonplaceholder_app/logic/bloc/comment_list_bloc.dart';
import 'package:jsonplaceholder_app/presentation/constants.dart';

class CommentForm extends HookWidget {
  CommentForm(this.postId, {Key? key}) : super(key: key);

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
