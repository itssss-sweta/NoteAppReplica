import 'package:flutter/material.dart';
import '../color palette/colors.dart';
import 'package:provider/provider.dart';
import '../model/note.dart';
import '../screen/addnote.dart';
import '../screen/editing_note_page.dart';

TextStyle dialogTextStyle = TextStyle(
  color: textColor,
);
TextStyle buttonTextStyle = TextStyle(
  color: yellow1,
  fontSize: 16,
);

void showDialogHelper(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: grey1,
        title: Text(
          'Add Task',
          style: dialogTextStyle,
        ),
        content: TextField(
          style: dialogTextStyle,
          decoration: InputDecoration(
            filled: true,
            fillColor: grey1,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.black),
            ),
          ),
        ),
        actions: [
          ButtonBar(
            children: [
              TextButton(
                onPressed: () {},
                child: Text(
                  'Add',
                  style: buttonTextStyle,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Exit',
                  style: buttonTextStyle,
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}

void createNewNote(BuildContext context) {
  //create a new id
  int id = Provider.of<NoteData>(context, listen: false).getAllNotes().length;

  //create a blank note
  Note newNote = Note(
    id: id,
    text: '',
    title: '',
  );

  //go to edit the note
  goToNotePage(context, newNote, true);
}

//goto note editing page
void goToNotePage(BuildContext context, Note note, bool isNewNote) {
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
