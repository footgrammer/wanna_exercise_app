class Board {
  final String boardId;
  final String type; // 운동 종류 [soccer, futsal, basketball, running)
  final String title; // 제목
  final String content; // 내용
  final DateTime date;
  final int timeFrom; // 시작시간
  final int timeTo; // 시작시간
  final String location; // 장소
  final String locationAddress; // 장소주소
  final int number; //모집인원

  Board({
    required this.boardId,
    required this.type,
    required this.title,
    required this.content,
    required this.date,
    required this.timeFrom,
    required this.timeTo,
    required this.location,
    required this.locationAddress,
    required this.number,
  });

  factory Board.fromJson(Map<String, dynamic> json) {
    return Board(
      boardId: json['boardId'] ?? '',
      type: json['type'],
      title: json['title'],
      content: json['content'],
      date: DateTime.parse(json['date'] as String),
      timeFrom: json['timeFrom'],
      timeTo: json['timeTo'],
      location: json['location'],
      locationAddress: json['locationAddress'],
      number: json['number'],
    );
  }

  Map<String, dynamic> toJson() => {
    'boardId': boardId,
    'type': type,
    'title': title,
    'content': content,
    'date': date.toIso8601String(),
    'timeFrom': timeFrom,
    'timeTo': timeTo,
    'location': location,
    'locationAddress': locationAddress,
    'number': number,
  };
}
