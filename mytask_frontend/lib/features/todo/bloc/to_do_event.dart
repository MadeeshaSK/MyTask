part of 'to_do_bloc.dart';

@immutable
sealed class ToDoEvent {}

// Event to add a new ToDo
class ToDoAddEvent extends ToDoEvent {
  final TodoModel toDoModel;
  ToDoAddEvent({required this.toDoModel});
}

// Event to show all ToDos
class ToDoShowAllEvent extends ToDoEvent {}
