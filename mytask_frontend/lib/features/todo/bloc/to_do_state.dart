part of 'to_do_bloc.dart';

@immutable
sealed class ToDoState {}

final class ToDoInitial extends ToDoState {}

// Add a new ToDo
class ToDoAddingState extends ToDoState {}

class ToDoAddedSucessState extends ToDoState {}

class ToDoAddedFailedState extends ToDoState {
  final String errorMessage;
  ToDoAddedFailedState({required this.errorMessage});
}

// Show all ToDos
class ToDoShowingState extends ToDoState {}

class ToDoShowedSuccessState extends ToDoState {
  final List<TodoModel> toDoList;
  final UserModel userModel;
  ToDoShowedSuccessState({required this.toDoList, required this.userModel});
}

class ToDoShowedFailedState extends ToDoState {
  final String errorMessage;
  ToDoShowedFailedState({required this.errorMessage});
}
