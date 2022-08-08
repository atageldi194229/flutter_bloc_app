import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jsonplaceholder_app/logic/bloc/app_bloc.dart';
import 'package:jsonplaceholder_app/logic/bloc/app_state.dart';
import 'package:jsonplaceholder_app/presentation/dialogs/show_load_error.dart';
import 'package:jsonplaceholder_app/presentation/loading/loading_screen.dart';

class GenericBlocListener extends StatelessWidget {
  final Widget? child;
  const GenericBlocListener({
    Key? key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppBloc, AppState>(
      listener: (context, state) {
        // if (state.isLoading) {
        //   LoadingScreen.instance().show(
        //     context: context,
        //     text: "Loading",
        //   );
        // } else {
        //   LoadingScreen.instance().hide();
        // }

        // if (state.error != null) {
        //   showLoadError(error: state.error!, context: context);
        // }
      },
      child: child,
    );
  }
}
