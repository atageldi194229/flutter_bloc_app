import 'package:flutter/material.dart';
import 'package:jsonplaceholder_app/data/models/post_model.dart';
import 'package:jsonplaceholder_app/presentation/constants.dart';

class PostDetails extends StatelessWidget {
  const PostDetails({
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
