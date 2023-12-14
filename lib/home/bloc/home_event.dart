import '../data/models/todo_model.dart';

abstract class TodosEvent {}



class GetAllTodosEvent extends TodosEvent {}

class CreateTodoEvent extends TodosEvent {
  late Todo todo;

  CreateTodoEvent({required this.todo});
}


class EditTodoEvent extends TodosEvent {
  late Todo todoNew;

  EditTodoEvent({required this.todoNew});
}


class UpdateTodoStateEvent extends TodosEvent {
  UpdateTodoStateEvent({required this.state, required this.todoId});

  late bool state;
  late String todoId;
}


class DeleteTodoEvent extends TodosEvent {
  DeleteTodoEvent({required this.todoId});

  late String todoId;
}