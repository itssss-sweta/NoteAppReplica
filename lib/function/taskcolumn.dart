import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:noteappreplica/function/addnote.dart';
import '../color palette/colors.dart';
import '../model/note.dart';

class TaskColumn extends StatelessWidget {
  final Note notes;
  final Function(Note) onDelete;
  final VoidCallback onTap;

  const TaskColumn(
      {super.key,
      required this.notes,
      required this.onDelete,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    final List<Note> allNotes =
        Provider.of<NoteData>(context, listen: false).getAllNotes();

    final int index = allNotes.indexOf(notes);
    final bool isLastItem = index == allNotes.length - 1;

    return Container(
      width: double.infinity,
      // padding: const EdgeInsets.only(top: 5),
      decoration: BoxDecoration(
        border: Border(
          bottom: isLastItem ? BorderSide.none : BorderSide(color: grey1),
        ),
      ),
      child: ListTile(
        title: Text(
          notes.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: textColor),
        ),
        subtitle: Text(
          notes.text,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: textColor),
        ),
        onTap: onTap,
        trailing: IconButton(
          onPressed: () => onDelete(notes),
          icon: Icon(
            Icons.delete,
            color: Colors.red.shade300,
          ),
        ),
      ),
    );
  }
}
