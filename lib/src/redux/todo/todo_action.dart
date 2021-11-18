import 'package:todo_app/src/model/todo.dart';

class UpdateTodos {
  final List<Todo> todos;

  UpdateTodos({this.todos});

  @override
  String toString() {
    return '${super.toString()} : {Todos count: ${todos.length}}';
  }
}

class GetIncompleteTodosCount{
  final int incompleteTodos;

  GetIncompleteTodosCount({this.incompleteTodos});

  @override
  String toString() {
    return '${super.toString()} : {Incomplete todos count: $incompleteTodos}';
  }
}

class GetCompleteTodosCount{
  final int completeTodos;

  GetCompleteTodosCount({this.completeTodos});

  @override
  String toString() {
    return '${super.toString()} : {Complete todos count: $completeTodos}';
  }
}

class SetCompleteAction {
  final Todo todo;

  SetCompleteAction({this.todo});

  @override
  String toString() {
    return '${super.toString()} : Title: ${todo.title}';
  }
}

class SetIncompleteAction {
  final Todo todo;
  final int index;

  SetIncompleteAction({this.todo, this.index});

  @override
  String toString() {
    return '${super.toString()} : {Title: ${todo.title}';
  }
}

class AddTodoAction {
  final Todo todo;

  AddTodoAction({this.todo});

  @override
  String toString() {
    return '${super.toString()} : Title: ${todo.title}';
  }
}