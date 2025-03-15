import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mytask_frontend/models/toDo_model.dart';

class TodoServices {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  // Add a new ToDo
  Future<void> addNewToDoToDatabase(TodoModel toDoModel) async {
    await _firestore
        .collection('Users')
        .doc(_auth.currentUser!.uid)
        .collection('ToDos')
        .doc(toDoModel.toDoID)
        .set(toDoModel.toJson());
  }

  List<TodoModel> toDoList = [];
  List<TodoModel> completedToDoList = [];

  // Show all ToDos
  Future<void> getAllToDos() async {
    toDoList.clear();
    QuerySnapshot querySnapshot =
        await _firestore
            .collection('Users')
            .doc(_auth.currentUser!.uid)
            .collection('ToDos')
            .get();
    for (var docs in querySnapshot.docs) {
      TodoModel toDoModelGetting = TodoModel(
        toDoID: docs['toDoID'],
        toDoTitle: docs['toDoTitle'],
        toDoDescription: docs['toDoDescription'],
        isCompleted: docs['isCompleted'],
      );
      toDoList.add(toDoModelGetting);
    }
  }

  // Edit a ToDo
  Future<void> editToDoInDatabase(TodoModel toDoModel) async {
    await _firestore
        .collection('Users')
        .doc(_auth.currentUser!.uid)
        .collection('ToDos')
        .doc(toDoModel.toDoID)
        .update(toDoModel.toJson());
  }

  // Delete a ToDo
  Future<void> deleteToDoFromDatabase(String toDoID) async {
    await _firestore
        .collection('Users')
        .doc(_auth.currentUser!.uid)
        .collection('ToDos')
        .doc(toDoID)
        .delete();
  }

  // Progress bar function
  Future<void> getAllCompletedToDos() async {
    completedToDoList.clear();
    QuerySnapshot querySnapshot =
        await _firestore
            .collection('Users')
            .doc(_auth.currentUser!.uid)
            .collection('ToDos')
            .get();
    for (var docs in querySnapshot.docs) {
      TodoModel toDoModelGetting = TodoModel(
        toDoID: docs['toDoID'],
        toDoTitle: docs['toDoTitle'],
        toDoDescription: docs['toDoDescription'],
        isCompleted: docs['isCompleted'],
      );
      if (toDoModelGetting.isCompleted == true) {
        completedToDoList.add(toDoModelGetting);
      }
    }
  }
}
