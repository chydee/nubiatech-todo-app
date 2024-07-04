class Task {
  int? id;
  String description;
  bool isDone;

  Task({this.id, required this.description, this.isDone = false});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'description': description,
      'isDone': isDone ? 1 : 0,
    };

    if (id != null) {
      map['id'] = id;
    }

    return map;
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      description: map['description'],
      isDone: map['isDone'] == 1,
    );
  }
}
