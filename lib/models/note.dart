class Note {
  final int? id;
  final String name;
  final int number;
  final bool recv_req;
  late bool used;

  Note({
    this.id,
    required this.name,
    required this.number,
    required this.recv_req,
    required this.used,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'number': number,
      'recv_req': recv_req ? 1 : 0,
      'used': used ? 1 : 0,
    };
  }

  static Note fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      name: map['name'],
      number: map['number'],
      recv_req: map['recv_req'] == 1,
      used: map['used'] == 1,
    );
  }
}
