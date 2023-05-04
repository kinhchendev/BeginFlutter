import 'package:flutter/material.dart';
import 'package:journal/blocs/home_bloc.dart';

class HomeBlocProvider extends InheritedWidget {
  final HomeBloc homeBloc;
  final String uid;

  const HomeBlocProvider({
    required Key key,
    required Widget child,
    required this.homeBloc,
    required this.uid}) :
      super(key: key, child: child);

  static HomeBlocProvider of (BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType()
      as HomeBlocProvider);
  }

  @override
  bool updateShouldNotify( HomeBlocProvider oldWidget) {
    return homeBloc != oldWidget.homeBloc;
  }


}