class Schedule {
  int id;
  final String title;
  final String difficulty;
  final String content;
  final String date;

  Schedule({this.id, this.title, this.difficulty, this.content, this.date});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'difficulty': difficulty,
      'content': content,
      'date': date,
    };
  }
}
