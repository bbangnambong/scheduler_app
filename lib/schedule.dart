class Schedule {
  final String title;
  final int difficulty;
  final String content;
  final String date;

  Schedule({this.title, this.difficulty, this.content, this.date});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'difficulty': difficulty,
      'content': content,
      'date': date,
    };
  }
}
