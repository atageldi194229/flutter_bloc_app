import 'package:flutter/material.dart';
import 'package:jsonplaceholder_app/data/models/post_model.dart';

class PostCard extends StatelessWidget {
  final PostModel post;
  const PostCard(this.post, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 100,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          elevation: 3,
          child: ListTile(
            title: Text(
              post.title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              post.body.split("\n").first,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        // child: Material(
        //   elevation: 3,
        //   child: Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     child: Column(
        //       children: [
        //         Text(
        //           post.title,
        //           style: const TextStyle(fontWeight: FontWeight.bold),
        //         ),
        //         const Spacer(),
        //         Text(
        //           post.body.split("\n").first,
        //           overflow: TextOverflow.ellipsis,
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
