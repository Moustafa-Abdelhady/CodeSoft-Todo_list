import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/home/bloc/home_event.dart';
import 'package:todo_list/home/bloc/home_state.dart';
import 'package:todo_list/home/data/todo_provider.dart';

import '../data/models/todo_model.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  TodosBloc() : super(InitialState()) {
    on<CreateTodoEvent>(_createTodo);
    on<GetAllTodosEvent>(_getAllTodos);
    on<EditTodoEvent>(_editTodo);
    on<UpdateTodoStateEvent>(_updateTodoState);
    on<DeleteTodoEvent>(_deleteTodo);
  }

  FutureOr<void> _getAllTodos(GetAllTodosEvent event, Emitter<TodosState> emit) async {
    emit(Loading());
    TodosApi api = TodosApi();
    List<Todo> todos = await api.getAllTodos();
    if (todos.isEmpty) {
      return emit(TodosIsEmpty());
    }
    emit(SuccessGettingTodos(todos: todos));
  }

  FutureOr<void> _createTodo(CreateTodoEvent event, Emitter<TodosState> emit) async {
    TodosApi api = TodosApi();
    await api.createTodo(event.todo);
    emit(SuccessCreateTodo());
  }

  FutureOr<void> _editTodo(EditTodoEvent event, Emitter<TodosState> emit) async {
    emit(Loading());
    TodosApi api = TodosApi();
    await api.updateTodo(event.todoNew);
    emit(SuccessEditTodo());
  }

  FutureOr<void> _updateTodoState(UpdateTodoStateEvent event, Emitter<TodosState> emit ) async {
    emit(Loading());
    TodosApi api = TodosApi();
    await api.updateState(state: event.state, todoId: event.todoId);
    emit(SuccessUpdateTodoState());
  }

  FutureOr<void> _deleteTodo(DeleteTodoEvent event, Emitter<TodosState> emit) async {
    emit(Loading());
    TodosApi api = TodosApi();
    await api.deleteTodo(todoId: event.todoId);
    emit(SuccessDeleteTodo());
  }
}
