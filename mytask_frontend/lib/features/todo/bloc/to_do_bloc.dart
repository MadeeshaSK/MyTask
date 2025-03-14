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
      await _homeServices.getUserData();
      emit(
        ToDoShowedSuccessState(
          toDoList: _todoServices.toDoList,
          userModel: _homeServices.userModel!,
        ),
      );
    } catch (e) {
      emit(ToDoShowedFailedState(errorMessage: e.toString()));
    }
  }
}
