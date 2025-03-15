import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mytask_frontend/models/toDo_model.dart';
import 'package:mytask_frontend/models/user_model.dart';
import 'package:mytask_frontend/services/home_services.dart';
import 'package:mytask_frontend/services/toDo_services.dart';

part 'to_do_event.dart';
part 'to_do_state.dart';

class ToDoBloc extends Bloc<ToDoEvent, ToDoState> {
  final TodoServices _todoServices = TodoServices();
  final HomeServices _homeServices = HomeServices();
  ToDoBloc() : super(ToDoInitial()) {
    on<ToDoAddEvent>(toDoAddEvent);
    on<ToDoShowAllEvent>(toDoShowAllEvent);
    on<ToDoEditEvent>(toDoEditEvent);
    on<ToDoDeleteEvent>(toDoDeleteEvent);
  }

  // Add a new ToDo
  FutureOr<void> toDoAddEvent(
    ToDoAddEvent event,
    Emitter<ToDoState> emit,
  ) async {
    try {
      emit(ToDoAddingState());
      await _todoServices.addNewToDoToDatabase(event.toDoModel);
      emit(ToDoAddedSucessState());
    } catch (e) {
      emit(ToDoAddedFailedState(errorMessage: e.toString()));
    }
  }

  // Show all ToDos
  FutureOr<void> toDoShowAllEvent(
    ToDoShowAllEvent event,
    Emitter<ToDoState> emit,
  ) async {
    try {
      emit(ToDoShowingState());
      await _todoServices.getAllToDos();
      await _todoServices.getAllCompletedToDos();
      await _homeServices.getUserData();
      emit(
        ToDoShowedSuccessState(
          toDoList: _todoServices.toDoList,
          userModel: _homeServices.userModel!,
          completedToDoList: _todoServices.completedToDoList,
        ),
      );
    } catch (e) {
      emit(ToDoShowedFailedState(errorMessage: e.toString()));
    }
  }

  // Edit a ToDo
  FutureOr<void> toDoEditEvent(
    ToDoEditEvent event,
    Emitter<ToDoState> emit,
  ) async {
    try {
      emit(ToDoEditingState());
      await _todoServices.editToDoInDatabase(event.toDoModel);
      emit(ToDoEditedSuccessState());
    } catch (e) {
      emit(ToDoEditedFailedState(errorMessage: e.toString()));
    }
  }

  // Delete a ToDo
  FutureOr<void> toDoDeleteEvent(
    ToDoDeleteEvent event,
    Emitter<ToDoState> emit,
  ) async {
    try {
      emit(ToDoDeletingState());
      await _todoServices.deleteToDoFromDatabase(event.toDoId);
      emit(ToDoDeletedSuccessState());
    } catch (e) {
      emit(ToDoDeletedFailedState(errorMessage: e.toString()));
    }
  }
}
