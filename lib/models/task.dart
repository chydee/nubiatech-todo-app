class Task {
  int id;
  String description;
  bool isDone;

  Task({required this.id, required this.description, this.isDone = false});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'description': description,
      'isDone': isDone ? 1 : 0,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      description: map['description'],
      isDone: map['isDone'] == 1,
    );
  }
}
