import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jsonplaceholder_app/logic/bloc/app_bloc.dart';
import 'package:jsonplaceholder_app/logic/bloc/app_state.dart';
import 'package:jsonplaceholder_app/presentation/cards/user_card.dart';
import 'package:jsonplaceholder_app/presentation/generic_bloc_listener.dart';

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
      body: GenericBlocListener(
        child: BlocBuilder<AppBloc, AppState>(
          buildWhen: (previous, current) =>
              previous.users.length != current.users.length,
          builder: (context, state) {
            var size = MediaQuery.of(context).size;
            return SizedBox(
              height: size.height,
              width: size.width,
              child: ListView(
                shrinkWrap: true,
                children: state.users.map((e) => UserCard(e)).toList(),
              ),
            );
          },
        ),
      ),
    );
  }
}
