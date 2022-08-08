import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jsonplaceholder_app/data/repositories/user_repository.dart';
import 'package:jsonplaceholder_app/logic/bloc/app_bloc.dart';
import 'package:jsonplaceholder_app/logic/bloc/app_event.dart';
import 'package:jsonplaceholder_app/logic/bloc/app_state.dart';
import 'package:jsonplaceholder_app/presentation/dialogs/show_load_error.dart';
import 'package:jsonplaceholder_app/presentation/loading/loading_screen.dart';
import 'package:jsonplaceholder_app/presentation/screens/home_screen.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppBloc>(
      create: (context) => AppBloc()
        ..add(
          LoadUsersEvent(
            // loader: UserRepository().getAll,
            loader: () => Future.delayed(const Duration(seconds: 15), () => []),
          ),
        ),
      child: MaterialApp(
        title: "Foo",
        theme: ThemeData(primaryColor: Colors.blue),
        debugShowCheckedModeBanner: false,
        home: const HomeScreen(),
        builder: (context, child) {
          return BlocListener<AppBloc, AppState>(
            listener: (context, state) {
              debugPrint("${state.isLoading}");
              if (state.isLoading) {
                LoadingScreen.instance().show(
                  context: context,
                  text: "Loading",
                );
              } else {
                LoadingScreen.instance().hide();
              }

              if (state.error != null) {
                showLoadError(error: state.error!, context: context);
              }
            },
            child: child,
          );
        },
      ),
    );
  }
}
