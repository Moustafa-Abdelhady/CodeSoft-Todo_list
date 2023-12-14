import '../data/models/todo_model.dart';

abstract class TodosState {}

class InitialState extends TodosState {}


class TodosIsEmpty extends TodosState {}

class SuccessGettingTodos extends TodosState {
  late List<Todo> todos;

  SuccessGettingTodos({required this.todos});
}

class Loading extends TodosState {}

class SuccessCreateTodo extends TodosState {}

class SuccessEditTodo extends TodosState {}

class FailureGettingTodos extends TodosState {}

class SuccessUpdateTodoState extends TodosState {}

class SuccessDeleteTodo extends TodosState {}