import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_list/home/data/models/todo_model.dart';

class TodosApi {
  FirebaseFirestore db = FirebaseFirestore.instance;

  FutureOr<List<Todo>> getAllTodos() async {
    late List<Todo> todos = [];

    await db.collection('todos').get().then((value) => {
      value.docs.forEach((element) {
        todos.add(Todo.fromJson(element.data(), elementId: element.id));
      })
    });
    return todos;
  }

  FutureOr<void> createTodo(Todo todo) async {
    await db.collection('todos').add(todo.toJson()).whenComplete(() => {});
  }

  FutureOr<void> updateTodo(Todo todoNew ) async {
    await db.collection('todos').doc(todoNew.id).update(todoNew.toJson());
  }
  
  FutureOr<void> updateState({required bool state, required String todoId}) async {
    await db.collection('todos').doc(todoId).update({'state': state});
  }

  FutureOr<void> deleteTodo({required String todoId}) async {
    await db.collection('todos').doc(todoId).delete();
  }
}