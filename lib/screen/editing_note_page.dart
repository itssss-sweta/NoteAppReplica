import 'package:flutter/material.dart';
import 'package:noteappreplica/color%20palette/colors.dart';
import '../function/addnote.dart';
import 'package:provider/provider.dart';
import '../model/note.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class EditingNotePage extends StatefulWidget {
  final Note note;
  final bool isNewNote;

  const EditingNotePage({Key? key, required this.note, required this.isNewNote})
      : super(key: key);

  @override
  State<EditingNotePage> createState() => _EditingNotePageState();
}

class _EditingNotePageState extends State<EditingNotePage> {
  late TextEditingController _titleController = TextEditingController(text: '');
  late TextEditingController _textController = TextEditingController(text: '');
  File? image;
  OverlayEntry? overlayEntry;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note.title);
    _textController = TextEditingController(text: widget.note.text);

    if (widget.note.imagePath != null) {
      image = _getImage(widget.note.imagePath);
    }
  }

  File? _getImage(String? imagePath) {
    if (imagePath != null && imagePath.isNotEmpty) {
      return File(imagePath);
    }
    return null;
  }

  //add new note
  void addNewNote() {
    final noteData = Provider.of<NoteData>(context, listen: false);
    final title = _titleController.text;
    final text = _textController.text;
    //get id
    int id = noteData.getAllNotes().length;
    //add new note
    noteData.addNewNote(
      Note(text: text, id: id, title: title, imagePath: null),
    );
  }

  //update existing code
  void updateNote() {
    final noteData = Provider.of<NoteData>(context, listen: false);
    String text = _textController.text;
    String title = _titleController.text;

    if (text.isEmpty && title.isEmpty) {
      noteData.deleteNote(widget.note);
      return;
    }
    //update note
    noteData.updateNote(widget.note, title, text);
  }

  void showOverlay(BuildContext context) {
    final overlay = Overlay.of(context);

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 0,
        bottom: 0,
        left: 0,
        right: 0,
        child: GestureDetector(
          onTap: () {
            // Remove the overlay when tapped
            overlayEntry?.remove();
          },
          child: Container(
            color: Colors.transparent,
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    image = null; // Remove the image
                    widget.note.imagePath =
                        null; // Clear the image path in the Note object
                  });
                  overlayEntry?.remove(); // Remove the overlay
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: const CircleBorder(),
                ),
                child: const Icon(Icons.delete),
              ),
            ),
          ),
        ),
      ),
    );

    // Insert the overlay
    overlay.insert(overlayEntry!);
  }

  @override
  void dispose() {
    _textController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File pickedImage = File(pickedFile.path);
      setState(() {
        image = pickedImage;
        widget.note.imagePath = pickedImage.path;
      });
    }
  }

  void _updateNoteAndImage() {
    final noteData = Provider.of<NoteData>(context, listen: false);
    noteData.updateNoteTitle(widget.note, _titleController.text);
    //widget.note.imagePath = _textController.text;

    if (image != null) {
      widget.note.imagePath = image?.path;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.black,
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await _pickImage();
              _updateNoteAndImage();
              //Navigator.pop(context, true);
            },
            icon: const Icon(
              Icons.add_photo_alternate_outlined,
              color: Colors.black,
            ),
          ),
          IconButton(
            onPressed: () {
              if (widget.isNewNote &&
                  (_textController.text.isNotEmpty ||
                      _titleController.text.isNotEmpty)) {
                addNewNote();
              } else {
                updateNote();
              }

              _updateNoteAndImage();

              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.check,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Title',
                hintStyle: TextStyle(
                  fontSize: 20,
                  color: hintTextColor,
                ),
              ),
              controller: _titleController,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
          ),

          //editor
          Padding(
            padding: const EdgeInsets.all(25),
            child: TextField(
              controller: _textController,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(border: InputBorder.none),
              style: TextStyle(
                color: textColor,
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Stack(
            children: [
              if (image != null)
                GestureDetector(
                  onLongPress: () => showOverlay(context),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    width: 200,
                    child: Image.file(
                      image!,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
