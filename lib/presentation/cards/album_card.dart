import 'package:flutter/material.dart';
import 'package:jsonplaceholder_app/data/models/album_model.dart';

class AlbumCard extends StatelessWidget {
  final AlbumModel album;
  const AlbumCard(this.album, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 200,
        height: 200,
        child: Material(
          elevation: 3,
          child: InkWell(
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => UserDetailScreen(user: user),
              //   ),
              // );
            },
            child: Column(
              children: [
                const Spacer(),
                Text(album.title),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
