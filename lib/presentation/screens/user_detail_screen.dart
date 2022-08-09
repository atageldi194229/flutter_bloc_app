import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jsonplaceholder_app/data/models/album_model.dart';
import 'package:jsonplaceholder_app/data/models/post_model.dart';
import 'package:jsonplaceholder_app/data/models/user_model.dart';
import 'package:jsonplaceholder_app/logic/bloc/abstract/item_list_bloc/item_list_bloc.dart';
import 'package:jsonplaceholder_app/logic/bloc/album_list_bloc.dart';
import 'package:jsonplaceholder_app/logic/bloc/post_list_bloc.dart';
import 'package:jsonplaceholder_app/presentation/cards/album_card.dart';
import 'package:jsonplaceholder_app/presentation/cards/post_card.dart';

class UserDetailScreen extends StatelessWidget {
  final UserModel user;
  const UserDetailScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, String> data = {
      "name": user.name,
      "email": user.email,
      "phone": user.phone,
      "website": user.website,
      "company.name": user.company.name,
      "company.bs": user.company.bs,
      "company.catchPhrase": user.company.catchPhrase,
      "address.city": user.address.city,
      "address.street": user.address.street,
      "address.suite": user.address.suite,
      "address.zipcode": user.address.zipcode,
    };

    return Scaffold(
      appBar: AppBar(
        title: Text(user.username),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DataTable(
              columns: const <DataColumn>[
                DataColumn(
                  label: Text(
                    'Key',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Value',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              ],
              rows: data.entries
                  .map<DataRow>(
                    (e) => DataRow(
                      cells: <DataCell>[
                        DataCell(Text(e.key)),
                        DataCell(Text(e.value)),
                      ],
                    ),
                  )
                  .toList(),
            ),
            BlocBuilder<AlbumListBloc, ItemListState<AlbumModel>>(
              builder: (context, state) {
                return SizedBox(
                  height: 200,
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: [
                      ...state.list.take(3).map((e) => AlbumCard(e)).toList(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextButton(
                          onPressed: () {},
                          child: const Text("More..."),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            BlocBuilder<PostListBloc, ItemListState<PostModel>>(
              builder: (context, state) {
                return Column(
                  children: [
                    ...state.list.take(3).map((e) => PostCard(e)).toList(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                        onPressed: () {},
                        child: const Text("More..."),
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
