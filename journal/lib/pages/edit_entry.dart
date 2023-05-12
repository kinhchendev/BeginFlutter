import 'package:flutter/material.dart';
import 'package:journal/blocs/journal_edit_bloc.dart';
import 'package:journal/blocs/journal_edit_bloc_provider.dart';
import 'package:journal/classes/FormatDates.dart';
import 'package:journal/classes/mood_icons.dart';

import '../models/journal.dart';

class EditEntry extends StatefulWidget {
  const EditEntry({Key? key}) : super(key: key);

  @override
  State<EditEntry> createState() => _EditEntryState();
}

class _EditEntryState extends State<EditEntry> {
  late JournalEditBloc _journalEditBloc;
  late FormatDates _formatDates;
  late MoodIcons _moodIcons;
  late TextEditingController _noteController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _formatDates = FormatDates();
    _moodIcons = MoodIcons();
    _noteController = TextEditingController();
    _noteController.text = '';
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    JournalEditBlocProvider? editBlocProvider = JournalEditBlocProvider.of(context);
    if (editBlocProvider != null) {
      _journalEditBloc = editBlocProvider.journalEditBloc;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _noteController.dispose();
    _journalEditBloc.dispose();
    super.dispose();
  }

  Future<String> _selectDate(String selectedDate) async {
    DateTime _initialDate = DateTime.parse(selectedDate);
    final DateTime? _pickedDate = await showDatePicker(
      context: context,
      initialDate: _initialDate,
      firstDate: DateTime.now().subtract(Duration(days: 365)),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (_pickedDate != null) {
      selectedDate = DateTime(
        _pickedDate.year,
        _pickedDate.month,
        _pickedDate.day,
        _pickedDate.hour,
        _pickedDate.minute,
        _initialDate.second,
        _initialDate.millisecond,
        _initialDate.microsecond
      ).toString();
    }
    return selectedDate;
  }

  void _addOrUpdateJournal() {
    _journalEditBloc.saveJournalChanged.add('Save');
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Entry', style: TextStyle(color: Colors.lightGreen.shade800),),
        automaticallyImplyLeading: false,
        elevation: 0.0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.lightGreen, Colors.lightGreen.shade50],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )
          ),
        ),
      ),
      body: SafeArea(
        minimum: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StreamBuilder(
                stream: _journalEditBloc.dateEdit,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  debugPrint('build journal date');
                  String journalDate;
                  if (!snapshot.hasData) {
                    debugPrint('edit_entry StreamBuilder 1 snapshot has no data');
                    journalDate = _journalEditBloc.selectedJournal.date;
                  } else if (snapshot is String){
                    debugPrint('edit_entry StreamBuilder 2 snapshot = ${snapshot.data}');
                    journalDate = snapshot.data;
                  } else {
                    journalDate = _journalEditBloc.selectedJournal.date;
                    debugPrint('edit_entry StreamBuilder 3 journalDate = $journalDate');
                  }
                  return TextButton(
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          size: 22.0,
                          color: Colors.black54,
                        ),
                        SizedBox(width: 16.0,),
                        Text(_formatDates.dateFormatShortMonthDayYear(journalDate),
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black54,
                        ),
                      ],
                    ),
                    onPressed: () async {
                      FocusScope.of(context).requestFocus(FocusNode());
                      String _pickerDate = await _selectDate(journalDate);
                      debugPrint('pickerDate = $_pickerDate');
                      _journalEditBloc.dateEditChanged.add(_pickerDate);
                    },
                  );
                },
              ),
              StreamBuilder(
                stream: _journalEditBloc.moodEdit,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  Journal journal;
                  if (!snapshot.hasData) {
                    debugPrint('edit_entry StreamBuilder 2 snapshot has no data');
                    journal = _journalEditBloc.selectedJournal;
                  } else if (snapshot is Journal){
                    journal = snapshot.data;
                  } else {
                    journal = _journalEditBloc.selectedJournal;
                  }
                  int moodIndex = _moodIcons.getMoodIconList().indexWhere((icon) => icon.title == journal.mood);
                  MoodIcons moodValue = _moodIcons.getMoodIconList()[moodIndex];
                  debugPrint('moodIndex = $moodIndex, moodValue.title = ${moodValue.title}');
                  debugPrint('moodValueHash = ${moodValue.hashCode}');
                  var itemList = _moodIcons.getMoodIconList().map((MoodIcons selected) {
                    return DropdownMenuItem<MoodIcons>(
                      value: selected,
                      child: Row(
                        children: [
                          Transform(
                            transform: Matrix4.identity()..rotateZ(
                              _moodIcons.getMoodRotation(selected!.title!),
                            ),
                            alignment: Alignment.center,
                            child: Icon(
                              _moodIcons.getMoodIcon(selected!.title!),
                              color: _moodIcons.getMoodColor(selected!.title!),
                            ),
                          ),
                          const SizedBox(width: 16.0,),
                          Text(selected!.title!),
                        ],
                      ),
                    );
                  }).toList();
                  return DropdownButtonHideUnderline(
                      child: DropdownButton<MoodIcons>(
                        value: moodValue,
                        onChanged: (selected) {
                          _journalEditBloc.moodEditChanged.add(selected!.title!);
                        },
                        items: itemList,
                      ),
                  );
                },
              ),
              StreamBuilder(
                stream: _journalEditBloc.noteEdit,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  Journal journal;
                  if (!snapshot.hasData) {
                    debugPrint('edit_entry StreamBuilder 3 snapshot has no data');
                    journal = _journalEditBloc.selectedJournal;
                  } else if (snapshot is Journal){
                    journal = snapshot.data;
                  } else {
                    journal = _journalEditBloc.selectedJournal;
                  }
                  _noteController.value = _noteController.value.copyWith(text: journal.note);
                  return TextField(
                    controller: _noteController,
                    textInputAction: TextInputAction.newline,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      labelText: 'Note',
                      icon: Icon(Icons.subject),
                    ),
                    maxLines: null,
                    onChanged: (note) => _journalEditBloc.noteEditChanged.add(note),
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    child: Text('Cancel'),
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                            return Colors.black54;
                          }
                      ),
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                            return Colors.grey.shade100;
                          }
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(width: 8.0),
                  TextButton(
                    child: Text('Save'),
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                            return Colors.black54;
                          }
                      ),
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            return Colors.lightGreen.shade100;
                          }
                      ),
                    ),
                    onPressed: () {
                      _addOrUpdateJournal();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
