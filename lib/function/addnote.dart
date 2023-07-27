import 'package:flutter/material.dart';
import '../model/note.dart';

class NoteData extends ChangeNotifier {
  //overall list of notes
  List<Note> allNotes = [];

  //initialize list
  void initializeNotes() {
    allNotes = [
      Note(id: 0, title: 'Note 1', text: 'This is Note 1 content.'),
      Note(id: 1, title: 'Note 2', text: 'This is Note 2 content.'),
    ];
  }

  void updateNoteTitle(Note note, String title) {
    note.title = title;
    notifyListeners();
  }

  void updateNoteText(Note note, String text) {
    note.text = text;
    notifyListeners();
  }

  //get notes
  List<Note> getAllNotes() {
    return allNotes;
  }

  //add a new note
  void addNewNote(Note note) {
    allNotes.add(note);
    notifyListeners();
  }

  //update note
  void updateNote(Note note, String title, String text) {
    //go through list of all notes
    for (int i = 0; i < allNotes.length; i++) {
      //find the relevant note
      if (allNotes[i].id == note.id) {
        allNotes[i].text = text;
        allNotes[i].title = title;

        //check if both title and text are empty
        if (text.isEmpty && title.isEmpty) {
          deleteNote(allNotes[i]);
          return;
        }
      }
    }
    notifyListeners();
  }

  //delete note
  void deleteNote(Note note) {
    allNotes.remove(note);
    notifyListeners();
  }
}
