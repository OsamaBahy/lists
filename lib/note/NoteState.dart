class note {
  final String title;
  final String description;
  final String category;

  note({
    required this.title,
    required this.description,
    required this.category,
  });
}

class NoteState {

  final List<note> notes;
  NoteState({required this.notes});

}