import 'package:flutter/material.dart';
import 'package:journal/blocs/authentication_bloc.dart';

class AuthenticationBlocProvider extends InheritedWidget {
  final AuthenticationBloc authenticationBloc;
  const AuthenticationBlocProvider(
  {required Key key, required Widget child, required this.authenticationBloc})
  : super(key: key, child: child);

  static AuthenticationBlocProvider of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType() as AuthenticationBlocProvider);
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    // TODO: implement updateShouldNotify
    AuthenticationBlocProvider oldBloc = oldWidget as AuthenticationBlocProvider;
    return authenticationBloc != oldWidget.authenticationBloc;
  }
}