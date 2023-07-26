import 'package:flutter/material.dart';
import '../color palette/colors.dart';
import 'package:provider/provider.dart';
import '../model/note.dart';
import '../screen/addnote.dart';
import '../screen/editing_note_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool showNewFolderOption = false;
  @override
  void initState() {
    super.initState();

    Provider.of<NoteData>(context, listen: false).initializeNotes();
  }

  //create a neew note
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
  void goToNotePage(Note note, bool isNewNote) {
    Navigator.push(
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
      body: Container(
        color: grey2,
        padding:
            const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Folders',
              style: TextStyle(
                color: Colors.grey[900],
                fontSize: 35,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 50,
              child: TextField(
                decoration: InputDecoration(
                    hintText: 'Search...',
                    hintStyle: TextStyle(
                      color: textColor,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    filled: true,
                    fillColor: grey1,
                    suffixIcon: Icon(
                      Icons.search,
                      color: textColor,
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20)),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: IconButton(
                  onPressed: () {
                    setState(
                      () {
                        showNewFolderOption = !showNewFolderOption;
                      },
                    );
                  },
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
          Visibility(
            visible: showNewFolderOption,
            child: TextButton(
              onPressed: () {},
              child: Text(
                'New Folder',
                style: TextStyle(color: textColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
