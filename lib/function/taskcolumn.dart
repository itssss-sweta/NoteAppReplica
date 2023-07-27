import 'package:flutter/material.dart';
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
    return Container(
      margin: const EdgeInsets.only(bottom: 10, left: 10),
      //padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          ListTile(
            title: Text(
              notes.title,
              style: TextStyle(color: textColor),
            ),
            subtitle: Text(
              notes.text,
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
        ],
      ),
    );
  }
}
