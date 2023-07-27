class Note {
  String text;
  int? id;
  String title;
  String? imagePath;

  Note(
      {required this.text,
      required this.id,
      required this.title,
      this.imagePath});
}
