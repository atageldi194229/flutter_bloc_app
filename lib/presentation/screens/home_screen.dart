import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jsonplaceholder_app/logic/bloc/abstract/item_list_bloc/item_list_bloc.dart';
import 'package:jsonplaceholder_app/logic/bloc/user_list_bloc.dart';
import 'package:jsonplaceholder_app/presentation/cards/user_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users"),
      ),
      body: BlocBuilder<UserListBloc, ItemListState>(
        buildWhen: (previous, current) =>
            previous.list.length != current.list.length,
        builder: (context, state) {
          var size = MediaQuery.of(context).size;
          return SizedBox(
            height: size.height,
            width: size.width,
            child: ListView(
              shrinkWrap: true,
              children: state.list.map((e) => UserCard(e)).toList(),
            ),
          );
        },
      ),
    );
  }
}
