class TodoModel {
  final String toDoID;
  final String toDoTitle;
  final String toDoDescription;
  final bool isCompleted;

  TodoModel({
    required this.toDoID,
    required this.toDoTitle,
    required this.toDoDescription,
    required this.isCompleted,
  });

  Map<String, dynamic> toJson() {
    return {
      'toDoID': toDoID,
      'toDoTitle': toDoTitle,
      'toDoDescription': toDoDescription,
      'isCompleted': isCompleted,
    };
  }
}
