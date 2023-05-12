
import 'package:flutter/material.dart';
import 'package:journal/blocs/authentication_bloc.dart';
import 'package:journal/blocs/authentication_bloc_provider.dart';
import 'package:journal/blocs/home_bloc.dart';
import 'package:journal/blocs/home_bloc_provider.dart';
import 'package:journal/blocs/journal_edit_bloc.dart';
import 'package:journal/blocs/journal_edit_bloc_provider.dart';
import 'package:journal/classes/FormatDates.dart';
import 'package:journal/classes/mood_icons.dart';
import 'package:journal/models/journal.dart';
import 'package:journal/pages/edit_entry.dart';
import 'package:journal/services/db_firestore.dart';
import 'package:uuid/uuid.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late AuthenticationBloc? _authenticationBloc;
  late HomeBloc? _homeBloc;
  late String? _uid;
  MoodIcons _moodIcons = MoodIcons();
  FormatDates _formatDates = FormatDates();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Journal',
          style: TextStyle(
            color: Colors.lightGreen.shade800,
          ),
        ),
        elevation: 0.0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(32),
          child: Container(),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.lightGreen, Colors.lightGreen.shade50],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            color: Colors.lightGreen.shade800,
            onPressed: () {
              // TODO: Add signout method
              _authenticationBloc?.logoutUser.add(true);
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0.0,
        child: Container(
          height: 44.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.lightGreen.shade50, Colors.lightGreen],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add Journal Entry',
        backgroundColor: Colors.lightGreen.shade300,
        child: const Icon(Icons.add),
        onPressed: () {
          // TODO: Add _addOrEditJournal method
          _addOrEditJournal(add: true, journal: Journal(uid: _uid ?? '', documentID: Uuid().v4().toString(), mood: 'Very Satisfied', date: DateTime.now().toString()));
        },
      ),
      // body: Container(),
      body: buildStreamBuilder(),
    );
  }

  StreamBuilder<List<Journal>> buildStreamBuilder() {
    return StreamBuilder(
      stream: _homeBloc?.listJournal,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasData) {
          debugPrint('Home StreamBuilder snapshot has data');
          return _buildListViewSeparated(snapshot);
        } else {
          debugPrint('Home StreamBuilder snapshot has no data');
          return Center(
            child: Container(
              child: Text('Add Journals.'),
            ),
          );
        }
      },
    );
  }

  Widget _buildListViewSeparated(AsyncSnapshot snapshot) {
    debugPrint('buildListViewSeparated snapshot data length = ${snapshot.data.length}');
    return ListView.separated(
      itemCount: snapshot.data.length,
      itemBuilder: (BuildContext context, int index) {
        String _titleDate = _formatDates.dateFormatShortMonthDayYear(snapshot.data[index].date);
        String _subTitle = snapshot.data[index].mood + '\n' + snapshot.data[index].note;
        return Dismissible(
          key: Key(snapshot.data[index].documentID),
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 16.0),
            child: Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
          secondaryBackground: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
          child: ListTile(
            leading: Column(
              children: [
                Text(_formatDates.dateFormatDayNumber(snapshot.data[index].date),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 32.0,
                    color: Colors.lightGreen,
                  ),
                ),
                Text(_formatDates.dateFormatShortDayName(snapshot.data[index].date)),
              ],
            ),
            trailing: Transform(
              transform: Matrix4.identity()..rotateZ(
                  _moodIcons.getMoodRotation(snapshot.data[index].mood)
              ),
              alignment: Alignment.center,
              child: Icon(_moodIcons.getMoodIcon(snapshot.data[index].mood),
                color: _moodIcons.getMoodColor(snapshot.data[index].mood),
                size: 42.0,
              ),
            ),
            title: Text(
              _titleDate,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(_subTitle),
            onTap: () {
              _addOrEditJournal(add: false, journal: snapshot.data[index]);
            },
          ),
          confirmDismiss: (direction) async {
            bool confirmDelete = await _confirmDeleteJournal();
            if (confirmDelete) {
              _homeBloc?.deleteJournal.add(snapshot.data[index]);
            }
          },
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider(
          color: Colors.grey,
        );
      },
    );
  }
  
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    debugPrint('Home didChangeDependencies, context = $context');
    AuthenticationBlocProvider? auProvider = AuthenticationBlocProvider.of(context);
    if (auProvider != null) {
      _authenticationBloc = auProvider.authenticationBloc;
    } else {
      debugPrint('AuthenticationBlocProvider is null');
    }

    HomeBlocProvider? homeProvider = HomeBlocProvider.of(context);
    if (homeProvider != null) {
      _homeBloc = homeProvider.homeBloc;
      _uid = homeProvider.uid;
    } else {
      debugPrint('HomeBlocProvider is null');
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _homeBloc?.dispose();
    super.dispose();
  }

  void _addOrEditJournal({required bool add, required Journal journal}) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => JournalEditBlocProvider(
              journalEditBloc: JournalEditBloc(add, journal, DbFireStoreService()),
              child: EditEntry(),
            ),
          fullscreenDialog: true
        ),
    );
  }

  Future<bool> _confirmDeleteJournal() async {
    return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Journal'),
          content: Text('Are you sure you would like to Delete?'),
          actions: [
            TextButton(
              child: Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context, false);
              },
            ),
            TextButton(
              child: Text('DELETE', style: TextStyle(color: Colors.red),),
              onPressed: () {
                Navigator.pop(context, true);
              }
            ),
          ],
        );
      }
    );
  }
}