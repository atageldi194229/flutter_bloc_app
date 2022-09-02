import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jsonplaceholder_app/data/repositories/user_repository.dart';
import 'package:jsonplaceholder_app/logic/bloc/album_list_bloc.dart';
import 'package:jsonplaceholder_app/logic/bloc/app_error_bloc/app_error_bloc.dart';
import 'package:jsonplaceholder_app/logic/bloc/comment_list_bloc.dart';
import 'package:jsonplaceholder_app/logic/bloc/loading_bloc/loading_bloc.dart';
import 'package:jsonplaceholder_app/logic/bloc/photo_list_bloc.dart';
import 'package:jsonplaceholder_app/logic/bloc/post_list_bloc.dart';
import 'package:jsonplaceholder_app/logic/bloc/user_list_bloc.dart';
import 'package:jsonplaceholder_app/presentation/dialogs/show_app_error.dart';
import 'package:jsonplaceholder_app/presentation/global/keys.dart';
import 'package:jsonplaceholder_app/presentation/loading/loading_screen.dart';
import 'package:jsonplaceholder_app/presentation/screens/home_screen.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: _getProviders(),
      child: MaterialApp(
        navigatorKey: navigatorKey,
        title: "Foo",
        theme: ThemeData(primaryColor: Colors.blue),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          /* dark theme settings */
        ),
        themeMode: ThemeMode.dark,
        debugShowCheckedModeBanner: false,
        home: const HomeScreen(),
        builder: (context, child) {
          return MultiBlocListener(
            listeners: [
              BlocListener<LoadingBloc, LoadState>(
                listener: (_, state) {
                  if (state is LoadStateOn) {
                    LoadingScreen.instance().show(
                      navigatorKey: navigatorKey,
                      text: "Loading",
                    );
                  } else {
                    LoadingScreen.instance().hide();
                  }
                },
              ),
              BlocListener<AppErrorBloc, AppErrorState>(
                listener: (context, state) {
                  if (state.error != null) {
                    final error = state.error!;

                    showAppError(
                      error: error,
                      context: navigatorKey.currentContext!,
                    ).then((value) {
                      context
                          .read<AppErrorBloc>()
                          .add(AppErrorRemoveEvent(error));
                    });
                  }
                },
              ),
            ],
            child: child!,
          );
        },
      ),
    );
  }

  List<BlocProvider> _getProviders() {
    final loadingBloc = LoadingBloc();
    final appErrorBloc = AppErrorBloc();

    final photoListBloc = PhotoListBloc(
      appErrorBloc: appErrorBloc,
      loadingBloc: loadingBloc,
    );
    final postListBloc = PostListBloc(
      appErrorBloc: appErrorBloc,
      loadingBloc: loadingBloc,
    );
    final commentListBloc = CommentListBloc(
      appErrorBloc: appErrorBloc,
      loadingBloc: loadingBloc,
    );

    final userListBloc = UserListBloc(
      appErrorBloc: appErrorBloc,
      loadingBloc: loadingBloc,
    );

    final albumListBloc = AlbumListBloc(
      appErrorBloc: appErrorBloc,
      loadingBloc: loadingBloc,
      photoListBloc: photoListBloc,
    );

    userListBloc.add(
      LoadUsersEvent(
        loader: UserRepository().getAll,
      ),
    );

    return <BlocProvider>[
      BlocProvider<LoadingBloc>(create: (_) => loadingBloc),
      BlocProvider<AppErrorBloc>(create: (_) => appErrorBloc),
      BlocProvider<AlbumListBloc>(create: (_) => albumListBloc),
      BlocProvider<PhotoListBloc>(create: (_) => photoListBloc),
      BlocProvider<PostListBloc>(create: (_) => postListBloc),
      BlocProvider<CommentListBloc>(create: (_) => commentListBloc),
      BlocProvider<UserListBloc>(create: (_) => userListBloc),
    ];
  }
}
