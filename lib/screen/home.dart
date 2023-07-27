import 'package:flutter/material.dart';
import '../color palette/colors.dart';
import 'package:provider/provider.dart';
import '../model/note.dart';
import '../function/addnote.dart';
import '../screen/editing_note_page.dart';
import '../function/taskcolumn.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    Provider.of<NoteData>(context, listen: false).initializeNotes();
  }

  //create a new note
  void createNewNote() {
    //create a new id
    int id = Provider.of<NoteData>(context, listen: false).getAllNotes().length;

    //create a blank note
    Note newNote = Note(
      id: id,
      text: '',
      title: '',
    );

    //go to edit the note
    goToNotePage(newNote, true);
  }

  //goto note editing page
  void goToNotePage(Note note, bool isNewNote) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditingNotePage(
          note: note,
          isNewNote: isNewNote,
        ),
      ),
    );
  }

  //delete note
  void deleteNote(Note note) {
    Provider.of<NoteData>(context, listen: false).deleteNote(note);
  }

  @override
  Widget build(BuildContext context) {
    final noteData = Provider.of<NoteData>(context);
    final List<Note> allNotes = noteData.getAllNotes();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: grey2,
        actions: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {},
                child: Text(
                  'Edit',
                  style: TextStyle(
                    color: yellow1,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Consumer<NoteData>(
        builder: (context, value, child) => Container(
          color: grey2,
          padding:
              const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Notes',
                style: TextStyle(
                  color: Colors.grey[900],
                  fontSize: 35,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.only(
                    top: 10, left: 30, right: 20, bottom: 20),
                child: Text(
                  'On My phone',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: textColor),
                ),
              ),
              (value.getAllNotes().isEmpty)
                  ? Padding(
                      padding: const EdgeInsets.only(top: 200),
                      child: Center(
                        child: Text(
                          'Empty List',
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 20,
                          ),
                        ),
                      ),
                    )
                  : Expanded(
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: ListView(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            for (int i = 0; i < allNotes.length; i++)
                              TaskColumn(
                                notes: allNotes[i],
                                onDelete: deleteNote,
                                onTap: () => goToNotePage(allNotes[i], false),
                              ),
                          ],
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.only(top: 10),
        color: grey2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.create_new_folder_outlined,
                  size: 35,
                  color: yellow1,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                onPressed: createNewNote,
                icon: Icon(
                  Icons.note_add_outlined,
                  size: 35,
                  color: yellow1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
