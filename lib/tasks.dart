class Task {
  int ?id;
  String title;
  String description;

  Task({this.id, required this.title, required this.description});

  // Add a factory constructor to create a Task from a map
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }
}
