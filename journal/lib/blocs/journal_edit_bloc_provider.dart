import 'package:flutter/material.dart';
import 'package:journal/blocs/journal_edit_bloc.dart';

class JournalEditBlocProvider extends InheritedWidget {
  final JournalEditBloc journalEditBloc;

  const JournalEditBlocProvider({
      required Key key, required Widget child, required this.journalEditBloc
  }) : super (key: key, child: child);

  static JournalEditBlocProvider of (BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType()
      as JournalEditBlocProvider);
  }

  @override
  bool updateShouldNotify(JournalEditBlocProvider oldWidget) {
    // TODO: implement updateShouldNotify
    return false;
  }
}