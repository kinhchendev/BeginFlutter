import 'package:flutter/material.dart';
import 'package:ch13_local_persistence/pages/edit_entry.dart';
import 'package:ch13_local_persistence/classes/database.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Database _database;

  @override void initState() {
    super.initState();
    _database = DatabaseFileRoutines.databaseFromJson('{"journals":[]}');
  }

  @override
  Widget build(BuildContext context) {
    print('HomeState build');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Local Persistence'),
      ),
      body: FutureBuilder(
        future: _loadJournals(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          print('FutureBuilder build');
          if(snapshot.connectionState == ConnectionState.waiting) {
            print('snapshot is wating');
          } else {
            print('snapshot not wating');
          }
          if (!snapshot.hasData) {
            print('snapshot has no data');
            return const Center(child: CircularProgressIndicator());
          } else {
            print('snapshot has data');
            return _buildListViewSeparated(snapshot);
          }
        },
      ),
      bottomNavigationBar: const BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Padding(padding: EdgeInsets.all(24.0),),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add Journal Entry',
        child: Icon(Icons.add),
        onPressed: () {
          _addOrEditJournal(add: true, index: -1, journal: Journal(id: '', date: '', mood: '', note: ''));
        },
      ),
    );
  }

  Future<List<Journal>> _loadJournals() async {
    await DatabaseFileRoutines().readJournals().then((journalsJson) {
      // _database = databaseFromJson(journalsJson);
      print('journalsJson = $journalsJson');
      _database = DatabaseFileRoutines.databaseFromJson(journalsJson);
      _database.journal.sort((comp1, comp2) => comp2.date.compareTo(comp1.date));
    });
    return _database.journal;
  }

  void _addOrEditJournal({required bool add, required int index, required Journal journal}) async {
    JournalEdit _journalEdit = JournalEdit(action: '', journal: journal);
    _journalEdit = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => EditEntry(
            add: add,
            index: index,
            journalEdit: _journalEdit,
          ),
          fullscreenDialog: true
      ),
    );
    switch (_journalEdit.action) {
      case 'Save':
        if (add) {
          _database.journal.add(_journalEdit.journal);
        } else {
          _database.journal[index] = _journalEdit.journal;
        }
        await DatabaseFileRoutines().writeJournals(DatabaseFileRoutines.databaseToJson(_database));
        setState(() {

        });
        break;
        case 'Cancel':
          break;
          default:
            break;
    }
  }

  Widget _buildListViewSeparated(AsyncSnapshot snapshot) {
    return ListView.separated(
      itemCount: snapshot.data.length,
      itemBuilder: (BuildContext context, int index) {
        String _titleDate = DateFormat.yMMMd().format(DateTime.parse(snapshot .data[index].date));
        String _subtitle = snapshot.data[index].mood + "\n" + snapshot .data[index].note;
        return Dismissible(
          key: Key(snapshot.data[index].id),
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
                Text(DateFormat.d().format(DateTime.parse(snapshot.data[index].date)),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 32.0,
                      color: Colors.blue
                  ),
                ),
                Text(DateFormat.E().format(DateTime.parse(snapshot.data[index].date))),
              ],
            ),
            title: Text(
              _titleDate,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(_subtitle),
            onTap: () {
              _addOrEditJournal(
                add: false,
                index: index,
                journal: snapshot.data[index],
              );
              },
          ),
          onDismissed: (direction) async {
            _database.journal.removeAt(index);
            await DatabaseFileRoutines().writeJournals(DatabaseFileRoutines.databaseToJson(_database));
            setState(() {

            });
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
}
